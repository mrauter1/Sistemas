unit uUpdater;

interface

uses
  System.Classes, uCopyFolder3Test, uFrmShowMemo;

type
  TUpdater = class
  private
    FormShowMemo: TFormShowMemo;
    FVersaoAtual: String;
    FErroAtualizacao: Boolean;
    FUpdating: Boolean;
    FOldExeName: String;
    FIsModified: Boolean;
    FArquivosParaIgnorar: TStringList;
    AFilesToUpdate: TStringList;

    function CheckIfFileIsModified(const inpath,outpath,infilename:string;
               lastfilesize:int64; var CanCopy: boolean):boolean;
    function CheckForCopy(const inpath,outpath,infilename:string;
               lastfilesize:int64; var CanCopy: boolean):boolean;

    procedure RenameOldApplicationExe;

    procedure Exec;
    procedure ReadUpdateStatus;
    procedure SaveUpdateStatus(AAtualizando: Boolean);

    function GetFullFileName(pFolder, pFile: String): String;
    function PathIsIgnored(pFile: String): Boolean;
    function CopyOrCheckFolder(AFolderName: String; ACheckModified: Boolean; FileExit: TCopyFolderExit): Boolean;
    function CheckAndUpdatePath(APathName: String): Boolean; // Returns true if path has been updated
    function IsFolderModified(const AFolderName: String): Boolean;
    function IsPathModified(AServerBaseFolder, ALocalBaseFolder, APath: String): Boolean;
    function IsFileModified(AServerBaseFolder, ALocalBaseFolder,
      AFileName: String): Boolean;
    function GetLocalBasePath: String;
    function PathIsFolder(APath: String): Boolean;
    function CopyFileFromServer(AFileName: String): Boolean;
  public
    UpdatePath: String;

    constructor Create(pUpdatePath: String);
    destructor Destroy;
    function CheckAndUpdate: Boolean;
//    function HouveAlteracao: Boolean;
  end;

const
  cFilesToUpdateFile = 'FilesToUpdate.cfg';
  cUpdateStatusFile = 'versao.ini';

implementation

uses
  Windows, Forms, SysUtils, Dialogs, ShellApi, IniFiles;

{ TUpdater }

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

function TUpdater.GetFullFileName(pFolder, pFile: String): String;
begin
  Result:= IncludeTrailingPathDelimiter(pFolder)+pFile;
end;

function TUpdater.PathIsIgnored(pFile: String): Boolean;
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
  Result:= False;
end;

function TUpdater.CheckForCopy(const inpath, outpath, infilename: string;
  lastfilesize: int64; var CanCopy: boolean): boolean;
begin
  Result:= True;

  if PathIsIgnored(GetFullFileName(inpath, infilename)) then
  begin
    CanCopy:= False;
    Exit;
  end;

  if not IsFileModified(inpath, OutPath, infilename) then
  begin
    CanCopy:= False;
    Exit;
  end;

  if (ExtractFileName(InFileName) = ExtractFileName(Application.ExeName)) then
    RenameOldApplicationExe;

  Application.ProcessMessages;
end;

function TUpdater.GetLocalBasePath: String;
begin
  Result:= ExtractFilePath(Application.ExeName);
end;

procedure TUpdater.SaveUpdateStatus(AAtualizando: Boolean);
const
  Section = 'Gerenciador';
var
  FIniFile: TIniFile;
begin
  FUpdating:= AAtualizando;
  FIniFile:= TIniFile.Create(GetLocalBasePath+cUpdateStatusFile);
  try
    FIniFile.WriteString(Section, 'Versao', FVersaoAtual);
    FIniFile.WriteBool(Section, 'Erro', FErroAtualizacao);
    FIniFile.WriteBool(Section, 'Atualizando', FUpdating);
  finally
    FIniFile.Free;
  end;
end;

procedure TUpdater.ReadUpdateStatus;
const
  Section = 'Gerenciador';
var
  FIniFile: TIniFile;
begin
  FIniFile:= TIniFile.Create(GetLocalBasePath+cUpdateStatusFile);
  try
    FVersaoAtual:= FIniFile.ReadString(Section, 'Versao', '0.1');
    FErroAtualizacao:= FIniFile.ReadBool(Section, 'Erro', False);
    FUpdating:= FIniFile.ReadBool(Section, 'Atualizando', False);
  finally
    FIniFile.Free;
  end;
end;

constructor TUpdater.Create(pUpdatePath: String);
begin
  inherited Create;
  FormShowMemo:= TFormShowMemo.Create(nil);

  AFilesToUpdate:= TStringList.Create;

  FArquivosParaIgnorar:= TStringList.Create;
  FArquivosParaIgnorar.Add('Usuario.ini');
  FArquivosParaIgnorar.Add(cUpdateStatusFile);
  FArquivosParaIgnorar.Add('Log.txt');

  ReadUpdateStatus;

  UpdatePath:= pUpdatePath;

  FOldExeName:= Application.ExeName+'.old';

  FIsModified:= False;
end;

destructor TUpdater.Destroy;
begin
  FormShowMemo.Free;
  FArquivosParaIgnorar.Free;
  AFilesToUpdate.Free;

  inherited;
end;

