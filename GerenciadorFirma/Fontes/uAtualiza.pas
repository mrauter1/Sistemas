unit uAtualiza;

interface

uses
  System.Classes, uCopyFolder3Test, uFrmShowMemo;

type
  TAtualiza = class
  private
    FormShowMemo: TFormShowMemo;
    FVersaoAtual: String;
    FErroAtualizacao: Boolean;
    FAtualizando: Boolean;
    FOldExeName: String;
    FDeveFazerUpdate: Boolean;
    FArquivosParaIgnorar: TStringList;

    function VerificaAlteracaoArquivo(const inpath,outpath,infilename:string;
               lastfilesize:int64; var CanCopy: boolean):boolean;
    function AoCopiarArquivo(const inpath,outpath,infilename:string;
               lastfilesize:int64; var CanCopy: boolean):boolean;
    procedure RenomeiaExe;
    function Copiar: Boolean;
    procedure Exec;
    procedure LerConfig;
    procedure SalvarConfig;
    function TemVersaoMaisNovaDoArquivo(pPastaServer, pPastaLocal, pArquivo: String): Boolean;
    function ObterNomeArquivo(pPasta, pArquivo: String): String;
    function ArquivoIgnorado(pFile: String): Boolean;
    function FazCopia(pApenasVerificacao: Boolean;
      FileExit: TCopyFolderExit): Boolean;
  public
    UpdatePath: String;

    constructor Create(pUpdatePath: String);
    destructor Destroy;
    procedure VerificaEAtualiza;
    function HouveAlteracao: Boolean;
  end;

implementation

uses
  Windows, Forms, SysUtils, Dialogs, ShellApi, IniFiles;

const
  Versao = 'versao.ini';

{ TAtualizador }

function GetFileModDate(filename : string) : TDateTime;
var
   F : TSearchRec;
begin
   if FindFirst(filename,faAnyFile,F) = 0 then
     Result := F.TimeStamp
   else
     Result:= 0;

   //if you really wanted an Int, change the return type and use this line:
   //Result := F.Time;
   FindClose(F);
end;

function TAtualiza.ObterNomeArquivo(pPasta, pArquivo: String): String;
begin
  Result:= IncludeTrailingBackslash(pPasta)+pArquivo;
end;

function TAtualiza.ArquivoIgnorado(pFile: String): Boolean;
var
  Str: String;
begin
  for Str in FArquivosParaIgnorar do
  begin
    if Trim(Str.ToUpper) = Trim(ExtractFileName(pFile).ToUpper) then
    begin
      Result:= True;
      Exit;
    end;
  end;
end;

function TAtualiza.TemVersaoMaisNovaDoArquivo(pPastaServer, pPastaLocal, pArquivo: String): Boolean;
begin
  if ArquivoIgnorado(ObterNomeArquivo(pPastaServer, pArquivo)) then
  begin
    Result:= False;
    Exit;
  end;

  if not FileExists(ObterNomeArquivo(pPastaLocal, pArquivo)) then
  begin
    Result:= True;
    Exit;
  end;

  if GetFileModDate(ObterNomeArquivo(pPastaServer, pArquivo)) >
          GetFileModDate(ObterNomeArquivo(pPastaLocal, pArquivo)) then
    Result:= True
  else
    Result:= False;
end;

function TAtualiza.AoCopiarArquivo(const inpath, outpath, infilename: string;
  lastfilesize: int64; var CanCopy: boolean): boolean;
begin
  Result:= True;

  if (ExtractFileName(InFileName) = ExtractFileName(Application.ExeName)) then
  begin
    if TemVersaoMaisNovaDoArquivo(inpath, OutPath, infilename)  then
      RenomeiaExe
    else
      CanCopy:= False;
  end;

  Application.ProcessMessages;

end;

procedure TAtualiza.SalvarConfig;
const
  Section = 'Gerenciador';
var
  FIniFile: TIniFile;
