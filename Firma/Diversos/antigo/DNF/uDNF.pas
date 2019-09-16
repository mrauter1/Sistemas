unit uDNF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDtm_DNF, StdCtrls, Gauges, Grids, DBGrids, ComCtrls, uDir, IniFiles;

type
  TfDNF = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid: TDBGrid;
    Gauge1: TGauge;
    Edit1: TEdit;
    BtnGerar: TButton;
    Button1: TButton;
    Label2: TLabel;
    CBXMes: TComboBox;
    Label1: TLabel;
    EditAno: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGerarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EditAnoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditAnoExit(Sender: TObject);
    procedure CBXMesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function DadosNF(Periodo: String): String;
  function DadosItens(Periodo: String; NumItem: integer): String;
  function DadosCont(Cont0, Cont1, NumVol, QuantVol: Integer): String;

  function TiraChar(vStr: String): String;
  Procedure CriaStr(var vStr: AnsiString; Tamanho: Integer);
  procedure Molda(Texto, Preenchimento: string; PosIni, PosFim: integer; AlinDireita: Boolean; Var Linha: AnsiString);

var
  fDNF: TfDNF;

implementation

uses DateUtils;

{$R *.dfm}

function TiraChar(vStr: String): String;
begin
  Result:= vStr;
  Result:= StringReplace(Result, '/', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '-', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '.', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '\', '', [rfReplaceAll]);
  Result:= StringReplace(Result, ',', '', [rfReplaceAll]);  
end;

Procedure CriaStr(var vStr: AnsiString; Tamanho: Integer);
var
 X: Integer;
begin
  for X:= 1 to Tamanho do
  begin
    vStr:= vStr + ' ';
  end;
end;

procedure Molda(Texto, Preenchimento: string; PosIni, PosFim: integer; AlinDireita: Boolean; Var Linha: AnsiString);
var
  x, vTamanho : integer;
  vTexto : string;
begin
  vTamanho:= PosFim - (PosIni - 1);
  vTexto := texto;
  vTexto:= Trim(vTexto);
  if AlinDireita then
  begin
    While Length(vTexto) < vTamanho do
    begin
      vTexto := Preenchimento + vTexto;
    end;
  end
else if not AlinDireita then
  begin
    While Length(vTexto) < vTamanho do
    begin
      vTexto := vTexto + Preenchimento;
    end;
  end;
  for X := PosIni to PosFim do
  begin
    Linha[x]:= vTexto[X + 1 - PosIni];
  end;
end;

function DadosNF(Periodo: String): String;
begin
  Result:= '';
  CriaStr(Result, 130);
  with Dtm_DNF do
  begin
    Molda('0', '0', 1, 1, True, Result);
    Molda(Periodo, '0', 2, 7, True, Result);
    Molda('92661453000187', '0', 8, 21, True, Result);
    Molda(CDS_FiltroNUMERO.AsString, '0', 22, 27, True, Result);
    Molda(CDS_FiltroSERIE.AsString, ' ', 28, 30, False, Result);
    Molda(FormatDateTime('ddmmyyyy', CDS_FiltroDATADOCUMENTO.AsDateTime), '0', 31, 38, True, Result);
    Molda(FormatDateTime('ddmmyyyy', CDS_FiltroDATADOCUMENTO.AsDateTime), '0', 39, 46, True, Result);
    if CDS_FiltroNumeroCGCMF.AsFloat <> 0 then
    Molda(TiraChar(CDS_FiltroNUMEROCGCMF.AsString), '0', 47, 60, True, Result) else
    Molda(TiraChar(CDS_FiltroNUMEROCPF.AsString), ' ', 47, 60, False, Result);
    Molda(' ', ' ', 61, 130, False, Result);
  end;
//  Result:= Result + '0D0A';
end;

function DadosItens(Periodo: String; NumItem: Integer): String;
var
  Unidade: String;
  ValorUnitario, ValorTotal, QuantEst: Extended;
begin
  Result:= '';
  CriaStr(result, 147);
  with Dtm_DNF do
  begin
    if CDS_FiltroSubUn.AsString = 'N' then
    begin
      Unidade:= CDS_ProUNIDADE.AsString;
      ValorUnitario:= CDS_MCliProPreco.AsFloat;
    end
  else
    begin
      Unidade:= CDS_ProNomeSubUnidade.AsString;
      ValorUnitario:= CDS_MCliProPreco.AsFloat / CDS_MCliProUNIDADEESTOQUE.AsFloat;
    end;
    ValorTotal:= CDS_MCliProQuantAtendida.AsFloat*ValorUnitario;
    QuantEst:= (CDS_MCliProQuantAtendida.AsFloat/CDS_MCliProUnidadeEstoque.AsFloat)*CDS_ProPeso.AsFloat;

    Molda('1', '0', 1, 1, True, Result);
    Molda(Periodo, '0', 2, 7, True, Result);
    Molda('92661453000187', '0', 8, 21, True, Result);
    Molda(CDS_FiltroNUMERO.AsString, '0', 22, 27, True, Result);
    Molda(CDS_FiltroSERIE.AsString, ' ', 28, 30, False, Result);
    Molda(FormatDateTime('ddmmyyyy', CDS_FiltroDATADOCUMENTO.AsDateTime), '0', 31, 38, True, Result);
    Molda(IntToStr(NumItem), '0', 39, 41, True, Result);
    Molda('095', '0', 42, 44, True, Result);
    Molda('0', '0', 45, 49, True, Result);
    Molda(CDS_MCliProCodFiscalPro.AsString, '0', 50, 53, True, Result);
    Molda(Unidade, ' ', 54, 83, False, Result);
    Molda(TiraChar(FormatFloat('0.000', CDS_MCliProQUANTATENDIDA.AsFloat)), '0', 84, 97, True, Result);
    Molda(TiraChar(FormatFloat('0.000000', ValorUnitario)), '0', 98, 113, True, Result);
    Molda(TiraChar(FormatFloat('0.00', ValorTotal)), '0', 114, 127, True, Result);
    Molda(TiraChar(FormatFloat('0.000', CDS_MCliProAliqIpi.AsFloat)), '0', 128, 133, True, Result);
    Molda(TiraChar(FormatFloat('0.000', QuantEst)), '0', 134, 147, True, Result);
  end;
//  Result:= Result + '0D0A';
end;

function DadosCont(Cont0, Cont1, NumVol, QuantVol: Integer): String;
begin
  Result:= '';
  CriaStr(Result, 29);
  Molda('9', '0', 1, 1, True, Result);
  Molda(IntToStr(Cont0), '0', 2, 8, True, Result);
  Molda(IntToStr(Cont1), '0', 9, 15, True, Result);
  Molda(IntToStr(NumVol), '0', 16, 22, True, Result);
  Molda(IntToStr(QuantVol), '0', 23, 29, True, Result);
end;

procedure TfDNF.Button1Click(Sender: TObject);
begin
  fDir.DirectoryList.Directory:= Edit1.Text;
  fDir.ShowModal;
  Edit1.Text:= fDir.DirectoryList.Directory;
end;

procedure TfDNF.FormCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'DNF.ini') then
  begin
    ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'DNF.Ini');
    Edit1.Text:= ArqIni.ReadString('Values', 'DefaultDir', ExtractFilePath(Application.ExeName) + 'Arquivos');
    fDNF.Top:= ArqIni.ReadInteger('Values', 'Form Top', fDNF.Top);
    fDNF.Left:= ArqIni.ReadInteger('Values', 'Form Left', fDNF.Left);
    ArqIni.Free;
  end