function TUpdater.CopyOrCheckFolder(AFolderName: String; ACheckModified: Boolean; FileExit:TCopyFolderExit): Boolean;
begin
  Result:= StartCopyFolder(IncludeTrailingPathDelimiter(updatepath)+AFolderName,
           IncludeTrailingPathDelimiter(GetLocalBasePath)+AFolderName,'*.*', 2,
           ACheckModified, False, True, False, False, FileExit);
end;

function TUpdater.IsFileModified(AServerBaseFolder, ALocalBaseFolder, AFileName: String): Boolean;
begin
  if not FileExists(GetFullFileName(ALocalBaseFolder, AFileName)) then
  begin
    Result:= True;
    Exit;
  end;

  // Returns true if server file is newer than local file
  if GetFileModDate(GetFullFileName(AServerBaseFolder, AFileName)) >
          GetFileModDate(GetFullFileName(ALocalBaseFolder, AFileName)) then
    Result:= True
  else
    Result:= False;
end;

function TUpdater.CheckIfFileIsModified(const inpath, outpath,
  infilename: string; lastfilesize: int64; var CanCopy: boolean): boolean;
begin
  Result:= True;
  CanCopy:= False;

  if PathIsIgnored(GetFullFileName(inpath, infilename)) then
    Exit;

  if FIsModified then Exit;

  if IsFileModified(inpath, outpath, infilename) then
  begin
    FIsModified:= True;
    Exit;
  end;

end;

function TUpdater.IsFolderModified(const AFolderName: String): Boolean;
begin
  FIsModified:= False;
  try
    CopyOrCheckFolder(AFolderName, True, CheckIfFileIsModified);
  finally
    Result:= FIsModified;
  end;
end;

procedure TUpdater.RenameOldApplicationExe;
begin
  if FileExists(FOldExeName) then
    DeleteFile(FOldExeName);

  RenameFile(Application.ExeName, FOldExeName);
end;

function TUpdater.PathIsFolder(APath: String): Boolean;
begin
  Result:= APath.EndsWith('\');
end;

function TUpdater.IsPathModified(AServerBaseFolder, ALocalBaseFolder, APath: String): Boolean;
begin
  if PathIsFolder(APath) then
    Result:= IsFolderModified(APath)
  else
    Result:= IsFileModified(AServerBaseFolder, ALocalBaseFolder, APath);
end;

procedure TUpdater.Exec;
begin
  ShellExecute(0, 'open', PWideChar(Application.ExeName), '', '', SW_SHOWNORMAL);
end;

function TUpdater.CopyFileFromServer(AFileName: String): Boolean;
var
  fromName, toName: String;
begin
  fromName:= GetFullFileName(UpdatePath, AFileName);
  toName:= GetFullFileName(GetLocalBasePath, AFileName);
  Result:= copyfile(pchar(fromname),pchar(toname),False);
  if not Result then
    ShowMessage(Format('Erro ao atualizar arquivo ''%s'' do local ''%s''.', [AFileName, fromname]));
end;

function TUpdater.CheckAndUpdatePath(APathName: String): Boolean;
begin
  Result:= False;

  if PathIsIgnored(APathName) then
    Exit;

  if not IsPathModified(UpdatePath,GetLocalBasePath,APathName) then
    Exit;

  if (APathName.ToUpper = ExtractFileName(Application.ExeName).ToUpper) then
    RenameOldApplicationExe;

  if PathIsFolder(APathName) then
    Result:= CopyOrCheckFolder(APathName, False, CheckForCopy)
  else
    Result:= CopyFileFromServer(APathName);

  Result:= True;
  Application.ProcessMessages;
end;

function TUpdater.CheckAndUpdate: Boolean;
var
  APath: String;
  FHasBeenModified: Boolean;
begin
  Result:= False;
  // Se occrreu erro ao atualizar, abre o programa sem atualizar e desmarca o flag de erro.
  if FUpdating then
  begin
    SaveUpdateStatus(False);
    Exit;
  end;

  if not directoryexists(UpdatePath) then
    Exit;

  CheckAndUpdatePath(cFilesToUpdateFile);

  if not FileExists(cFilesToUpdateFile) then
  begin
    ShowMessage(Format('Arquivo ''%s'' não encontrado.', [cFilesToUpdateFile]));
    Exit;
  end;

  FHasBeenModified:= False;

  AFilesToUpdate.LoadFromFile(cFilesToUpdateFile);
  for APath in AFilesToUpdate do
    if trim(APAth) <> '' then
      FHasBeenModified:= FHasBeenModified or IsPathModified(UpdatePath, GetLocalBasePath, APath);

  if FHasBeenModified then
  begin
    FormShowMemo.Show;
    try
      SaveUpdateStatus(True);

      FormShowMemo.SetText('Atualizando Projeto Gerenciador. Aguarde...');

      for APath in AFilesToUpdate do
        if trim(APAth) <> '' then
          CheckAndUpdatePath(APath);

      if not FileExists(Application.ExeName) then
      begin
        ShowMessage(Format('Erro ao atualizar nova versão. Local do servidor: ''%s''. ', [UpdatePath]));
        RenameFile(FOldExeName, Application.ExeName);
        Exit;
      end;

      Result:= True;

      Exec;
      Halt;
    finally
      FormShowMemo.Close;
    end;
  end;
end;

end.
