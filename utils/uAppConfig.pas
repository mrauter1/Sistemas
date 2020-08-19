unit uAppConfig;

interface

uses
  IniFiles, SysUtils, Forms;

type
  TGrupoUsuario = (puGerenteProducao, puDesenvolvedor);
  TGruposUsuarios = set of TGrupoUsuario;

TConnectionParams = record
    Server: String;
    Protocol: String;
    Port: Integer;
    Database: String;
  end;

  TAppConfig = class
  protected
    procedure DoReadIniFile(AIniFile: TIniFile); virtual;
    procedure LerConfig; virtual;
    function LerConfigBanco(pIniFile: TIniFile; pSection: String): TConnectionParams; virtual;
    procedure LerConfUsuario; virtual;
  public
    PastaUpdate: String;
    PythonPath: String;
    PythonFilePath: String;
    GruposUsuario: TGruposUsuarios;
    ConSqlServer: TConnectionParams;
    ConFirebird: TConnectionParams;
//    property IniFile: TIniFile read FIniFile write FIniFile;

    IniFileName: String;
    UserConfFileName: String;

    constructor Create;
    destructor Destroy; override;
  end;

var
  AppConfig: TAppConfig;

implementation

{ TAppConfig }

destructor TAppConfig.Destroy;
begin

  inherited;
end;

function TAppConfig.LerConfigBanco(pIniFile: TIniFile; pSection: String): TConnectionParams;
begin
  Result.Server:= pIniFile.ReadString(pSection, 'Server', '');
  Result.Protocol:= pIniFile.ReadString(pSection, 'Protocol', '');
  Result.Database:= pIniFile.ReadString(pSection, 'Database', '');
  Result.Port:= pIniFile.ReadInteger(pSection, 'Port', 0);
end;

procedure TAppConfig.DoReadIniFile(AIniFile: TIniFile);
begin
  PastaUpdate:= AIniFile.ReadString('GERAL', 'PastaUpdate', '');
  ConSqlServer:= LerConfigBanco(AIniFile, 'SQLSERVER');
  ConFirebird:= LerConfigBanco(AIniFile, 'FIREBIRD');

  PythonPath:= AIniFile.ReadString('PYTHON', 'Path', 'C:\ProgramData\Anaconda3\python.exe');
  PythonFilePath:= AIniFile.ReadString('PYTHON', 'FilePath', 'E:\SistemaGerenciador\ListaPrecos');
end;

procedure TAppConfig.LerConfig;
var
  FIniFile: TIniFile;
begin
  GruposUsuario:= [];

  FIniFile:= TIniFile.Create(ExtractFilePath(Application.ExeName)+ IniFileName);
  try
    DoReadIniFile(FIniFile);
  finally
    FIniFile.Free;
  end;
end;

procedure TAppConfig.LerConfUsuario;
var
  FIniFile: TIniFile;
begin
  GruposUsuario:= [];

  FIniFile:= TIniFile.Create(ExtractFilePath(Application.ExeName)+ UserConfFileName);
  try
    if FIniFile.ReadBool('USUARIO', 'PRODUCAO', False) then
      Include(GruposUsuario, puGerenteProducao);

    if FIniFile.ReadBool('USUARIO', 'DESENVOLVEDOR', False) then
      Include(GruposUsuario, puDesenvolvedor);

  finally
    FIniFile.Free;
  end;
end;

constructor TAppConfig.Create;
begin
  inherited;

  IniFileName:= 'Config.ini';
  UserConfFileName:= 'Usuario.ini';

  LerConfig;
  LerConfUsuario;
end;

initialization
  AppConfig:= TAppConfig.Create;

finalization
  AppConfig.Free;

end.
