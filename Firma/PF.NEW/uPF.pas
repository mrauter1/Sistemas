unit uPF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Gauges, Grids, DBGrids, uDtm_PF, DateUtils, uFormLista,
  Data.DB, uFormConfGrupo;

type
  TfPF = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    CBXMes: TComboBox;
    EditAno: TEdit;
    DBGrid: TDBGrid;
    Gauge1: TGauge;
    BtnGerar: TButton;
    ButtonSelDir: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    btnComprov: TButton;
    Button2: TButton;
    BtnTransp: TButton;
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
    procedure BtnTranspClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function TiraChar(vStr: String): String;
  Procedure CriaStr(var vStr: String; Tamanho: Integer);
  procedure Molda(Texto, Preenchimento: string; PosIni, PosFim: integer; AlinDireita: Boolean; Var Linha: String);

  function DadosEmpresa: String;
  function Mes: String;
  function Produto(AnoMes: TDate): String;
  function ProFinal(QTProF: Double): String;
  function SubsPresente: String;
  function Movimentacao: String;

  function GetEstPro(Cod: String; AnoMes: TDate): Double;
  function GetEstGru(Cod: String; AnoMes: TDate): Double;
  function GetEstGruP(Cod: String; AnoMes: TDate): Double;
  function QTUtil(Grupo: Boolean; Data: TDate; CodPro: String): Double;
  function GetCodNCM(Cod: String): String;
  function MoldaCFOP(CFOP: String): string;

var
  fPF: TfPF;

implementation

uses uDir;

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

function QTUtil(Grupo: Boolean; Data: TDate; CodPro: String): Double;
begin
  with Dtm_PF do
  begin
    Result:= GetEstGru(CodPro, IncMonth(Data, -1)) + QTCompra(Grupo, Data, CodPro)
    -(GetEstGru(CodPro, Data) + QTVenda(Grupo, Data, CodPro));
  end;
end;

function GetEstPro(Cod: String; AnoMes: TDate): Double;
begin
  with Dtm_PF do
  begin
    CDS_Estoque.First;
    FiltraEst(False, AnoMes, Cod);
    Result:= CDS_EstoqueSALDOATUAL.AsFloat;
  end;
end;

function GetEstGru(Cod: String; AnoMes: TDate): Double;
begin
  Result:= 0;
  with Dtm_PF do
  begin
    FiltraEst(True, AnoMes, Cod);
    while not CDS_Estoque.Eof do
    begin
      Result:= Result + CDS_EstoqueSaldoAtual.AsFloat;
      CDS_Estoque.Next;
    end;
  end;
end;

function GetEstGruP(Cod: String; AnoMes: TDate): Double;
begin
  Result:= 0;
  with Dtm_PF do
  begin
    Filtra_Sub_Gru(Cod);
    while not CDS_Sub_Gru.Eof do
    begin
      Result:= Result + GetEstGru(CDS_Sub_GruCODGRUPOSUB.AsString, AnoMes);
      CDS_Sub_Gru.Next;
    end;
  end;
end;

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

