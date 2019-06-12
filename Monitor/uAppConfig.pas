unit uAppConfig;

interface

uses
  IniFiles, SysUtils, Forms;

type
  TConnectionParams = record
    Server: String;
    Protocol: String;
    Port: Integer;
    Database: String;
  end;

  TGrupoUsuario = (puGerenteProducao, puDesenvolvedor);
  TGruposUsuarios = set of TGrupoUsuario;

  TAppConfig = class
    PastaUpdate: String;
    PythonPath: String;
    PythonFilePath: String;
    GruposUsuario: TGruposUsuarios;
    ConSqlServer: TConnectionParams;
    ConFirebird: TConnectionParams;

    const
      IniFile = 'Config.ini';
      ConfUsuario = 'Usuario.ini';

    constructor Create;
  private
    procedure LerIniFile;
    function LerConfigBanco(pIniFile: TIniFile; pSection: String): TConnectionParams;
    procedure LerConfUsuario;
  end;

var
  AppConfig: TAppConfig;

implementation

{ TAppConfig }

function TAppConfig.LerConfigBanco(pIniFile: TIniFile; pSection: String): TConnectionParams;
begin
  Result.Server:= pIniFile.ReadString(pSection, 'Server', '');
  Result.Protocol:= pIniFile.ReadString(pSection, 'Protocol', '');
  Result.Database:= pIniFile.ReadString(pSection, 'Database', '');
  Result.Port:= pIniFile.ReadInteger(pSection, 'Port', 0);
end;

procedure TAppConfig.LerIniFile;
var
  FIniFile: TIniFile;
begin
  GruposUsuario:= [];

  FIniFile:= TIniFile.Create(ExtractFilePath(Application.ExeName)+ IniFile);
  try
    PastaUpdate:= FIniFile.ReadString('GERAL', 'PastaUpdate', '');
    ConSqlServer:= LerConfigBanco(FIniFile, 'SQLSERVER');
    ConFirebird:= LerConfigBanco(FIniFile, 'FIREBIRD');

    PythonPath:= FIniFile.ReadString('PYTHON', 'Path', 'C:\ProgramData\Anaconda3\python.exe');
    PythonFilePath:= FIniFile.ReadString('PYTHON', 'FilePath', 'E:\SistemaGerenciador\ListaPrecos');

  finally
    FIniFile.Free;
  end;
end;

procedure TAppConfig.LerConfUsuario;
var
  FIniFile: TIniFile;
begin
  GruposUsuario:= [];

  FIniFile:= TIniFile.Create(ExtractFilePath(Application.ExeName)+ ConfUsuario);
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

  LerIniFile;
  LerConfUsuario;
end;

initialization
  AppConfig:= TAppConfig.Create;

finalization
  AppConfig.Free;

end.
