unit Utils;

interface

uses
  Winapi.ShellAPI, Winapi.SHLOBJ, Winapi.Windows, Data.DB, Datasnap.DBClient, Controls, Forms, Variants, Dialogs, System.Classes, StdCtrls, CheckLst,
  Graphics;

type
  TValorChave = class(TComponent)
  private
  public
    Chave: variant;
    Valor: variant;
    constructor Create(AComponente: TComponent; pChave, pValor: variant);
    constructor AdicionaComboBox(pComboBox: TComboBox; pChave, pValor: variant);
    constructor AdicionaCheckListBox(pCheckListBox: TCheckListBox; pChave,
      pValor: Variant);

    class function ObterValorPorChave(StringList: TStrings; Chave: variant): variant; static;
    class function ObterValorPorIndex(StringList: TStrings; Index: Integer): variant; static;

    class function ObterValor(pComboBox: TComboBox): Variant;
    class function ObterValoresSelecionados(pCheckListBox: TCheckListBox; pSeparador: String=','; pQuoteValues: Boolean = False): String;
  end;

function ExecAndWait(const pFile, pParametros: String; const ShowCmd: Word; pTimeOut: Integer; WorkDir: String = ''): boolean;

function GetMesString(pDate: TDateTime): String;

procedure WriteLog(Par_Arquivo: String; Par_Texto: String);

procedure CreateDataSetIfNotActive(pCds: TClientDataSet);

procedure EmbedForm(pParent : TWinControl; pForm : TForm);
procedure AbortMessage(pMensagem, pTitulo: String);

function IsCurrencyField(pField: TField): Boolean;

function VarArrayLength(pVar: variant; Dim: Integer=1): Integer;
function StringToVarArray(pSeparador, pString: String): Variant;
function VarToIntDef(pVar: Variant; pDefault: Integer = 0): Integer;
function VarToFloatDef(pVar: Variant; pDefault: Double = 0): Double;

function Func_Date_SqlServer(parData: TDate): String;

function Func_DateTime_SqlServer(parData: TDateTime): String;

function Func_DataTime_Firebird(parData: TDateTime): String;

function BlendColors(Color1, Color2: TColor; A: Byte): TColor;

procedure BitmapFileToPNG(const Source, Dest: String);

function RemoveAcento(aText : string) : string;

procedure CopyRecord(pSource: TDataSet; pTarget: TDataSet);

procedure CopyRecordsDataSet(pSource: TDataSet; pTarget: TDataSet; pClearTarget: Boolean = False);

implementation

uses
  SysUtils, System.TypInfo, DateUtils, Vcl.Imaging.pngImage;

function ExecAndWait(const pFile, pParametros: String; const ShowCmd: Word; pTimeOut: Integer; WorkDir: String = ''): boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
  pWorkDir: PChar;
begin
  if WorkDir <> '' then pWorkDir := PChar(WorkDir)
  else pWorkDir := nil;//PCHar(ExtractFilePath(pFile));

  {por nome do arquivo entre aspas devido espaco em nome longo}
  CmdLine := pFile +' '+ pParametros;
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do
  begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := ShowCmd;
  end;
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, false,
                          CREATE_NEW_CONSOLE or
                          NORMAL_PRIORITY_CLASS, nil,
                          pWorkDir,
                          SUInfo, ProcInfo);
  {aguarda ate ser finalizado}
  if Result then
  begin
    WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    {libera os Handles}
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;
end;
{
procedure ExecAndWait(const pFile, pParametros: String; const ShowCmd, pTimeOut: Integer);
var
  ExecInfo: TShellExecuteInfo;     // info object for ShellExecuteEx()
  pInfo: PShellExecuteInfo;
begin
    pInfo:=@ExecInfo;
    // prepare information about the application being executed by ShellExecuteEx()
    ExecInfo.cbSize := SizeOf(ExecInfo);
    ExecInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
    ExecInfo.lpVerb:= 'Open';
    ExecInfo.Wnd := 0;
    ExecInfo.lpFile := PWideChar(pFile);
    ExecInfo.lpParameters := PWideChar(pParametros);
    ExecInfo.nShow := ShowCmd;

    if ShellExecuteEx(pInfo) then
    begin
      while WaitForSingleObject(ExecInfo.hProcess, pTimeOut) = WAIT_TIMEOUT do begin
        Sleep(10);
      end;
      CloseHandle(ExecInfo.hProcess);
   end;
end;}