function DadosEmpresa: String;
begin
  with Dtm_PF do
  begin
    Result:= '';
    CriaStr(result, 543);
    Molda('EM', ' ', 1, 2, False, Result);
    Molda(TiraChar(CDS_CliNUMEROCGCMF.AsString), ' ', 3, 16, False, Result);
    Molda(CDS_CliRAZAOSOCIAL.AsString, ' ', 17, 86, False, Result);
    Molda('00002700-6'{Nr. CLF}, ' ', 87, 96, False, Result);
    Molda('2483-0/00' {CNAE}, ' ', 97, 106, False, Result);
    Molda(''{GrupoI}, '0', 107, 107, True, Result);
    Molda(''{GrupoII}, '0', 108, 108, True, Result);
    Molda('1'{GrupoIII}, '0', 109, 109, True, Result);
    Molda(''{GrupoIV}, '0', 110, 110, True, Result);
    Molda('1'{GrupoV}, '0', 111, 111, True, Result);
    Molda(''{GrupoVI}, '0', 112, 112, True, Result);
    Molda(''{GrupoVII}, '0', 113, 113, True, Result);
    Molda(''{GrupoVIII}, '0', 114, 114, True, Result);
    Molda(''{GrupoIX}, '0', 115, 115, True, Result);
    Molda(''{Des. GrupoIX}, ' ', 116, 165, False, Result);
    Molda(''{Inf}, ' ', 166, 365, False, Result);
    Molda('GRUPO III'{Grup Princ.}, ' ', 366, 375, False, Result);
    Molda('RICARDO COSTA RAUTER'{Resp}, ' ', 376, 415, False, Result);
    Molda('43507298015'{CPF Resp.}, ' ', 416, 426, False, Result);
    Molda('6021148322'{Ident Resp.}, ' ', 427, 437, False, Result);
    Molda('SSP'{Org�o Ident.}, ' ', 438, 472, False, Result);
    Molda('RS', ' ', 473, 474, False, Result);
    Molda('51'{DDD}, ' ', 475, 477, False, Result);
    Molda(Telefone(CDS_CliCODCLIENTE.AsString), ' ', 478, 485, False, Result);
    Molda(Telefone(CDS_CliCODCLIENTE.AsString), ' ', 486, 493, False, Result);

    Molda('rauter@rauter.com.br'{Mail}, ' ', 494, 543, False, Result);
  end;
end;

function Mes: String;
begin
  with Dtm_PF do
  begin
    Result:= '';
    CriaStr(Result, 23);
    Molda('ME' , ' ', 1, 2, False, Result);
    Molda(TiraChar(CDS_CliNUMEROCGCMF.AsString), ' ', 3, 16, False, Result);
    Molda(FormatDateTime('yyyy', Ini), ' ', 17, 20, False, Result);
    Molda(UpperCase(FormatDateTime('mmm', Ini)), ' ', 21, 23, False, Result);
  end;
end;

function Produto(AnoMes: TDate): String;
begin
  with Dtm_PF do
  begin
{    CDS_ProInsumo.First;
    while not CDS_ProInsumo.Eof do
    begin

      CDS_ProInsumo.Next;
    end;           }

    Result:= '';
    CriaStr(result, 421);
    Molda('PR', ' ', 1, 2, False, Result);
    Molda(TiraChar(CDS_CliNUMEROCGCMF.AsString), ' ', 3, 16, False, Result);
    Molda(FormatDateTime('yyyy', Ini), ' ', 17, 20, False, Result);
    Molda(UpperCase(FormatDateTime('mmm', Ini)), ' ', 21, 23, False, Result);
    Molda(FloatToStr(GetConc(CDS_ProCodGrupoSub.AsString)){Concentr}, '0', 24, 29, True, Result);
    Molda(FloatToStr(GetDensidade){Dens}, '0', 30, 35, True, Result);
    Molda(FloatToStr(GetEstGru(CDS_ProCODGRUPOSUB.AsString, IncMonth(AnoMes, -1))), '0', 36, 55, True, Result);
    Molda(''{QT. Produz}, '0', 56, 75, True, Result);
    Molda(''{QT. Transf}, '0', 76, 95, True, Result);
    Molda(FloatToStr(QTUtil(True, AnoMes, CDS_ProCODGRUPOSUB.AsString)), '0', 96, 115, True, Result);
    Molda(FloatToStr(QTCompra(True, AnoMes, CDS_ProCODGRUPOSUB.AsString)), '0', 116, 135, True, Result);
    Molda(FloatToStr(QTVenda(True, AnoMes, CDS_ProCODGRUPOSUB.AsString)), '0', 136, 155, True, Result);
    Molda(''{QT. Recic}, '0', 156, 175, True, Result);
    Molda(''{QT. Reaproveit}, '0', 176, 195, True, Result);
    Molda(''{QT. Import}, '0', 196, 215, True, Result);
    Molda(''{QT. Exp}, '0', 216, 235, True, Result);
    Molda(''{QT. Perdas}, '0', 236, 255, True, Result);
    Molda(''{QT. Evapor}, '0', 256, 275, True, Result);
    Molda(''{QT. Ent Diver}, '0', 276, 295, True, Result);
    Molda(''{QT. Sai Diver.}, '0', 296, 315, True, Result);
    Molda(FloatToStr(GetEstGru(CDS_ProCodGrupoSub.AsString, AnoMes)), '0', 316, 335, True, Result);
    Molda('litro'{UnidadeMedida}, ' ', 336, 341, False, Result);
    Molda(FormataCodNCM(CDS_ProCODMERCOSULNCM.AsString, CDS_ProCODGRUPOSUB.AsString), ' ', 342, 351, False, Result);
    Molda(NomeGrupoSub(CDS_ProCODGRUPOSUB.AsString), ' ', 352, 421, False, Result);
  end;
