unit UntMensagem;

interface

uses
  SysUtils, Windows {, madExcept, madNVBitmap};

type

  IMensagem = interface(IInvokable)
    procedure Erro(const pTexto: String; const pTitulo: String = ''; pAbort: Boolean = false);
    procedure ErroComBugReport(const pTexto: String; const pTitulo: string = ''; pAbort: Boolean = false);
    procedure Aviso(const pTexto: String; const pTitulo: String = '');
  end;

  TMensagem = class
  private
  public
    class var MensagemAtual: IMensagem;
    class procedure Erro(const pTexto: String; const pTitulo: String = ''; pAbort: Boolean = false);
    class procedure ErroComBugReport(const pTexto: String; const pTitulo: string = ''; pAbort: Boolean = false);
    class procedure Aviso(const pTexto: String; const pTitulo: String = '');
    class function NewMensagemDialog: IMensagem; static;
    class function NewMensagemLog(const pCaminhoArquivoLog: String): IMensagem; static;
  end;

  TMensagemDialog = class(TInterfacedObject, IMensagem)
  private
    function GetTitulo(const pTipo: String; const pComplemento: String=''): String;
  public
    procedure Erro(const pTexto: String; const pTitulo: String = ''; pAbort: Boolean = false);
    procedure ErroComBugReport(const pTexto: String; const pTitulo: string = ''; pAbort: Boolean = false);
    procedure Aviso(const pTexto: String; const pTitulo: String = '');
  end;

  TMensagemLog = class(TInterfacedObject, IMensagem)
  private
    FCaminho: String;
    procedure WriteLog(const pTexto: String);
  public
    constructor Create(pCaminhoArquivoLog: String);
    procedure Erro(const pTexto: String; const pTitulo: String = ''; pAbort: Boolean = false);
    procedure ErroComBugReport(const pTexto: String; const pTitulo: string = ''; pAbort: Boolean = false);
    procedure Aviso(const pTexto: String; const pTitulo: String = '');
  end;

implementation

uses
  UntFuncoes;

{ TMensagem }

class function TMensagem.NewMensagemDialog: IMensagem;
begin
  Result:= TMensagemDialog.Create;
end;

class function TMensagem.NewMensagemLog(const pCaminhoArquivoLog: String): IMensagem;
begin
  Result:= TMensagemLog.Create(pCaminhoArquivoLog);
end;

class procedure TMensagem.Aviso(const pTexto: String; const pTitulo: String = '');
begin
  MensagemAtual.Aviso(pTexto, pTitulo);
end;

class procedure TMensagem.Erro(const pTexto: String; const pTitulo: String = ''; pAbort: Boolean = false);
begin
  MensagemAtual.Erro(pTexto, pTitulo, pAbort);
end;

class procedure TMensagem.ErroComBugReport(const pTexto: string; const pTitulo: string = ''; pAbort: Boolean = false);
begin
  MensagemAtual.ErroComBugReport(pTexto, pTitulo, pAbort);
end;


{ TMensagemDialog }

procedure TMensagemDialog.Aviso(const pTexto, pTitulo: String);
begin
  PrjMessage(pTexto, GetTitulo('Aviso',pTitulo), MB_ICONWARNING);
end;

procedure TMensagemDialog.Erro(const pTexto, pTitulo: String; pAbort: Boolean);
begin
  PrjMessage(pTexto, GetTitulo('Erro',pTitulo), MB_ICONERROR);
  if pAbort then
    Abort;
end;

procedure TMensagemDialog.ErroComBugReport(const pTexto, pTitulo: string;
  pAbort: Boolean);
{var
  IException: IMEException;
begin
  TMensagem.Erro(pTexto, pTitulo, pAbort);

  AutoSendBugReport(CreateBugReport(etNormal), Screenshot);}
begin
  raise Exception.Create('Não implementado');
end;

function TMensagemDialog.GetTitulo(const pTipo, pComplemento: String): String;
begin
  if pComplemento='' then
    Result:= pTipo+'!'
  else
    Result:= pTipo+': '+pComplemento;
end;

{ TMensagemLog }

procedure TMensagemLog.WriteLog(const pTexto: String);
var
  FArquivo: String;
  F: TextFile;
begin
  try
    FArquivo:= FCaminho;

    AssignFile(F, FArquivo);

    if not DirectoryExists(ExtractFileDir(FArquivo)) then
      CreateDir(ExtractFileDir(FArquivo));

    if not FileExists(FArquivo) then
      Rewrite(F)
    else
      Append(F);

    writeln(F, FormatDateTime('dd/mm/yyyy hh:mm:ss - ', now)+ pTexto);
    Flush(F);
    CloseFile(F);
  except

  end;
end;

procedure TMensagemLog.Aviso(const pTexto, pTitulo: String);
begin
  WriteLog('Aviso: '+ pTitulo+' => '+pTexto);
end;

constructor TMensagemLog.Create(pCaminhoArquivoLog: String);
begin
  FCaminho:= pCaminhoArquivoLog;
end;

procedure TMensagemLog.Erro(const pTexto, pTitulo: String; pAbort: Boolean);
var
  sAbortado: String;
begin
  if pAbort then
    sAbortado:= ' ( Operação abortada! )'
  else
    sAbortado:= '';

  WriteLog('Erro'+sAbortado+': '+ pTitulo+' => '+pTexto);
  if pAbort then
    Abort;
end;

procedure TMensagemLog.ErroComBugReport(const pTexto, pTitulo: string;
  pAbort: Boolean);
{var
  sAbortado: String;
begin
  if pAbort then
    sAbortado:= ' ( Operação abortada! )'
  else
    sAbortado:= '';

  WriteLog('ErroComBugReport'+sAbortado+': '+ pTitulo+' => '+pTexto);

  // Faz envio de email.
  AutoSendBugReport(CreateBugReport(etNormal), Screenshot);}
begin
  raise Exception.Create('Não implementado');
end;

initialization
// Saída padrão é caixa de dialogos
  TMensagem.MensagemAtual:= TMensagem.NewMensagemDialog;


end.
