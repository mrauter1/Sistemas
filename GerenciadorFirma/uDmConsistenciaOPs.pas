unit uDmConsistenciaOPs;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, uDmSqlUtils,
  Data.FMTBcd, Datasnap.Provider, Data.SqlExpr, uFormConversorLKG, dialogs;

type
  TDMConsistenciaOPs = class(TDataModule)
    CdsOPs: TClientDataSet;
    SqlOPs: TSQLQuery;
    PrvOPs: TDataSetProvider;
    CdsOPsCODORDEMPRODUCAO: TStringField;
    CdsOPsCODFILIAL: TStringField;
    CdsOPsSITUACAOOP: TStringField;
    CdsOPsDATAOP: TDateField;
    CdsOPsDATAPRONTO: TDateField;
    CdsOPsCONTROLE: TStringField;
    CdsOPsRESPONSAVEL: TStringField;
    CdsOPsOBSERVACAO: TMemoField;
    CdsOPsCODCONFIG: TIntegerField;
    CdsOPsCODMODELO: TIntegerField;
    CdsMovAcabado: TClientDataSet;
    SqlMovAcabado: TSQLQuery;
    PrvMovAcabado: TDataSetProvider;
    CdsMovInsumos: TClientDataSet;
    PrvMovInsumos: TDataSetProvider;
    SqlMovInsumos: TSQLQuery;
    CdsModeloInsumo: TClientDataSet;
    CdsMovAcabadoCODCOMPROVANTE: TStringField;
    CdsMovAcabadoCODPRODUTO: TStringField;
    CdsMovAcabadoQUANTATENDIDA: TFMTBCDField;
    CdsMovAcabadoCHAVENFPRO: TStringField;
    CdsMovAcabadoCODGRUPOSUB: TStringField;
    CdsMovInsumosCHAVENFPRO: TStringField;
    CdsMovInsumosCODCOMPROVANTE: TStringField;
    CdsMovInsumosCODPRODUTO: TStringField;
    CdsMovInsumosCODGRUPOSUB: TStringField;
    CdsMovInsumosQUANTATENDIDA: TFMTBCDField;
    CdsModeloInsumoCODOP: TStringField;
    CdsModeloInsumoQUANTINSUMO: TFloatField;
    CdsModeloInsumoUNIDADE: TStringField;
    CdsModeloInsumoQUANTKG: TFloatField;
    CdsModeloInsumoCODPRODUTO: TStringField;
    CdsModeloInsumoCODGRUPOSUB: TStringField;
    CdsMovAcabadoUNIDADEESTOQUE: TIntegerField;
    CdsMovAcabadoUNIDADE: TStringField;
    CdsMovAcabadoPESO: TFMTBCDField;
    CdsMovInsumosPESO: TFMTBCDField;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure CarregaOPs(pDataIni, pDataFim: TDateTime);
    procedure CarregaCdsModeloInsumo(CodModelo: Integer; pQuant: Double);
    procedure ComparaModeloELancado(pCodOp: String);
    procedure OpComErro(pNumOp: string);
  public
    { Public declarations }
  end;

var
  DMConsistenciaOPs: TDMConsistenciaOPs;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDMConsistenciaOPs.CarregaOPs(pDataIni, pDataFim: TDateTime);
begin
  if CdsOPs.Active then
    CdsOPs.Close;

  SqlOPs.ParamByName('DATAINI').AsDateTime:= pDataIni;
  SqlOPs.ParamByName('DATAINI').AsDateTime:= pDataFim;

  CdsOPs.Open;
end;

procedure TDMConsistenciaOPs.ComparaModeloELancado(pCodOp: String);
begin
  CdsMovAcabado.Close;
  SqlMovAcabado.ParamByName('CODORDEMPRODUCAO').AsString:= pCodOp;
  CdsMovAcabado.Open;

  CdsMovInsumos.Close;
  SqlMovInsumos.ParamByName('CODORDEMPRODUCAO').AsString:= pCodOp;
  CdsMovInsumos.Open;

  CarregaCdsModeloInsumo(CdsOPsCODMODELO.AsInteger, CdsMovAcabadoQUANTATENDIDA.AsFloat/CdsMovAcabadoUnidadeEstoque.AsFloat);

  while not CdsMovInsumos.Eof do
  begin
  // Apenas verifica produtos industrializados e materia prima
    if not ((CdsMovInsumosCODGRUPOSUB.AsString = '001') or
        (CdsMovInsumosCODGRUPOSUB.AsString = '002')) then
      continue;

   // Se a diferença de peso for maior que 1% tem erro
    if (Abs(1-(CdsMovInsumosPESO.AsFloat/CdsModeloInsumoQUANTKG.AsFloat)) > 0.01) then
    begin
      OpComErro(pCodOp);

    end;

    CdsMovInsumos.Next;
  end;
end;

procedure TDMConsistenciaOPs.CarregaCdsModeloInsumo(CodModelo: Integer; pQuant: Double);
var
  fSqlQuery: TDataSet;
begin
  CdsModeloInsumo.EmptyDataSet;
  fSqlQuery:= DmSqlUtils.RetornaDataSet(
    'SELECT II.*, P.CODGRUPOSUB, P.PESO, P.UNIDADEESTOQUE, P.UNIDADE '
   + ' FROM INSUMOS_INSUMO II '
   + ' INNER JOIN PRODUTO P ON P.CODPRODUTO = II.CODPRODUTO '
   + ' WHERE II.CODMODELO = '+IntToStr(CodModelo));
  try
    fSqlQuery.First;
    while not fSqlQuery.Eof do begin
      CdsModeloInsumo.Append;
      CdsModeloInsumo.FieldByName('CODPRODUTO').AsString:= fSqlQuery.FieldByName('CODPRODUTO').AsString;
      CdsModeloInsumo.FieldByName('QUANTINSUMO').AsFloat:= fSqlQuery.FieldByName('QUANTINSUMO').AsFloat * pQuant;
      if FormConversorLKG.unidadeIsKilo(fSqlQuery.FieldByName('UNIDADE').AsString) then
        CdsModeloInsumo.FieldByName('UNIDADE').AsString:= 'KG'
      else if FormConversorLKG.unidadeIsLitro(fSqlQuery.FieldByName('UNIDADE').AsString) then
        CdsModeloInsumo.FieldByName('UNIDADE').AsString:= 'L'
      else CdsModeloInsumo.FieldByName('UNIDADE').AsString:= fSqlQuery.FieldByName('UNIDADE').AsString;

      CdsModeloInsumo.FieldByName('UNIDADEESTOQUE').AsInteger:= fSqlQuery.FieldByName('UNIDADEESTOQUE').AsInteger;
      CdsModeloInsumo.FieldByName('CODGRUPOSUB').AsString:= fSqlQuery.FieldByName('CODGRUPOSUB').AsString;

      CdsModeloInsumo.FieldByName('PESO').AsFloat:= (fSqlQuery.FieldByName('PESO').AsFloat /
            CdsModeloInsumo.FieldByName('UNIDADEESTOQUE').AsInteger) * CdsModeloInsumo.FieldByName('QUANTINSUMO').AsFloat ;

      CdsModeloInsumo.Post;
      fSqlQuery.Next;
    end;
  finally
    fSqlQuery.Free;
  end;
end;

procedure TDMConsistenciaOPs.DataModuleCreate(Sender: TObject);
begin
  CdsModeloInsumo.CreateDataSet;
end;

procedure TDMConsistenciaOPs.OpComErro(pNumOp: string);
begin
  ShowMessage('OP num: '+pNumOP+' com erro!');
end;

end.