end;

function ProFinal(QTProF: Double): String;
begin
 with Dtm_PF do
  begin
    Result:= '';
    CriaStr(result, 135);
    Molda('PF', ' ', 1, 2, False, Result);
    Molda(TiraChar(CDS_CliNUMEROCGCMF.AsString), ' ', 3, 16, False, Result);
    Molda(FormatDateTime('yyyy', Ini), ' ', 17, 20, False, Result);
    Molda(UpperCase(FormatDateTime('mmm', Ini)), ' ', 21, 23, False, Result);
    Molda('0,86', '0', 24, 29, True, Result); //Dens
    Molda(FloatToStr(QTProF), '0', 30, 49, True, Result); //Qt. Prod. Fnl.
    Molda('litro', ' ', 50, 55, False, Result); // DS. UN.
    Molda('3814.00.00', ' ', 56, 65, False, Result);  // Cod NCM
    Molda('Thinner', ' ', 66, 135, False, Result); // Nome Pro
  end;
end;

function SubsPresente: String;
begin
  with Dtm_PF do
  begin
    Result:= '';
    CriaStr(result, 109);
    Molda('SP', ' ', 1, 2, False, Result);
    Molda(TiraChar(CDS_CliNUMEROCGCMF.AsString), ' ', 3, 16, False, Result);
    Molda(FormatDateTime('yyyy', Ini), ' ', 17, 20, False, Result);
    Molda(UpperCase(FormatDateTime('mmm', Ini)), ' ', 21, 23, False, Result);
    Molda(''{Concentr}, '0', 24, 29, True, Result);
    Molda(''{Cod NCM}, ' ', 30, 39, False, Result);
    Molda(''{Nome Pro}, ' ', 40, 109, False, Result);
  end;
end;

function Movimentacao: String;
begin
  with Dtm_PF do
  begin
    if TransporteProprio(CDS_MCliCODTRANSPORTADORA.AsString) then
      NotasTranspProprio.Add(CDS_MCliCHAVENFPRO.AsString);

    Result:= '';
    CriaStr(result, 180);
    Molda('MV', ' ', 1, 2, False, Result);
    Molda(TiraChar(CDS_CliNUMEROCGCMF.AsString), ' ', 3, 16, False, Result);
    Molda(FormatDateTime('yyyy', Ini), ' ', 17, 20, False, Result);
    Molda(UpperCase(FormatDateTime('mmm', Ini)), ' ', 21, 23, False, Result);
    Molda(FormatDateTime('dd', CDS_MCliDATADOCUMENTO.AsDateTime), ' ', 24, 25, False, Result);
    Molda(MoldaCFOP(CDS_MCliCODFISCALPRO.AsString), ' ', 26, 30, False, Result);
    Molda(FloatToStr(GetConc(CDS_ProCODGRUPOSUB.AsString)), '0', 31, 36, True, Result);
    Molda(FloatToStr(MCliQuantLitros), '0', 37, 56, True, Result);
    Molda('litro'{Un. Med.}, ' ', 57, 62, False, Result);
    Molda(CDS_MCliNumero.AsString{NF}, ' ', 63, 72, False, Result);
    Molda(TiraChar(NumeroCGCMFCli(CDS_MCLICodCliente.AsString)), ' ', 73, 86, False, Result);
    Molda(TiraChar(CodTransp(CDS_MCliCODTRANSPORTADORA.AsString)), ' ', 87, 100, False, Result);
    Molda(FormataCodNCM(CDS_ProCODMERCOSULNCM.AsString, CDS_ProCODGRUPOSUB.AsString), ' ', 101, 110, False, Result);
    Molda(NomeGrupoSub(CDS_ProCODGRUPOSUB.AsString){Nome Pro}, ' ', 111, 180, False, Result);
  end;