procedure CopyRecord(pSource: TDataSet; pTarget: TDataSet);
var
  pFieldSource, pFieldTarget: TField;

begin
  pTarget.Insert;
  for pFieldSource in pSource.Fields do
  begin
    pFieldTarget:= pTarget.FindField(pFieldSource.FieldName);
    if Assigned(pFieldTarget) then
      pFieldTarget.Value:= pFieldSource.Value;
  end;

  pTarget.Post;
end;

procedure CopyRecordsDataSet(pSource: TDataSet; pTarget: TDataSet; pClearTarget: Boolean = False);
begin
  if pClearTarget then
    while not pTarget.IsEmpty do
      pTarget.Delete;

  pSource.First;
  while not pSource.Eof do
  begin
    CopyRecord(pSource, pTarget);
    pSource.Next;
  end;

end;

function RemoveAcento(aText : string) : string;
const
  ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸Ò˝¿¬ ‘€√’¡…Õ”⁄«‹—›';
  SemAcento = 'aaeouaoaeioucunyAAEOUAOAEIOUCUNY';
var
  x: Cardinal;
begin;
  for x := 1 to Length(aText) do
  try
    if (Pos(aText[x], ComAcento) <> 0) then
      aText[x] := SemAcento[ Pos(aText[x], ComAcento) ];
  except on E: Exception do
    raise Exception.Create('Erro no processo.');
  end;

  Result := aText;
end;

procedure BitmapFileToPNG(const Source, Dest: String);
var
  Bitmap: TBitmap;
  PNG: TPNGObject;
begin
  Bitmap := TBitmap.Create;
  PNG := TPNGObject.Create;
  {In case something goes wrong, free booth Bitmap and PNG}
  try
    Bitmap.LoadFromFile(Source);
    PNG.Assign(Bitmap);    //Convert data into png
    PNG.SaveToFile(Dest);
  finally
    Bitmap.Free;
    PNG.Free;
  end
end;

function GetMesString(pDate: TDateTime): String;
begin
  case MonthOfTheYear(pDate) of
    1: Result:= 'janeiro';
    2: Result:= 'fevereiro';
    3: Result:= 'MarÁo';
    4: Result:= 'Abril';
    5: Result:= 'Maio';
    6: Result:= 'Junho';
    7: Result:= 'Julho';
    8: Result:= 'Agosto';
    9: Result:= 'Setembro';
    10: Result:= 'Outubro';
    11: Result:= 'Novembro';
    12: Result:= 'Dezembro';
  end;
end;

function IsCurrencyField(pField: TField): Boolean;
begin
  if IsPublishedProp(pField, 'currency')  then
    Result:= GetPropValue(pField, 'currency')
  else Result:= False;
end;

function BlendColors(Color1, Color2: TColor; A: Byte): TColor;
var
  c1, c2: LongInt;
  r, g, b, v1, v2: byte;
begin
  A:= Round(2.55 * A);
  c1 := ColorToRGB(Color1);
  c2 := ColorToRGB(Color2);
  v1:= Byte(c1);
  v2:= Byte(c2);
  r:= A * (v1 - v2) shr 8 + v2;
  v1:= Byte(c1 shr 8);
  v2:= Byte(c2 shr 8);
  g:= A * (v1 - v2) shr 8 + v2;
  v1:= Byte(c1 shr 16);
  v2:= Byte(c2 shr 16);
  b:= A * (v1 - v2) shr 8 + v2;
  Result := (b shl 16) + (g shl 8) + r;
end;

procedure EmbedForm(pParent : TWinControl; pForm : TForm);
begin
  pForm.BorderStyle:= bsNone;
  pForm.WindowState:= wsMaximized;
  pForm.Align:= alClient;
  pForm.Parent:= pParent;
  pForm.Show;
end;

procedure CreateDataSetIfNotActive(pCds: TClientDataSet);
begin
  if not pCds.Active then
    pCds.CreateDataSet;
end;

procedure WriteLog(Par_Arquivo: String; Par_Texto: String);
var
  F: TextFile;
begin
  AssignFile(F, Par_Arquivo);
  if FileExists(Par_Arquivo) then
   Append(F)
  else
    ReWrite(F);

  WriteLn(F, FormatDateTime('ddmmyyyy-hh:mm:ss', Now)+' -> '+Par_Texto);

  CloseFile(F);
