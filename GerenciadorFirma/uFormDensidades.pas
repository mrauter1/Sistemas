unit uFormDensidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, uConFirebird, JSonConverter, Vcl.StdCtrls, dwsJSon, Vcl.ExtCtrls;

type
  TFormDensidades = class(TForm)
    DataSource1: TDataSource;
    CdsDensidade: TClientDataSet;
    CdsDensidadeCODGRUPOSUB: TStringField;
    CdsDensidadeNOMESUBGRUPO: TStringField;
    CdsDensidadeDENSIDADE: TFloatField;
    Memo1: TMemo;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    CdsTeste: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    FloatField1: TFloatField;
    DataSource2: TDataSource;
    Panel2: TPanel;
    Button2: TButton;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure AtualizaGrupos;
    procedure CarregaTabelaDensidade;
  public
    CdsInterno: TClientDataSet;
    { Public declarations }
  end;

{var
  FormDensidades: TFormDensidades;     }

implementation

{$R *.dfm}

{ TForm2 }

procedure TFormDensidades.AtualizaGrupos;
const
  cSql = 'SELECT CODGRUPOSUB, NOMESUBGRUPO '
       +  ' FROM GRUPOSUB '
       +  ' WHERE CODGRUPO = ''001'' ';
var
  fDataSet: TDataSet;
begin
  fDataSet:= ConFirebird.RetornaDataSet(cSql);
  try
    fDataSet.First;
    while not fDataSet.Eof do
    begin

      if CdsDensidade.Locate('CODGRUPOSUB', fDataSet.FieldByName('CODGRUPOSUB').AsString, []) then
        CdsDensidade.Edit
      else
        CdsDensidade.Append;

      CdsDensidadeCODGRUPOSUB.AsString:= fDataSet.FieldByName('CODGRUPOSUB').AsString;
      CdsDensidadeNOMESUBGRUPO.AsString:= fDataSet.FieldByName('NOMESUBGRUPO').AsString;
      CdsDensidade.Post;

      fDataSet.Next;
    end;
  finally
    fDataSet.Free;
  end;
end;

procedure TFormDensidades.Button1Click(Sender: TObject);
var
  FJsonArray: TDwsJsonArray;
begin
  TDataSetJSONConverter.UnMarshalToJSON(CdsDensidade, FJsonArray);
  try
    Memo1.Lines.Text:= FJsonArray.ToBeautifiedString();
  finally
    FJsonArray.Free;
  end;
end;

procedure TFormDensidades.Button2Click(Sender: TObject);
begin
//  CdsTeste.EmptyDataSet;
//  TJSONDataSetConverter.UnMarshalToDataSet((TDwsJsonArray.ParseString(Memo1.Lines.text) as TdwsJSonArray), CdsTeste)
  FreeAndNil(CdsInterno);
  CdsInterno:= TJSONDataSetConverter.ToNewDataSet((TDwsJsonArray.ParseString(Memo1.Lines.text) as TdwsJSonArray));
  DataSource2.DataSet:= CdsInterno;
end;

procedure TFormDensidades.CarregaTabelaDensidade;
begin
  if not CdsDensidade.Active then begin

    if FileExists(ExtractFilePath(Application.ExeName)+'TabelaDensidade.xml') then
      CdsDensidade.LoadFromFile(ExtractFilePath(Application.ExeName)+'TabelaDensidade.xml')
    else
      CdsDensidade.CreateDataSet;
  end;
end;

procedure TFormDensidades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CdsDensidade.MergeChangeLog;
  CdsDensidade.SaveToFile(ExtractFilePath(Application.ExeName)+'TabelaDensidade.xml', dfXml);
end;

procedure TFormDensidades.FormCreate(Sender: TObject);
begin
  CarregaTabelaDensidade;
  AtualizaGrupos;
  CdsTeste.CreateDataSet;
end;

end.
