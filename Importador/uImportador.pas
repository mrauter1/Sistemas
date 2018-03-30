unit uImportador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXFirebird, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, Strutils, Types, IniFiles;

type
  TForm1 = class(TForm)
    ConSidicom: TSQLConnection;
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    EditArquivo: TEdit;
    SpeedButton1: TSpeedButton;
    EditCodTransp: TEdit;
    DBGrid1: TDBGrid;
    Cds: TClientDataSet;
    CdsUF: TStringField;
    Cdsdestino: TStringField;
    CdsfretePorKG: TFloatField;
    CdsfreteValor: TFloatField;
    CdsSecCat: TFloatField;
    CdsPedagio: TFloatField;
    dts: TDataSource;
    CdsCodTransp: TIntegerField;
    Button2: TButton;
    CdsCod: TIntegerField;
    CustoFrete: TSQLTable;
    CustoFreteCOD: TIntegerField;
    CustoFreteCODTRANSP: TIntegerField;
    CustoFreteUF: TStringField;
    CustoFreteDESTINO: TStringField;
    CustoFreteFRETEKG: TSingleField;
    CustoFretePERCFRETEVALOR: TSingleField;
    CustoFreteSECCAT: TSingleField;
    CustoFretePEDAGIOPOR100: TSingleField;
    FreteMin: TSQLTable;
    FreteMinCODFRETE: TIntegerField;
    FreteMinPESOMIN: TSingleField;
    FreteMinPESOMAX: TSingleField;
    FreteMinVALOR: TSingleField;
    Query: TSQLQuery;
    Cdsfrete10kg: TFloatField;
    Cdsfrete20kg: TFloatField;
    Cdsfrete30kg: TFloatField;
    Cdsfrete50kg: TFloatField;
    Cdsfrete70kg: TFloatField;
    Cdsfrete100kg: TFloatField;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function GetValor(s: String): Double;
    procedure AddFreteMin(pCod: Integer; pPesoMin, pPesoMax, pValor: Double);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.GetValor(s: String): Double;
begin
  try
    Result:= StrToFloat(s);
  except
    Result:= 0;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  F: TextFile;
  s: String;
  FReg: TStringDynArray;
  Cod: Integer;
begin
  Cod:= 1;
  AssignFile(F, EditArquivo.Text);
  Reset(F);
  while not EOF(F) do
  begin
    Cds.Append;
    Readln(F, s);
    FReg:= SplitString(s, ';');
    CdsCod.AsInteger:= Cod;
    CdsCODTransp.AsInteger:= StrToInt(EditCodTransp.Text);
    CdsUF.AsString:= FReg[0];
    Cdsdestino.AsString:= FReg[1];
    CdsFrete10kg.AsFloat:= GetValor(FReg[2]);
    CdsFrete20kg.AsFloat:= GetValor(FReg[3]);
    CdsFrete30kg.AsFloat:= GetValor(FReg[4]);
    CdsFrete50kg.AsFloat:= GetValor(FReg[5]);
    CdsFrete70kg.AsFloat:= GetValor(FReg[6]);
    CdsFrete100kg.AsFloat:= GetValor(FReg[7]);
    CdsfretePorKG.AsFloat:= GetValor(FReg[8]);
    CdsfreteValor.AsFloat:= GetValor(FReg[9]);
    CdsPedagio.AsFloat:= GetValor(FReg[10])*10;
    Cds.Post;
    inc(Cod);
  end;
  CloseFile(F);
end;

procedure TForm1.AddFreteMin(pCod: Integer; pPesoMin, pPesoMax, pValor: Double);
begin
    Query.SQL.Text:= 'INSERT INTO FRETEMIN (CODFRETE, PESOMIN, PESOMAX, VALOR) '
      + ' VALUES ('+IntToStr(pCod)+', '
      + FloatToStr(pPesoMin)+', '
      + FloatToStr(pPesoMax)+', '
      + FloatToStr(pValor)+')';
    Query.ExecSQL(True);
{  FreteMin.Insert;
  FreteMinCODFRETE.AsInteger:= pCod;
  FreteMinPESOMIN.AsFloat:= pPesoMin;
  FreteMinPESOMAX.AsFloat:= pPesoMax;
  FreteMinVALOR.AsFloat:= pValor;
  FreteMin.Post;    }
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  oldSeparator: char;
begin
  oldSeparator:= DecimalSeparator;
  DecimalSeparator:= '.';

  if (MessageDlg('Ao salvar todos os dados anteriores serão apagados. Deseja continuar?',
        mtConfirmation, mbYesNo, 0) = mrNo) then abort;

  Query.SQL.Text:= 'Delete from CUSTOFRETE WHERE CODTRANSP = '+Trim(EditCodTransp.Text);
  Query.ExecSQL(True);
  Query.SQL.Text:= 'Delete from CUSTOFRETE WHERE CODTRANSP = '+Trim(EditCodTransp.Text);
  Query.ExecSQL(True);
//  ConSidicom.Commit();

  CustoFrete.Active:= True;
  FreteMin.Active:= True;

  Cds.First;
  while not Cds.Eof do
  begin
    Query.SQL.Text:= 'INSERT INTO CUSTOFRETE (COD, CODTRANSP, UF, DESTINO, FRETEKG, PERCFRETEVALOR, '
      + 'SECCAT, PEDAGIOPOR100, VALGRISMIN, PERCGRISVAL, VALOUTROS) '
      + ' VALUES ('+CdsCod.AsString+', '
      + CdsCodTransp.AsString+', '
      + QuotedStr(CdsUF.AsString)+', '
      + QuotedStr(CdsDestino.AsString)+', '
      + CdsfretePorKG.AsString+', '
      + CdsfreteValor.AsString
      +', 0, '
      + CdsPedagio.AsString+', '
      + '7.8, '
      + '0.3, '
      + '3.62)';
    Query.ExecSQL(True);
{    CustoFrete.Insert;
    CustoFreteCOD.AsInteger:= CdsCod.AsInteger;
    CustoFreteCODTRANSP.AsInteger:= CdsCodTransp.AsInteger;
    CustoFreteUF.AsString:= CdsUF.AsString;
    CustoFreteDESTINO.AsString:= CdsDestino.AsString;
    CustoFreteFRETEKG.AsFloat:= CdsfretePorKG.AsFloat;
    CustoFretePERCFRETEVALOR.AsFloat:= CdsfreteValor.AsFloat;
    CustoFreteSECCAT.AsFloat:= CdsSecCat.AsFloat;
    CustoFretePEDAGIOPOR100.AsFloat:= CdsPedagio.AsFloat;
    CustoFrete.Post;           }
    AddFreteMin(CdsCod.AsInteger, 0, 10, Cdsfrete10kg.AsFloat);
    AddFreteMin(CdsCod.AsInteger, 0, 20, Cdsfrete20kg.AsFloat);
    AddFreteMin(CdsCod.AsInteger, 0, 30, Cdsfrete30kg.AsFloat);
    AddFreteMin(CdsCod.AsInteger, 0, 50, Cdsfrete50kg.AsFloat);
    AddFreteMin(CdsCod.AsInteger, 0, 70, Cdsfrete70kg.AsFloat);
    AddFreteMin(CdsCod.AsInteger, 0, 100, Cdsfrete100kg.AsFloat);
    cDS.Next;
  end;
  DecimalSeparator:= oldSeparator;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DecimalSeparator:= ',';
end;

end.
