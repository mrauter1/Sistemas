unit uFormConversorLKG;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uFormDensidades, uConFirebird;

type
  TFormConversorLKG = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    CdsConversor: TClientDataSet;
    Panel1: TPanel;
    label1: TLabel;
    EditModelo: TEdit;
    btnOK: TBitBtn;
    lblName: TLabel;
    CdsConversorCODINSUMO: TStringField;
    CdsConversorNOMEINSUMO: TStringField;
    CdsConversorDENSIDADE: TFloatField;
    CdsConversorLITROS: TFloatField;
    EditMultiplicador: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditQuantidade: TEdit;
    EditVolumeLinha: TEdit;
    Label4: TLabel;
    CdsConversorKILOSTOTAL: TFloatField;
    CdsConversorKILOSPARCIAL: TFloatField;
    Panel2: TPanel;
    Label5: TLabel;
    EditDensidadeCalc: TEdit;
    Label6: TLabel;
    EditPesoTotal: TEdit;
    CdsConversorPERCENTVOLUME: TFloatField;
    CdsConversorPERCENTPESO: TFloatField;
    Label7: TLabel;
    EditQuantTotal: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure EditModeloExit(Sender: TObject);
  private
    FTotalLitros, FTotalKg: Double;
    procedure CarregaModelo;
    procedure CarregaInsumos(pCodModelo: String);
    { Private declarations }
  public
    function PegaDensidade(CodGrupoSub: String): Double;
    function LitroParaKg(const pDensidade, pVolume: Double): Double;
    function KgParaLitro(const pDensidade, pPeso: Double): Double;
    function UnidadeIsKilo(const pNomeUnidade: String): Boolean;
    function UnidadeIsLitro(const pNomeUnidade: String): Boolean;
  end;

var
  FormConversorLKG: TFormConversorLKG;

implementation

{$R *.dfm}

procedure TFormConversorLKG.btnOKClick(Sender: TObject);
begin
  CarregaInsumos(Trim(EditModelo.Text));
end;

function TFormConversorLKG.LitroParaKg(const pDensidade, pVolume: Double): Double;
begin
  Result:= pDensidade * pVolume;
end;

function TFormConversorLKG.KgParaLitro(const pDensidade, pPeso: Double): Double;
begin
  Result:= pPeso / pDensidade {/StrToFloat(EditMultiplicador.Text)};
end;

function TFormConversorLKG.UnidadeIsLitro(const pNomeUnidade: String): Boolean;
var
  fTemp: String;
begin
  fTemp:= UpperCase(Trim(pNomeUnidade));
  if (fTemp <> 'L') and
  (fTemp <> 'LT') and
  (fTemp <> 'LITROS') and
  (fTemp <> 'LITRO') then
     Result:= false
   else
     Result:= true;
end;

function TFormConversorLKG.UnidadeIsKilo(const pNomeUnidade: String): Boolean;
var
  fTemp: String;
begin
  fTemp:= UpperCase(Trim(pNomeUnidade));
  if (fTemp <> 'KG')and
  (fTemp <> 'KILOS') and
  (fTemp <> 'KILO') and
  (fTemp <> 'KILOGRAMA') and
  (fTemp <> 'KILOGRAMAS') then
     Result:= false
   else
     Result:= true;
end;

procedure TFormConversorLKG.CarregaInsumos(pCodModelo: String);
const
  cSql = 'SELECT I.CODMODELO, I.QUANTINSUMO, I.CODPRODUTO , P.APRESENTACAO, P.CODGRUPOSUB, P.NOMESUBUNIDADE '
       +  ' FROM INSUMOS_INSUMO I '
       +  ' INNER JOIN PRODUTO P ON P.CODPRODUTO = I.CODPRODUTO '
       +  ' WHERE I.CODMODELO = ''%s'' ';
