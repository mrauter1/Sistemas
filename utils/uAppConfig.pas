unit uAppConfig;

interface

uses
  IniFiles, SysUtils, Forms, Ladder.Types;

type
  TAppConfig = class
  private

  protected
    procedure DoReadIniFile(AIniFile: TIniFile); virtual;
    function LerConfigBanco(pIniFile: TIniFile; pSection: String): TConnectionParams; virtual;
  public
//    User: TUsuario;
    PastaUpdate: String;
    PythonPath: String;
    PythonFilePath: String;

    ConSqlServer: TConnectionParams;
    ConFirebird: TConnectionParams;

//    property IniFile: TIniFile read FIniFile write FIniFile;

    IniFileName: String;
    UserConfFileName: String;

    procedure LerConfig; virtual;

    procedure Inicializar; virtual;

    constructor Create; virtual;
    destructor Destroy; override;
  end;

var
  AppConfig: TAppConfig;

implementation

uses
  Classes, IOUTils;

{ TAppConfig }

destructor TAppConfig.Destroy;
begin

  inherited;
end;

function TAppConfig.LerConfigBanco(pIniFile: TIniFile; pSection: String): TConnectionParams;
begin
  Result.DriverID:= pIniFile.ReadString(pSection, 'DriverID', '');
  Result.Server:= pIniFile.ReadString(pSection, 'Server', '');
  Result.Protocol:= pIniFile.ReadString(pSection, 'Protocol', '');
  Result.Database:= pIniFile.ReadString(pSection, 'Database', '');
  Result.Port:= pIniFile.ReadInteger(pSection, 'Port', 0);
end;

procedure TAppConfig.DoReadIniFile(AIniFile: TIniFile);
begin
  PastaUpdate:= AIniFile.ReadString('GERAL', 'PastaUpdate', '');
  ConSqlServer:= LerConfigBanco(AIniFile, 'SQLSERVER');
  ConSqlServer.DriverID:= 'MSSQL';
  ConSqlServer.User:= 'Gerenciador';
  ConSqlServer.Password:= 'ProjetoGerenciador!@0';
  ConFirebird:= LerConfigBanco(AIniFile, 'FIREBIRD');
  ConFirebird.DriverID:= 'FB';
  ConFirebird.User:= 'SYSDBA';
  ConFirebird.Password:='masterkey';

  PythonPath:= AIniFile.ReadString('PYTHON', 'Path', 'C:\ProgramData\Anaconda3\python.exe');
  PythonFilePath:= AIniFile.ReadString('PYTHON', 'FilePath', 'E:\SistemaGerenciador\ListaPrecos');

//  LerConfUsuario;
end;


procedure TAppConfig.Inicializar;
begin
  LerConfig;
end;

procedure TAppConfig.LerConfig;
var
  FIniFile: TIniFile;
begin
  FIniFile:= TIniFile.Create(ExtractFilePath(Application.ExeName)+ IniFileName);
  try
    DoReadIniFile(FIniFile);
  finally
    FIniFile.Free;
  end;
end;

constructor TAppConfig.Create;
begin
  inherited;
  IniFileName:= 'Config.ini';
end;

end.
