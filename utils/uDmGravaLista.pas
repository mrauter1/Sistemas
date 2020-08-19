unit uDmGravaLista;

interface

uses
  System.SysUtils, System.Classes, uConFirebird, uConSqlServer,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uAppConfig, Winapi.ShellAPI, Winapi.Windows;

type
  TDmGravaLista = class(TDataModule)
    QryListaSidicom: TFDQuery;
    QryListaReal: TFDQuery;
    QryListaSidicomCODLISTA: TStringField;
    QryListaSidicomCODPRODUTO: TStringField;
    QryListaSidicomPRECOCOMPRA: TBCDField;
    QryListaSidicomMARGEM: TBCDField;
    QryListaSidicomPRECOVENDA: TBCDField;
    QryListaSidicomPRECOANTERIOR: TBCDField;
    QryListaSidicomDATAALTERACAO: TDateField;
    QryListaSidicomHORAALTERACAO: TTimeField;
    QryListaSidicomDESCONTO: TCurrencyField;
    QryListaSidicomDESCONTOMAX: TCurrencyField;
    QryListaSidicomDESATIVADO: TStringField;
    QryListaSidicomPRECODOLAR: TBCDField;
    QryListaSidicomACRECIMOLISTA: TCurrencyField;
    QryListaSidicomCUSTOSLISTA: TCurrencyField;
    QryListaSidicomCODFAIXA_DESC_LOTE: TIntegerField;
    QryListaRealLucroBruto: TBCDField;
    QryListaRealImpostoFaturamento: TBCDField;
    QryListaRealapresentacao: TStringField;
    QryListaRealIDLog: TIntegerField;
    QryListaRealCODPRODUTO: TStringField;
    QryListaRealCodGrupoSub: TStringField;
    QryListaRealCodAplicacao: TStringField;
    QryListaRealComEmbalagem: TBooleanField;
    QryListaRealPreco: TBCDField;
    QryListaRealCodGrupo: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure LerEAtualizarListaDePrecoSidicom(NomeListaGoogle: String;
      CodListaSidicom: String);
    procedure LerListaGoogle(pNomeLista: String);
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizaPrecoListaSidicom(LucroBruto, ImpostoFaturamento, ICM, PisCofins, IPI: Double);
    class procedure AtualizaTodasListasDePreco;
  end;

var
  DmGravaLista: TDmGravaLista;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Utils;

{ TDmGravaLista }

procedure TDmGravaLista.LerListaGoogle(pNomeLista: String);
var
  FListaPrecoPy: String;
begin
  FListaPrecoPy:= IncludeTrailingPathDelimiter(AppConfig.PythonFilePath)+'AtualizaPrecosLista.py';

  if FileExists(AppConfig.PythonPath) and FileExists(FListaPrecoPy) then
  begin
    ExecAndWait(AppConfig.PythonPath, FListaPrecoPy+' '+pNomeLista, SW_Show, 120, ExtractFilePath(FListaPrecoPy));
//    ExecAndWait(AppConfig.PythonPath, FListaPrecoPy+' '+pNomeLista, SW_Show, 120);
    WriteLog('Monitor.log', 'Script para atualizar lista de preço incializado.');
  end
 else
    WriteLog('Monitor.log', 'Caminho do executável python ou arquivo '+FListaPrecoPy+' não encontrado!');
end;

procedure TDmGravaLista.AtualizaPrecoListaSidicom(LucroBruto, ImpostoFaturamento, ICM, PisCofins, IPI: Double);

  function RetornaPrecoCalculado: Double;
  var
    FIPI: Double;
  begin
    FIPI:= 0;

    if QryListaRealCodGrupo.AsString = '002' then
      FIPI:= IPI;

    // 1° Retira a margem e o imposto de faturamento da planilha para reinserir com os impostos;
    Result:= QryListaRealPreco.AsCurrency*(1-QryListaRealLucroBruto.AsFloat-QryListaRealImpostoFaturamento.AsFloat);

    // Adiciona Impostos e Margem
    Result:= Result / (1-(ICM+PisCofins+LucroBruto+ImpostoFaturamento));
    Result:= Result * (1+FIPI);
  end;

begin
  QryListaSidicom.First;
  while not QryListaSidicom.Eof do
  begin
    if QryListaReal.Locate('CODPRODUTO', QryListaSidicomCODPRODUTO.AsString, []) then
    begin
      QryListaSidicom.Edit;
      QryListaSidicomPRECOVENDA.AsCurrency:= RetornaPrecoCalculado;
      QryListaSidicomPRECOCOMPRA.AsCurrency:= QryListaSidicomPRECOVENDA.AsCurrency;
      QryListaSidicomDATAALTERACAO.AsDateTime:= Trunc(Now);

      QryListaSidicom.Post;
    end;
    QryListaSidicom.Next;
  end;
end;

procedure TDmGravaLista.LerEAtualizarListaDePrecoSidicom(NomeListaGoogle: String; CodListaSidicom: String);

  procedure ZerarPrecoLista;
  const
    cSql = 'UPDATE ListaPre SET PrecoVenda=0, PrecoCompra=0 where CodLista=''%s'' ';
  begin
     ConFirebird.ExecutaComando(Format(cSql, [CodListaSidicom]));
  end;

begin
  WriteLog('Monitor.log', Format('Iniciando script de atualização da lista remota %s para a lista do Sidicom %s', [NomeListaGoogle, CodListaSidicom]));
  LerListaGoogle(NomeListaGoogle);

  ZerarPrecoLista;

  QryListaSidicom.Close;
  QryListaSidicom.ParamByName('CodLista').AsString:= CodListaSidicom;
  QryListaSidicom.Open;

  QryListaReal.Close;
  QryListaReal.ParamByName('NomeLista').AsString:= NomeListaGoogle;
  QryListaReal.Open;

  QryListaReal.First;
  while not QryListaReal.Eof do
  begin
    if QryListaSidicom.Locate('CODPRODUTO', QryListaRealCodProduto.AsString, []) then
    begin
      QryListaSidicom.Edit;
      QryListaSidicomPRECOVENDA.AsCurrency:= QryListaRealPreco.AsCurrency;
      QryListaSidicomPRECOCOMPRA.AsCurrency:= QryListaRealPreco.AsCurrency;
      QryListaSidicomDATAALTERACAO.AsDateTime:= Trunc(Now);
      QryListaSidicom.Post;
    end;
    QryListaReal.Next;
  end;
end;



class procedure TDmGravaLista.AtualizaTodasListasDePreco;
var
  FDM: TDMGravaLista;
begin
  FDM:= TDmGravaLista.Create(nil);
  try
    FDM.LerEAtualizarListaDePrecoSidicom('IPC2725', '0004'); // ICM + Pis + Cofins = 27,25%
    FDM.LerEAtualizarListaDePrecoSidicom('IPC2125', '0005'); // ICM + Pis + Cofins = 21,25%
    FDM.LerEAtualizarListaDePrecoSidicom('IPC12', '0006'); // ICM + Pis + Cofins = 12%
    FDM.LerEAtualizarListaDePrecoSidicom('ND', '0007'); // ICM + Pis + Cofins = 0%
  finally
    FDM.Free;
  end;
end;

procedure TDmGravaLista.DataModuleCreate(Sender: TObject);
begin
{  if not QryListaReal.Active then
    QryListaReal.Open;

  if not QryListaSidicom.Active then
    QryListaSidicom.Open;    }

//  AtualizaPrecoListaSidicom(0.225, 0.042, 0.18, 0.0925, 0.10);

end;

end.
