unit uGerenciadorConfig;

interface

uses
  IniFiles, System.IOUtils, System.Classes, System.SysUtils, uAppConfig, UserModel,
  Ladder.ORM.Dao, Root;

type
  TGrupoUsuario = (puGerenteProducao, puDesenvolvedor);
  TGruposUsuarios = set of TGrupoUsuario;

  TGerenciadorConfig = class(TAppConfig)
  private
    FUserID: Integer;
    FUsuario: TUsuario;
    function ReadStreamToRawByteString(AIniFile: TIniFile; Section, Ident: String; Default: RawByteString=''): RawByteString;
    procedure WriteBinaryStreamFromRawByteString(AIniFile: TIniFile; Section,
      Ident: String; Value: RawByteString);
    procedure SetUserID(const Value: Integer);
  public
    UserConfFileName: String;
    GruposUsuario: TGruposUsuarios;
    UserName: String;
    EncryptedPassword: RawByteString;
    IUsuarioDao: TUsuarioDao;

    property UserID: Integer read FUserID write SetUserID;
    property Usuario: TUsuario read FUsuario;

    constructor Create;
    procedure Inicializar; override;
    procedure LerConfig; override;
    function GetAppDataFolder: String;
    procedure LerConfUsuario;
    procedure SalvarUsuarioESenha(AUserName: String;
      AEncryptedPassword: RawByteString);
  end;

var
  GerenciadorConfig: TGerenciadorConfig;

implementation

uses
  Ladder.ServiceLocator;

constructor TGerenciadorConfig.Create;
begin
  inherited;

  UserConfFileName:= 'Usuario.ini';

  LerConfUsuario;

  AppConfig:= Self;
end;

function TGerenciadorConfig.ReadStreamToRawByteString(AIniFile: TIniFile; Section, Ident: String; Default: RawByteString = ''): RawByteString;
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

procedure TGerenciadorConfig.WriteBinaryStreamFromRawByteString(AIniFile: TIniFile; Section, Ident: String; Value: RawByteString);
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

procedure TGerenciadorConfig.SalvarUsuarioESenha(AUserName: String;
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

procedure TGerenciadorConfig.SetUserID(const Value: Integer);
begin
  FUserID := Value;

  FUsuario:= IUsuarioDao.SelectKey(GerenciadorConfig.UserID);
end;

function TGerenciadorConfig.GetAppDataFolder: String;
begin
  Result:= IncludeTrailingPathDelimiter(GetEnvironmentVariable('APPDATA'))+'ProjetoGerenciador\';
end;

procedure TGerenciadorConfig.Inicializar;
var
  FRootClass: TRootClass;
begin
  inherited;
  TFrwServiceLocator.Inicializar(TFrwServiceFactory.Create(ConSqlServer));

  IUsuarioDao:= TUsuarioDao.Create;
  IUsuarioDao.CreateTableAndFields;

  FRootClass:= TRootClass.Create;
  try
    FRootClass.CreateAllTables;
  finally
    FRootClass.Free;
  end;
end;

procedure TGerenciadorConfig.LerConfig;
begin
  inherited;
  LerConfUsuario;
end;

procedure TGerenciadorConfig.LerConfUsuario;
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

end.