end;

function VarArrayLength(pVar: variant; Dim: Integer=1): Integer;
begin
  Result:= (VarArrayHighBound(pVar, Dim) - VarArrayLowBound(pVar, Dim))+1;
end;

function StringToVarArray(pSeparador, pString: String): Variant;
var
  FArray: TArray<String>;
  I: Integer;
begin
  FArray:= pString.Split([pSeparador]);
  Result:= VarArrayCreate([0,Length(FArray)-1], varOleStr);

  for I := 0 to Length(FArray)-1 do
    Result[I]:= FArray[I];

end;

function VarToFloatDef(pVar: Variant; pDefault: Double = 0): Double;
begin
  if VarIsNull(pVar) then
    Result:= pDefault
  else
  try
    Result:= pVar;
  except
    Result:= pDefault;
  end;
end;

function VarToIntDef(pVar: Variant; pDefault: Integer = 0): Integer;
begin
  if VarIsNull(pVar) then
    Result:= pDefault
  else
  try
    Result:= pVar;
  except
    Result:= pDefault;
  end;
end;

procedure AbortMessage(pMensagem, pTitulo: String);
var
  Dlg: TForm;
begin
  Dlg := CreateMessageDialog(pMensagem, mtError, [mbOk], mbOK);
  try
    Dlg.Caption := pTitulo;
    Dlg.ShowModal;
  finally
    Dlg.Free;
  end;

  Abort;
end;

function Func_Date_SqlServer(parData: TDate): String;
begin
  Result:= QuotedStr(FormatDateTime('yyyymmdd', parData));
end;

function Func_DateTime_SqlServer(parData: TDateTime): String;
begin
  Result:= QuotedStr(FormatDateTime('yyyymmdd hh:nn:ss', parData));
end;

function Func_DataTime_Firebird(parData: TDateTime): String;
begin
  Result:= 'CAST('+QuotedStr(FormatDateTime('yyyy/mm/dd hh:nn:ss', parData))+' as Timestamp)';
end;

{ TValorChave }

constructor TValorChave.AdicionaComboBox(pComboBox: TComboBox; pChave, pValor: Variant);
begin
  Create(pComboBox, pChave, pValor);
  pComboBox.AddItem(pValor, Self);
end;

constructor TValorChave.AdicionaCheckListBox(pCheckListBox: TCheckListBox; pChave, pValor: Variant);
begin
  Create(pCheckListBox, pChave, pValor);
  pCheckListBox.AddItem(pValor, Self);
end;

constructor TValorChave.Create(AComponente: TComponent; pChave, pValor: variant);
begin
  inherited Create(AComponente);
  Chave:= pChave;
  Valor:= pValor;
end;

class function TValorChave.ObterValor(pComboBox: TComboBox): Variant;
begin
  Result:= TValorChave.ObterValorPorIndex(pComboBox.Items, pComboBox.ItemIndex);
end;

class function TValorChave.ObterValoresSelecionados(pCheckListBox: TCheckListBox; pSeparador: String=','; pQuoteValues: Boolean = False): String;
var
  I: Integer;
begin
  Result:= '';
  for I := 0 to pCheckListBox.Count-1 do
  begin
    if pCheckListBox.Checked[I] then
    begin
      if Result <> '' then
        Result:= Result + pSeparador;

      if pQuoteValues then
        Result:= Result+'"'+ObterValorPorIndex(pCheckListBox.Items, I)+'"'
      else
        Result:= Result+ObterValorPorIndex(pCheckListBox.Items, I);
    end;
  end;
end;

class function TValorChave.ObterValorPorChave(StringList: TStrings; Chave: variant): variant;
var
  I: Integer;
begin
  for I := 0 to StringList.Count-1 do
  begin
    if StringList.Objects[I] is TValorChave then
      if TValorChave(StringList.Objects[I]).Chave = Chave then
      begin
        Result:= TValorChave(StringList.Objects[I]).Valor;
        Break;
      end;
  end;

  Result:= null;
end;

class function TValorChave.ObterValorPorIndex(StringList: TStrings; Index: Integer): variant;
begin
  if StringList.Objects[Index] is TValorChave then
    Result:= TValorChave(StringList.Objects[Index]).Chave
  else
    Result:= null;
end;

end.