begin
  FIniFile:= TIniFile.Create(ExtractFilePath(Application.ExeName)+Versao);
  try
    FIniFile.WriteString(Section, 'Versao', FVersaoAtual);
    FIniFile.WriteBool(Section, 'Erro', FErroAtualizacao);
    FIniFile.WriteBool(Section, 'Atualizando', FAtualizando);
  finally
    FIniFile.Free;
  end;
end;

procedure TAtualiza.LerConfig;
const
  Section = 'Gerenciador';
var
  FIniFile: TIniFile;
begin
  FIniFile:= TIniFile.Create(ExtractFilePath(Application.ExeName)+Versao);
  try
    FVersaoAtual:= FIniFile.ReadString(Section, 'Versao', '0.1');
    FErroAtualizacao:= FIniFile.ReadBool(Section, 'Erro', False);
    FAtualizando:= FIniFile.ReadBool(Section, 'Atualizando', False);
  finally
    FIniFile.Free;
  end;
end;

constructor TAtualiza.Create(pUpdatePath: String);
begin
  inherited Create;
  FormShowMemo:= TFormShowMemo.Create(nil);

  FArquivosParaIgnorar:= TStringList.Create;
  FArquivosParaIgnorar.Add('Usuario.ini');
  FArquivosParaIgnorar.Add('Versao.ini');
  FArquivosParaIgnorar.Add('Log.txt');

  LerConfig;

  UpdatePath:= pUpdatePath;

  FOldExeName:= Application.ExeName+'.old';

  FDeveFazerUpdate:= False;
end;

destructor TAtualiza.Destroy;
begin
  FormShowMemo.Free;
  FArquivosParaIgnorar.Free;

  inherited;
end;

function TAtualiza.FazCopia(pApenasVerificacao: Boolean; FileExit:TCopyFolderExit): Boolean;
begin
  Result:= StartCopyFolder(UpdatePath, ExtractFilePath(Application.ExeName),'*.*', 2,
           pApenasVerificacao, False, True, False, False, FileExit);
end;

function TAtualiza.VerificaAlteracaoArquivo(const inpath, outpath,
  infilename: string; lastfilesize: int64; var CanCopy: boolean): boolean;
begin
  Result:= True;
  CanCopy:= False;

  if FDeveFazerUpdate then Exit;

  if TemVersaoMaisNovaDoArquivo(inpath, outpath, infilename) then
  begin
    FDeveFazerUpdate:= True;
    Exit;
  end;

end;

function TAtualiza.HouveAlteracao: Boolean;
begin
  FDeveFazerUpdate:= False;
  try
    FazCopia(True, VerificaAlteracaoArquivo);
  finally
    Result:= FDeveFazerUpdate;
  end;
end;

procedure TAtualiza.RenomeiaExe;
begin
  if FileExists(FOldExeName) then
    DeleteFile(FOldExeName);

  RenameFile(Application.ExeName, FOldExeName);
end;

function TAtualiza.Copiar: Boolean;
begin
  Result:= True;

  FAtualizando:= True;
  SalvarConfig;

  FazCopia(False, AoCopiarArquivo);

  if not FileExists(Application.ExeName) then
  begin
    ShowMessage('Erro ao copiar nova versão!');
    RenameFile(FOldExeName, Application.ExeName);
    Result:= False;
  end;
end;

procedure TAtualiza.Exec;
begin
  ShellExecute(0, 'open', PWideChar(Application.ExeName), '', '', SW_SHOWNORMAL);
end;

procedure TAtualiza.VerificaEAtualiza;
var
  FNomeOriginal: String;

begin
  // Se occrreu erro ao atualizar, abre o programa sem atualizar e desmarca o flag de erro.
  if FAtualizando then
  begin
    FAtualizando:= False;
    SalvarConfig;
    Exit;
  end;

  if not directoryexists(UpdatePath) then
    Exit;

  if HouveAlteracao then
  begin
    FormShowMemo.Show;
    try
      FormShowMemo.SetText('Atualizando Projeto Gerenciador. Aguarde...');

      FNomeOriginal:= Application.ExeName;
  //    Renomeia;
      if not Copiar then
        Exit;

      Exec;
      Halt;
    finally
      FormShowMemo.Close;
    end;
  end;
end;

end.
