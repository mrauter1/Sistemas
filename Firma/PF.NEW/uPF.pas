unit uPF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Gauges, Grids, DBGrids, uDtm_PF, DateUtils, uFormLista,
  Data.DB, uFormConfGrupo;

type
  TTipoCampo = (tcAlfaNumerico, tcNumerico);

  TfPF = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    CBXMes: TComboBox;
    EditAno: TEdit;
    DBGrid: TDBGrid;
    Gauge1: TGauge;
    BtnGerar: TButton;
    ButtonSelDir: TButton;
    EditDir: TEdit;
    Label2: TLabel;
    btnComprov: TButton;
    Button2: TButton;
    BtnTransp: TButton;
    Button1: TButton;
    BtnIdentificacao: TButton;
    procedure EditAnoExit(Sender: TObject);
    procedure EditAnoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBXMesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
    procedure ButtonSelDirClick(Sender: TObject);
    procedure btnComprovClick(Sender: TObject);
    procedure BtnGrupos(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnIdentificacaoClick(Sender: TObject);
  private
    procedure GerarArquivo;
    { Private declarations }
  public
    { Public declarations }
  end;

function GetCodNCM(Cod: String): String;

var
  fPF: TfPF;

implementation

uses uDir, uDmDados, uSecoes, uFormIdentificacao;

{$R *.dfm}

function MoldaCFOP(CFOP: String): String;
begin
  if Length(CFOP) < 4 then
    Result:= ' '
  else
    Result:= CFOP[1]+'.'+CFOP[2]+CFOP[3]+CFOP[4];
end;

function FormataCodNCM(CodNCM: String; CodGrupo: String): String;
begin
  CodNCM:= Trim(CodNCM);
  if Length(CodNCM) = 8 then
    Result:= CodNCM[1]+CodNCM[2]+CodNCM[3]+CodNCM[4]+'.'+CodNCM[5]+CodNCM[6]+'.'+CodNCM[7]+CodNCM[8]
  else
    Result:= GetCodNCM(CodGrupo);
end;

function GetCodNCM(Cod: String): String;
begin
  if (Cod = '0010000') or (Cod = '0020218'){Acotone JS} then Result:= '2914.11.00' //Acetona
  else if Cod = '0010008' then Result:= '2903.12.00' //ClorMetil
  else if Cod = '0010018' then Result:= '2914.12.00' //MetilEtilCet
  else if Cod = '0010026' then Result:= '2902.30.00' //Tol
  else if Cod = '0010007' then Result:= '2914.22.10' //CicloHex
  else if Cod = '0010002' then Result:= '2915.31.00' //AcetEtil
  else if Cod = '0010010' then Result:= '2914.40.10' //DiacetonaAlc
  else if Cod = '0010001' then Result:= '2915.33.00' //AcetBut
  else if Cod = '0010019' then Result:= '2914.13.00' //MIBK
  else if Cod = '0010012' then Result:= '2905.13.00' //Isa4
  else if Cod = '0010030' then Result:= '2915.39.39' //AcetAm
  else if Cod = '0010031' then Result:= '2912.13.00' //Butanol
  else if Cod = '0010035' then Result:= '2905.14.20' //SecButanol
  else Result:= '3814.00.00'; //Thinner
end;
                                                          {
function QTUtil(Grupo: Boolean; Data: TDate; CodPro: String): Double;
begin
  with Dtm_PF do
  begin
    Result:= GetEstGru(CodPro, IncMonth(Data, -1)) + QTCompra(Grupo, Data, CodPro)
    -(GetEstGru(CodPro, Data) + QTVenda(Grupo, Data, CodPro));
  end;
end;                                                       }

function TiraChar(vStr: String): String;
begin
  Result:= vStr;
  Result:= StringReplace(Result, '/', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '-', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '.', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '\', '', [rfReplaceAll]);
  Result:= StringReplace(Result, ',', '', [rfReplaceAll]);
end;

Procedure CriaStr(var vStr: String; Tamanho: Integer);
var
 X: Integer;
begin
  for X:= 1 to Tamanho do
  begin
    vStr:= vStr + ' ';
  end;
end;

procedure Molda(Texto, Preenchimento: string; PosIni, PosFim: integer; AlinDireita: Boolean; Var Linha: String);
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

procedure TfPF.EditAnoExit(Sender: TObject);
begin
  try
    Ini:= EncodeDate(StrToInt(EditAno.Text), CBxMes.ItemIndex + 1, 1);
    Fim:= EndOfAMonth(StrToInt(EditAno.Text), CBxMes.ItemIndex + 1);
//    Dtm_PF.FiltraClientes('MCli.DataDocumento, MCli.Numero');
  except
    Application.MessageBox('Data Inválida!', 'Erro', MB_OK);
  end;
end;

procedure TfPF.EditAnoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    EditAnoExit(Sender);
end;

procedure TfPF.CBXMesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then
    EditAnoExit(Sender);
end;

procedure TfPF.FormActivate(Sender: TObject);
begin
  if MonthOf(Now) = 1 then
  begin
    CBXMes.ItemIndex:= 11;
    EditAno.Text:= IntToStr(YearOf(Now)-1);
  end
 else
  begin
    CBXMes.ItemIndex:= MonthOf(Now)-2;
    EditAno.Text:= IntToStr(YearOf(Now));
  end;

  EditAnoExit(Sender);
  EditDir.Text:= ExtractFileDir(Application.ExeName)+'\Arquivos\';
  if not DirectoryExists(EditDir.Text) then
    CreateDir(EditDir.Text);
end;

procedure TfPF.btnComprovClick(Sender: TObject);
begin
  FormLista:= TFormLista.Create(Self);
  try
    FormLista.Caption:= 'Lista de comprovantes';
    FormLista.NomeIdent:= 'COMPROVANTESCOMPRA';
    FormLista.ValoresDefault:= cComprovCompraPadrao;
    FormLista.ShowModal;
  finally
    FormLista.Free;
  end;
  DmDados.CarregaListas;
end;

procedure TfPF.GerarArquivo;
var
  FExecutor: TExecutor;
begin
  DmDados.DataIni:= Trunc(StartOfAMonth(StrToInt(EditAno.Text), CbxMes.ItemIndex+1));
  DmDados.DataFim:= Trunc(EndOfAMonth(StrToInt(EditAno.Text), CbxMes.ItemIndex+1));

  FExecutor:= TExecutor.Create(EditDir.Text,
                  StrToInt(EditAno.Text), CbxMes.ItemIndex+1);
  try
    FExecutor.Executar;
  finally
    FExecutor.Free;
  end;
  ShowMessage('Geração do arquivo finalizada.');
end;

procedure TfPF.BtnGerarClick(Sender: TObject);
var
  vAno, vMes, vDia: Word;
  QuantEstPF: Double;
  Grupo: String;
  vArqDados: TextFile;
  I: Integer;
begin
  GerarArquivo;
{  try
    with Dtm_PF do
    begin
      CarregaComprovantes;

      BtnGerar.Enabled:= False;
      Screen.Cursor:= crHourGlass;
      Gauge1.MaxValue:= CDS_Pro.RecordCount * 2;
      if not DirectoryExists(Edit1.Text) then
      if not CreateDir(Edit1.Text) then
        begin
          raise Exception.Create('O diretório para salvar o arquivo não existe e é impossivel cria-lo.');
          exit;
        end;

      AssignFile(vArqDados, Edit1.Text+'\M'+UpperCase(FormatDateTime('yyyymmm', Ini))+CDS_CliNUMEROCGCMF.AsString+'.txt');
      Rewrite(vArqDados);
      DecodeDate(Ini, vAno, vMes, vDia);

      Writeln(vArqDados, DadosEmpresa);
      Writeln(vArqDados, Mes);

      QuantEstPF:= GetEstGruP('002', Ini);
      CDS_Pro.First;
      while not CDS_Pro.Eof do
      begin
        if Grupo <> CDS_ProCODGRUPOSUB.AsString then
        begin
          writeln(vArqDados, Produto(Ini));
          writeln(vArqDados, ProFinal(QuantEstPF));
        end;

        Grupo:= CDS_ProCODGRUPOSUB.AsString;
        CDS_Pro.Next;
        Gauge1.Progress:= Gauge1.Progress + 1;
        Application.ProcessMessages;
      end;

      CDS_Pro.First;
      while not CDS_Pro.Eof do
      begin
        FiltraMCli(CDS_ProCODPRODUTO.AsString, 'MCli.ChaveNF');
        CDS_MCli.First;
        while not CDS_MCli.Eof do
        begin
          writeln(vArqDados, Movimentacao);
          CDS_MCli.Next;
        end;

        FiltraMFor(CDS_ProCODPRODUTO.AsString, 'MFor.ChaveNF');
        while not CDS_MFor.Eof do
        begin
          writeln(vArqDados, MovimentacaoFor);
          CDS_MFor.Next;
        end;
        CDS_Pro.Next;
        Gauge1.Progress:= Gauge1.Progress + 1;
        Application.ProcessMessages;
      end;

      for I := 0 to NotasTranspProprio.Count - 1 do
      begin
        FiltraNota(NotasTranspProprio[I]);
        writeln(vArqDados, Transporte);
      end;

      CloseFile(vArqDados);

      Application.MessageBox('Operação concluida com sucesso!', 'Concluido');
    end;
  finally
    BtnGerar.Enabled:= True;
    fPF.EditAnoExit(Self);
    Gauge1.Progress:= 0;
    Screen.Cursor:= crDefault;
    try
      Dtm_Pf.Cds_Pro.First;
    except
    end;
  end^;}
end;

procedure TfPF.Button1Click(Sender: TObject);
begin
  FormLista:= TFormLista.Create(Self);
  try
    FormLista.Caption:= 'Lista de comprovantes';
    FormLista.NomeIdent:= 'COMPROVANTESVENDA';
    FormLista.ValoresDefault:= cComprovVendaPadrao;
    FormLista.ShowModal;
  finally
    FormLista.Free;
  end;
  DmDados.CarregaListas;
end;

procedure TfPF.ButtonSelDirClick(Sender: TObject);
begin
  EditDir.Text:= TfDir.SelecionaDiretorio(EditDir.Text);
end;

procedure TfPF.BtnGrupos(Sender: TObject);
begin
  FormConfGrupo:= TFormConfGrupo.Create(Self);
  try
    FormConfGrupo.Caption:= 'Configuração dos grupos de produtos';
    FormConfGrupo.ShowModal;
    DmDados.SalvarCdsConfPro;
  finally
    FormConfGrupo.Free;
  end;
  DmDados.RecarregarDataSets;
end;

procedure TfPF.BtnIdentificacaoClick(Sender: TObject);
begin
  FormIdentificacaoEmpresa.ShowModal;
end;

end.