end;

function MovimentacaoFor: String;
begin
  with Dtm_PF do
  begin
    Result:= '';
    CriaStr(result, 180);
    Molda('MV', ' ', 1, 2, False, Result);
    Molda(TiraChar(CDS_CliNUMEROCGCMF.AsString), ' ', 3, 16, False, Result);
    Molda(FormatDateTime('yyyy', Ini), ' ', 17, 20, False, Result);
    Molda(UpperCase(FormatDateTime('mmm', Ini)), ' ', 21, 23, False, Result);
    Molda(FormatDateTime('dd', CDS_MForDATACOMPROVANTE.AsDateTime), ' ', 24, 25, False, Result);
    Molda(MoldaCFOP(CDS_MForCODFISCALPRO.AsString), ' ', 26, 30, False, Result);
    Molda(FloatToStr(GetConc(CDS_ProCODGRUPOSUB.AsString)), '0', 31, 36, True, Result);
    Molda(FloatToStr(MForQuantLitros), '0', 37, 56, True, Result);
    Molda('litro'{Un. Med.}, ' ', 57, 62, False, Result);
    Molda(CDS_MForNumero.AsString{NF}, ' ', 63, 72, False, Result);
    Molda(TiraChar(NumeroCGCMFFor(CDS_MForCODFORNECEDOR.AsString)){Cod Forn}, ' ', 73, 86, False, Result);
    Molda(TiraChar(CodTransp(CDS_MForTRANCODTRANSPORTE.AsString)), ' ', 87, 100, False, Result);
    Molda(FormataCodNCM(CDS_ProCODMERCOSULNCM.AsString, CDS_ProCODGRUPOSUB.AsString), ' ', 101, 110, False, Result);
    Molda(NomeGrupoSub(CDS_ProCODGRUPOSUB.AsString){Nome Pro}, ' ', 111, 180, False, Result);
  end;
end;

function Transporte: String;
begin
  with Dtm_PF do
  begin
    if not CDS_Pro.Locate('CODPRODUTO', CDS_MCliCODPRODUTO.AsString, []) then
      raise Exception.Create('Erro! Produto n�o localizado: '+CDS_MCliCODPRODUTO.AsString);

    Result:= '';
    CriaStr(result, 176);
    Molda('TP', ' ', 1, 2, False, Result);
    Molda(TiraChar(CDS_CliNUMEROCGCMF.AsString), ' ', 3, 16, False, Result); // CNPJ
    Molda(FormatDateTime('yyyy', Ini), ' ', 17, 20, False, Result);
    Molda(UpperCase(FormatDateTime('mmm', Ini)), ' ', 21, 23, False, Result);
    Molda(FormatDateTime('dd', CDS_MCliDATADOCUMENTO.AsDateTime), ' ', 24, 26, False, Result);
    Molda(FloatToStr(GetConc(CDS_ProCODGRUPOSUB.AsString)), '0', 27, 32, True, Result);
    Molda(FloatToStr(MCliQuantLitros), '0', 33, 52, True, Result);
    Molda('litro', ' ', 53, 58, false, Result);
    Molda(CDS_MCliNumero.AsString, ' ', 59, 64, false, Result);
    Molda(TiraChar(CDS_CliNUMEROCGCMF.AsString), '0', 65, 78, false, Result);
    Molda('RS', ' ', 79, 80, false, Result);
    Molda(TiraChar(NumeroCGCMFCli(CDS_MCLICodCliente.AsString)), ' ', 81, 94, false, Result);
    Molda(UFCli(CDS_MCLICodCliente.AsString), ' ', 95, 96, false, Result);
    Molda(FormataCodNCM(CDS_ProCODMERCOSULNCM.AsString, CDS_ProCODGRUPOSUB.AsString), ' ', 97, 106, false, Result);
    Molda(NomeGrupoSub(CDS_ProCODGRUPOSUB.AsString), ' ', 107, 176, false, Result);
  end;
