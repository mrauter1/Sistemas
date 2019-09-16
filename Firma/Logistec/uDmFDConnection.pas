unit uDmFDConnection;

interface

uses
  System.SysUtils, System.Classes, IniFiles, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, Forms, FireDAC.Phys.PG, FireDAC.Phys.PGDef;

type
  TDataModule1 = class(TDataModule)
    FDConFirebird: TFDConnection;
    FDConPostgres: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ParseConnectionString(pConnectionStr: String; out pServer, pPort,
      pDatabase: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.ParseConnectionString(pConnectionStr: String; out pServer, pPort, pDatabase: String);
var
  fHasPort: Boolean;
  fIndex, fNextPos: Integer;

  function GetCount: Integer;
  begin
    if fNextPos = 0 then
      Result:= 99999
    else
      Result:= fNextPos-fIndex-1;

  end;
begin
  pServer:= '';
  pPort:= '';
  pDatabase:= '';

  fIndex:= 0;
  fNextPos:= Pos('/', pConnectionStr);

  fHasPort:= fNextPos > 0;
  if not fHasPort then
    fNextPos:= Pos(':', pConnectionStr);

  pServer:= Copy(pConnectionStr, fIndex, GetCount);

  fIndex:= fNextPos+1;

  if fHasPort then
  begin
    fNextPos:= Pos(':', pConnectionStr);
    pPort:= Copy(pConnectionStr, fIndex, GetCount);
    fIndex:= fNextPos+1;
  end;

  fNextPos:= 0;

  pDatabase:= Copy(pConnectionStr, fIndex, GetCount);
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
  ArqIni: TIniFile;
  FConStr, FServer, FPort, FDatabase: String;
begin
  FDConFirebird.Close;
  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      FConStr := ArqIni.ReadString('Banco', 'Dir', 'C:\Sidicom.new\Dados\Banco.fdb');
      ParseConnectionString(FConStr, FServer, FPort, FDatabase);

      FDConFirebird.Params.Values['Database']:= FDatabase;
      ArqIni.Free;
    end
  else
    FDConFirebird.Params.Values['Database']:= 'C:\Sidicom.new\Dados\Banco.fdb';

  FDConFirebird.Open;
end;

end.