else
  Edit1.Text:= ExtractFilePath(Application.ExeName) + 'Arquivos';
end;

procedure TfDNF.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ArqIni: TIniFile;
begin
  ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) + 'DNF.Ini');
  ArqIni.WriteString('Values', 'DefaultDir', Edit1.Text);
  ArqIni.WriteInteger('Values', 'Form Top', fDNF.Top);
  ArqIni.WriteInteger('Values', 'Form Left', fDNF.Left);
end;

procedure TfDNF.BtnGerarClick(Sender: TObject);
var
  Mes, Ano, MesF, NumItem, Cont0, Cont1, NumVol, QuantVol: Word;
  vArq: TextFile;
begin
  try
    NumVol:= 1;
    QuantVol:= 1;
    Screen.Cursor:= crHourGlass;
    Gauge1.Progress:= 0;
    with Dtm_DNF do
    begin
      if not DirectoryExists(Edit1.Text) then
      if not CreateDir(Edit1.Text) then
        raise Exception.Create('O diretório para salvar o arquivo não existe e é impossivel cria-lo.');
      Gauge1.MaxValue:= CDS_Filtro.RecordCount;

      Mes:= CBxMes.ItemIndex + 1;
      Ano:= StrToInt(EditAno.Text);

      Ini:= EncodeDate(Ano, Mes, 1);
      Fim:= EndOfAMonth(Ano, Mes);
      MesF:= Mes;
      while MesF = Mes do
      begin
        Cont0:= 0; Cont1:= 0;
        Filtra('M.Numero');
        CDS_Filtro.First;

        AssignFile(vArq, Edit1.Text + '\DNFNF'+FormatDateTime('mmmyy', Ini)+'.txt');
        ReWrite(vArq); //Cria o arquivo em branco

        while not CDS_Filtro.Eof do
        begin
          inc(Cont0);
          writeln(vArq, DadosNF(FormatDateTime('yyyymm', Ini)));
          NumItem:= 0;
          CDS_MCliPro.First;
          while not CDS_MCliPro.Eof do
          begin
            inc(NumItem);
            if CDS_GrupoCodGrupo.AsString = '002' then begin
            writeln(vArq, DadosItens(FormatDateTime('yyyymm', Ini), NumItem)); inc(Cont1); end;
            CDS_McliPro.Next;
          end;
          Gauge1.Progress:= Gauge1.Progress+1;
          CDS_Filtro.Next;
        end;
        if Mes = 12 then begin
        Mes:= 1; inc(Ano); end
        else inc(Mes);
        Ini:= EncodeDate(Ano, Mes, 1);
        Fim:= EndOfAMonth(Ano, Mes);
        writeln(vArq, DadosCont(Cont0, Cont1, NumVol, QuantVol));
        CloseFile(vArq);
      end;
    end;
  Application.MessageBox('Arquivo gerado com sucesso!', 'Completo', MB_OK);
  fDNF.EditAnoExit(Self);
  finally
    Screen.Cursor:= crDefault;
    Gauge1.Progress:= 0;
  end;
end;

procedure TfDNF.FormActivate(Sender: TObject);
var
  Ano, Mes, Dia: Word;
begin
  DecodeDate(now, Ano, Mes, Dia);
  if Mes = 1 then begin
  Mes:= 12; Dec(Ano); end
  else Dec(Mes);
  CBXMes.ItemIndex:= Mes-1;
  EditAno.Text:= IntToStr(Ano);
  fDNF.EditAnoExit(Self);
end;

procedure TfDNF.EditAnoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    fDNF.EditAnoExit(Sender);
end;

procedure TfDNF.EditAnoExit(Sender: TObject);
begin
  try
    Ini:= EncodeDate(StrToInt(EditAno.Text), CBxMes.ItemIndex + 1, 1);
    Fim:= EndOfAMonth(StrToInt(EditAno.Text), CBxMes.ItemIndex + 1);
    Dtm_DNF.Filtra('M.DataDocumento, M.Numero');
  except
    Application.MessageBox('Data Inválida!', 'Erro', MB_OK);
  end;
end;

procedure TfDNF.CBXMesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    fDNF.EditAnoExit(Sender);
end;

end.