end;

procedure TfPF.EditAnoExit(Sender: TObject);
begin
  try
    Ini:= EncodeDate(StrToInt(EditAno.Text), CBxMes.ItemIndex + 1, 1);
    Fim:= EndOfAMonth(StrToInt(EditAno.Text), CBxMes.ItemIndex + 1);
//    Dtm_PF.FiltraClientes('MCli.DataDocumento, MCli.Numero');
  except
    Application.MessageBox('Data Inv�lida!', 'Erro', MB_OK);
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
  EditAno.Text:= IntToStr(YearOf(Now));
  EditAnoExit(Sender);
  Edit1.Text:= ExtractFileDir(Application.ExeName);
end;

procedure TfPF.btnComprovClick(Sender: TObject);
begin
  FormLista:= TFormLista.Create(Self);
  try
    FormLista.Caption:= 'Lista de comprovantes';
    FormLista.NomeIdent:= 'COMPROVANTES';
    FormLista.ValoresDefault:= cComprovPadrao;
    FormLista.ShowModal;
  finally
    FormLista.Free;
  end;
  Dtm_PF.RecarregaDataSets;
end;

procedure TfPF.BtnGerarClick(Sender: TObject);
var
  vAno, vMes, vDia: Word;
  QuantEstPF: Double;
  Grupo: String;
  vArqDados: TextFile;
  I: Integer;
begin
  try
    with Dtm_PF do
    begin
      CarregaComprovantes;

      BtnGerar.Enabled:= False;
      Screen.Cursor:= crHourGlass;
      Gauge1.MaxValue:= CDS_Pro.RecordCount * 2;
      if not DirectoryExists(Edit1.Text) then
      if not CreateDir(Edit1.Text) then
        begin
          raise Exception.Create('O diret�rio para salvar o arquivo n�o existe e � impossivel cria-lo.');
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

      Application.MessageBox('Opera��o concluida com sucesso!', 'Concluido');
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
  end;
end;

procedure TfPF.ButtonSelDirClick(Sender: TObject);
begin
  fDir.ShowModal;
end;

procedure TfPF.BtnGrupos(Sender: TObject);
begin
  FormConfGrupo:= TFormConfGrupo.Create(Self);
  try
    FormConfGrupo.Caption:= 'Configura��o dos grupos de produtos';
    FormConfGrupo.ShowModal;
    Dtm_PF.SalvarCdsConfPro;
  finally
    FormConfGrupo.Free;
  end;
  Dtm_PF.RecarregaDataSets;
end;

procedure TfPF.BtnTranspClick(Sender: TObject);
begin
  FormLista:= TFormLista.Create(Self);
  try
    FormLista.Caption:= 'Lista de c�digos de transportadoras pr�prias';
    FormLista.NomeIdent:= 'TRANSP';
    FormLista.ValoresDefault:= cTranspPadrao;
    FormLista.ShowModal;
  finally
    FormLista.Free;
  end;
  Dtm_PF.CarregaTransp;
end;

end.

