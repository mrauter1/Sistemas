unit uConSidicom;

interface

uses
  System.SysUtils, System.Classes, uDmSqlUtils, Data.DBXFirebird, Data.DB,
  Data.SqlExpr, Inifiles, Forms;

type
  TDMConSidicom = class(TDmSqlUtils)
    ConSidicom: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMConSidicom: TDMConSidicom;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDMConSidicom.DataModuleCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  FSqlConnection:= ConSidicom;

  inherited;

  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      ConSidicom.Params.Values['Database'] :=
          ArqIni.ReadString('Banco', 'Dir', 'C:\Sidicom.new\Dados\Banco.fdb');
      ArqIni.Free;
    end
  else
    ConSidicom.Params.Values['Database']:= 'C:\Sidicom.new\Dados\Banco.fdb';

  ConSidicom.Open;
end;

end.