var
  fDataSet: TDataSet;
  fSoma: double;


  procedure VerificaConsistencia;
  begin
    if not (UnidadeIsLitro(fDataset.FieldByName('NOMESUBUNIDADE').AsString)
      or UnidadeIsKilo(fDataset.FieldByName('NOMESUBUNIDADE').AsString)) then
    begin
      ShowMessage('Unidade Inválida: '+fDataSet.FieldByName('NOMESUBUNIDADE').AsString
       +', Cod: '+fDataSet.FieldByName('CODPRODUTO').AsString);
    end;

    fSoma:= fSoma + fDataSet.FieldByName('QUANTINSUMO').AsFloat;
  end;

  procedure CalculaQuantidades;
  begin
    if UnidadeIsLitro(fDataSet.FieldByName('NOMESUBUNIDADE').AsString) then begin
      CdsConversorLITROS.AsFloat:= fDataSet.FieldByName('QUANTINSUMO').AsFloat;

      CdsConversorKILOSTOTAL.AsFloat:= (CdsConversorLITROS.AsFloat * CdsConversorDENSIDADE.AsFloat
          * StrToFloat(EditMultiplicador.Text) * StrToFloat(EditQuantidade.Text));

      CdsConversorKILOSPARCIAL.AsFloat:= CdsConversorKILOSTOTAL.AsFloat -
        LitroParaKg(CdsConversorDENSIDADE.AsFloat, StrToFloat(EditVolumeLinha.Text));
    end
   else
    if UnidadeIsKilo(fDataSet.FieldByName('NOMESUBUNIDADE').AsString) then begin
      CdsConversorLITROS.AsFloat:= KgParaLitro(CdsConversorDENSIDADE.AsFloat, fDataSet.FieldByName('QUANTINSUMO').AsFloat);
      CdsConversorKILOSTOTAL.AsFloat:= fDataSet.FieldByName('QUANTINSUMO').AsFloat;
      CdsConversorKILOSPARCIAL.AsFloat:= CdsConversorKILOSTOTAL.AsFloat -
        LitroParaKg(CdsConversorDENSIDADE.AsFloat, StrToFloat(EditVolumeLinha.Text));
    end;
  end;
begin
  CdsConversor.EmptyDataSet;
  fSoma:= 0;
  fTotalKg:= 0;
// Verifica se a soma das quantidades fecha 100% e se a unidade é válida
  fDataSet:= ConFirebird.RetornaDataSet(Format(cSql, [pCodModelo]));
  try
    fDataSet.First;
    while not fDataSet.Eof do
    begin
      VerificaConsistencia;

      CdsConversor.Append;

      CdsConversorCODINSUMO.AsString:= fDataSet.FieldByName('CODPRODUTO').AsString;
      CdsConversorNOMEINSUMO.AsString:= fDataSet.FieldByName('APRESENTACAO').AsString;
      CdsConversorDENSIDADE.AsFloat:= PegaDensidade(fDataSet.FieldByName('CODGRUPOSUB').AsString);
      CalculaQuantidades;
      CdsConversorPERCENTVOLUME.AsFloat:= CdsConversorLITROS.AsFloat / FTotalLitros;
//      CdsConversorPERCENTPESO.AsFloat:= CdsConversorKILOSTOTAL.AsFloat / FTotalKg;

      CdsConversor.Post;

      fTotalKG:= FTotalKG + CdsConversorKILOSTOTAL.AsFloat;
      fDataSet.Next;
    end;

    CdsConversor.First;
    while not CdsConversor.Eof do
    begin
      CdsConversor.Edit;
      CdsConversorPERCENTPESO.AsFloat:= CdsConversorKILOSTOTAL.AsFloat / fTotalKG;
      CdsConversor.Post;
      CdsConversor.Next;
    end;

    if fSoma <> 1 then
      ShowMessage('Não fechou 100%: '+FloatToStr(fSoma));
  finally
    fDataSet.Free;
  end;
end;

procedure TFormConversorLKG.CarregaModelo;
var
  fDataSet: TDataSet;
begin
  fDataSet:= ConFirebird.RetornaDataSet('SELECT M.DESCRICAOMODELO, P.UNIDADEESTOQUE, P.NOMESUBUNIDADE FROM INSUMOS_MODELO M '
            +' INNER JOIN INSUMOS_ACABADO A ON A.CODMODELO = M.CODMODELO '
            +' INNER JOIN PRODUTO P ON P.CODPRODUTO = A.CODPRODUTO '
            +'WHERE M.CODMODELO = '''+Trim(EditModelo.Text)+''' ' );
  try
    if fDataSet.IsEmpty then
      ShowMessage('Modelo Inválido!')
    else
      begin
        lblName.Caption:= fDataSet.FieldByName('DESCRICAOMODELO').AsString;
      end;

    if not UnidadeIsLitro(fDataSet.FieldByName('NOMESUBUNIDADE').AsString) then
      raise Exception.Create('Unidade do model não é litro!');

    FTotalLitros:= fDataSet.FieldByName('UNIDADEESTOQUE').AsFloat;
    EditQuantTotal.Text:= FloatToStr(FTotalLitros);
  finally
    fDataSet.Free;
  end;

end;

procedure TFormConversorLKG.EditModeloExit(Sender: TObject);
begin
  CarregaModelo;
end;

function TFormConversorLKG.PegaDensidade(CodGrupoSub: String): Double;
begin
  if not FormDensidades.CdsDensidade.Locate('CODGRUPOSUB', CodGrupoSub, []) then
  begin
    ShowMessage('Não foi possível localizar o grupo '+CodGrupoSub+' na tabela de densidades!');
    Result:= 0;
  end
 else
  begin
    Result:= FormDensidades.CdsDensidadeDENSIDADE.AsFloat;
    if Result = 0 then
      ShowMessage('Densidade está zerada para o grupo '+CodGrupoSub);
  end;
end;

end.
