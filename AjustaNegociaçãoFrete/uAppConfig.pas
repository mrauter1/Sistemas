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

  finally
    FIniFile.Free;
  end;
end;

constructor TAppConfig.Create;
begin
  inherited;

  LerIniFile;
end;

initialization
  AppConfig:= TAppConfig.Create;

finalization
  AppConfig.Free;

end.
