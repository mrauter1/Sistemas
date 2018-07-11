unit uDmCon;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  IniFiles, Forms;

type
  TDmCon = class(TDataModule)
    FDConSqlServer: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function RetornaFDQuery(AOwner: TComponent; Sql: String; pAbrirDataSet: Boolean = True): TFDQuery;

    // transforma um field do tipo fkCalculated em fkLookup
    procedure TransformaEmLookup(pField: TField; pSql: String);

  end;

  procedure ReopenDataSet(pDataSet: TDataSet);

// Field[0] = keyfield; Field[1] = ResulField

var
  DmCon: TDmCon;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure ReopenDataSet(pDataSet: TDataSet);
begin
  if pDataSet.Active then
    pDataSet.Close;

  pDataSet.Open;
end;

procedure TDmCon.DataModuleCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  FDConSqlServer.Close;
  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      FDConSqlServer.Params.Values['Server'] :=
          ArqIni.ReadString('DBLOGI', 'Dir', FDConSqlServer.Params.Values['Server']);
      FDConSqlServer.Params.Values['Database'] :=
          ArqIni.ReadString('DBLOGI', 'Dir', FDConSqlServer.Params.Values['Database']);
      ArqIni.Free;
    end;

  FDConSqlServer.Open;
end;

function TDmCon.RetornaFDQuery(AOwner: TComponent; Sql: String; pAbrirDataSet: Boolean = True): TFDQuery;
var
  fQry: TFDQuery;
begin
  fQry:= TFDQuery.Create(AOwner);
  try
    fQry.Connection:= FDConSqlServer;

    fQry.SQL.Text:= Sql;

    if pAbrirDataSet then
      fQry.Open;
  except
    fQry.Free;
    raise;
  end;

  Result:= fQry;
end;

procedure TDmCon.TransformaEmLookup(pField: TField; pSql: String);
var
  fQry: TFDQuery;
begin
  if pField.FieldKind <> fkCalculated then
    raise Exception.Create('Erro TDmCon.TransformaLookup: Field deve ter a propriedade FieldKind = fkCalculated!');

  fQry:= RetornaFDQuery(pField, pSql, True);
  if fQry.Fields.Count < 2 then
  begin
    fQry.Free;
    raise Exception.Create('Erro TDmCon.TransformaLookup: Query deve retornar dois campos! Qry: '+pSql);
  end;

  pField.FieldKind:= fkLookup;
  pField.Lookup:= True;
  pField.LookupDataSet:= fQry;
  pField.LookupKeyFields:= fQry.Fields[0].FieldName;
  pField.KeyFields:= fQry.Fields[0].FieldName;
  pField.LookupResultField:= fQry.Fields[1].FieldName;
end;

end.
