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
  private
    function ReadStreamToRawByteString(AIniFile: TIniFile; Section,
      Ident: String; Default: RawByteString=''): RawByteString;
    procedure WriteBinaryStreamFromRawByteString(AIniFile: TIniFile; Section,
      Ident: String; Value: RawByteString);
  protected
    procedure DoReadIniFile(AIniFile: TIniFile); virtual;
    function LerConfigBanco(pIniFile: TIniFile; pSection: String): TConnectionParams; virtual;
    procedure LerConfUsuario; virtual;
  public
    PastaUpdate: String;
    PythonPath: String;
    PythonFilePath: String;
    GruposUsuario: TGruposUsuarios;
    ConSqlServer: TConnectionParams;
    ConFirebird: TConnectionParams;

    UserName: RawByteString;
    EncryptedPassword: RawByteString;
    UserID: Integer;
//    property IniFile: TIniFile read FIniFile write FIniFile;

    IniFileName: String;
    UserConfFileName: String;

    function GetAppDataFolder: String;

    procedure SalvarUsuarioESenha(AUserName: String; AEncryptedPassword: RawByteString);
    procedure LerConfig; virtual;

    constructor Create;
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

  LerConfUsuario;
end;

function TAppConfig.GetAppDataFolder: String;
begin
  Result:= IncludeTrailingPathDelimiter(SysUtils.GetEnvironmentVariable('APPDATA'))+'ProjetoGerenciador\';
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

function TAppConfig.ReadStreamToRawByteString(AIniFile: TIniFile; Section, Ident: String; Default: RawByteString = ''): RawByteString;
var
  FStr: TStringStream;
begin
  Result:= Default;
  FStr:= TStringStream.Create;
  try
    if AIniFile.ReadBinaryStream(Section, Ident, FStr) > 0 then
    begin
      FStr.Position:= 0;
      Result:= FStr.ReadString(FStr.Size);
    end;
  finally
    FStr.Free;
  end;
end;

procedure TAppConfig.WriteBinaryStreamFromRawByteString(AIniFile: TIniFile; Section, Ident: String; Value: RawByteString);
var
  FStr: TStringStream;
begin
  FStr:= TStringStream.Create(Value);
  try
    FStr.Position:= 0;
    AIniFile.WriteBinaryStream(Section, Ident, FStr);
  finally
    FStr.Free;
  end;
end;

procedure TAppConfig.LerConfUsuario;
var
  FIniFile: TIniFile;
  FStr: TStringStream;
begin
  GruposUsuario:= [];

  FIniFile:= TIniFile.Create(GetAppDataFolder+UserConfFileName);
  try
    if FIniFile.ReadBool('USUARIO', 'PRODUCAO', False) then
      Include(GruposUsuario, puGerenteProducao);

    if FIniFile.ReadBool('USUARIO', 'DESENVOLVEDOR', False) then
      Include(GruposUsuario, puDesenvolvedor);

    UserName:= ReadStreamToRawByteString(FIniFile, 'USUARIO', 'UserName', '');
    EncryptedPassword:= ReadStreamToRawByteString(FIniFile, 'USUARIO', 'Senha', '');
  finally
    FIniFile.Free;
  end;
end;

procedure TAppConfig.SalvarUsuarioESenha(AUserName: String;
  AEncryptedPassword: RawByteString);
var
  FIniFile: TIniFile;
begin
  if not TDirectory.Exists(GetAppDataFolder) then
    TDirectory.CreateDirectory(GetAppDataFolder);

  FIniFile:= TIniFile.Create(GetAppDataFolder+UserConfFileName);
  try
    WriteBinaryStreamFromRawByteString(FIniFile, 'USUARIO', 'UserName', AUserName);
    WriteBinaryStreamFromRawByteString(FIniFile, 'USUARIO', 'Senha', AEncryptedPassword);
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
end;

initialization
  AppConfig:= TAppConfig.Create;

finalization
  AppConfig.Free;

end.
