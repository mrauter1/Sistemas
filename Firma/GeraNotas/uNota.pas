unit uNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ExtCtrls, FMTBcd, SqlExpr,
  ComCtrls, DBClient, Provider, Gauges, IniFiles, StrUtils;

type
  TfNota = class(TForm)
    RadioGroup: TRadioGroup;
    GroupBox1: TGroupBox;
    DBGrid: TDBGrid;
    DataINI: TDateTimePicker;
    DataFim: TDateTimePicker;
    Label1: TLabel;
    BtnGerar: TButton;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    Gauge1: TGauge;
    procedure RadioGroupClick(Sender: TObject);
    procedure DataINIChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function TiraChar(vStr: String): String;
  procedure Molda(Texto, Preenchimento : string; PosIni, PosFim : integer; AlinDireita: Boolean; var Linha: String);
  Procedure CriaStr(var vStr: String; Tamanho: Integer);

  function Header(Envio, CGCFor, QtdNota: String): String;
  function Nota(QtdeItem, QtdeTit: Integer) : AnsiString;
  function ItemNota : AnsiString;
  function Fatura : String;
  function ListaPreco(CodFor: Integer; CodPro: String): String;
  function Trailler(Qtde: Integer) : String;

var
  fNota: TfNota;

implementation

{$R *.dfm}

uses
  uDtm_Notas, uDir;


function TiraChar(vStr: String): String;
begin
  Result:= vStr;
  Result:= StringReplace(Result, '/', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '-', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '.', '', [rfReplaceAll]);
  Result:= StringReplace(Result, '\', '', [rfReplaceAll]);
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

procedure Molda(Texto, Preenchimento : string; PosIni, PosFim : integer; AlinDireita: Boolean; Var Linha: AnsiString);
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

{function Header(Envio, CGCFor, QtdNota: String) : String;
begin
  CriaStr(Result, 35);
  Molda('000', '0', 1, 3, True, Result);
  Molda(CodFor, '0', 4, 9, True, Result);
  Molda(RazaoSocial, ' ', 10, 49, False, Result);
  Molda('92661453000187', ' ', 50, 64, False, Result);
  Molda(Envio, '0', 67, 78, True, Result);
end;}

function Header(Envio, CGCFor, QtdNota: String) : String;
begin
  CriaStr(Result, 41);
  Molda('000', '0', 1, 3, True, Result);
  Molda('302827', '0', 4, 9, True, Result); //CodFor
  Molda('92661453000187', ' ', 10, 23, False, Result);
  Molda(Envio, '0', 24, 37, True, Result);
  Molda(QtdNota, '0', 38, 41, True, Result);
end;

{function Nota(QtdeItem, QtdeTit: Integer) : AnsiString;
var
  vStr, BaseICM, BaseIPI: String[14];
  ICM, IPI: Integer;
begin
  with Dtm_Notas do
    begin
//      vStr:= '';
//      BaseICM:= FloatToStr(CDS_FiltroTotBaseICM.AsFloat * 100);
//      BaseIPI:= FloatToStr(CDS_FiltroTotBaseIPI.AsFloat * 100);
//      CriaStr(Result, 326);
      Molda('', '0', 1, 3, True, Result); //5 = kanban, 10 = oc, 15 = carro a carro
      Molda('', '0', 4, 5, True, Result); //0 = novos, 1 = pendentes, 2 = alterados
      Molda('', ' ', 6, 14, False, Result); // Codigo da peça
      Molda('', ' ', 15, 94,  False, Result); //Descrição da peça
      Molda('', '0', 95, 97, True, Result); //Setor
      Molda('', '0', 98, 103, True, Result); //Endereço Setor
      Molda('', '0', 104, 106, True, Result); //Unidade
      Molda('', ' ', 107, 107, False, Result); //CKD S=Sim, N=Não
      Molda('', '0', 108, 115, True, Result); //Data Emissão
      Molda('', '0', 116, 123, True, Result); //Data Entrega

      Molda('', '0', 124, 134, True, Result); //Número Pedido/Código Etiqueta
      Molda('', '0', 135, 154, True, Result); //Quantidade
      Molda('', ' ', 155, 156, False, Result); //Unidade de Medida
      Molda('', '0', 157, 176, True,  Result); //Valor Unitário
      Molda('', ' ', 177, 177, False,  Result); //Indicado do valor -> F =Fixo, V = Variavel
      Molda('', ' ', 178, 193, False, Result); //Uso do material -> se carro a carro = Nr. do carro
      Molda('', ' ', 194, 213, False, Result); //Referencia-> se carro a carro = Previsão ou Confirmação
      Molda('', '0', 214, 216, True, Result); //Condição pagamento 1
      Molda('', '0', 217, 219, True, Result); //Condição pagamento 2
      Molda('', '0', 220, 222, True, Result); //Condição pagamento 3
      Molda('', '0', 223, 225, True, Result); //Condição pagamento 4
      Molda('', '0', 226, 228, True, Result); //Condição pagamento 5
      Molda('', ' ', 229, 229, False, Result); //Entrega parcial S= Sim, N= não
      Molda('', ' ', 230, 230, False, Result); //Alteração Prazo entrega S= Sim, N= não
      Molda('', ' ', 231, 231, False, Result); //Alteração Valor unitário S= Sim, N= não
      Molda('', ' ', 232, 232, False, Result); //Alteração valo Fixo/Variavel S= Sim, N= não
      Molda('', ' ', 233, 233, False, Result); //Alteração em condição de pagamento S= Sim, N= não
      Molda('', ' ', 234, 234, False, Result); //Alteração em quantidade S= Sim, N= não
      Molda('', '0', 235, 245, True, Result); //Número de remessa
      Molda('', ' ', 246, 246, False, Result); //Vizualizado Hoje
      Molda('', ' ', 247, 276, False, Result); //Observações
    end;
end;         }

function Nota(QtdeItem, QtdeTit: Integer) : AnsiString;
var
  vStr, BaseICM, BaseIPI: String[14];
  Obs, Centro, CGCMF, NomeCli: String;
  ICM, IPI, I, J: Integer;
begin
  with Dtm_Notas do
    begin

      Obs:= GetCliObs(CDS_FiltroCODCLIENTE.AsString);
      GetCliDados(CDS_FiltroCODCLIENTE.AsString, CGCMF, NomeCli);

      I:= PosEx('CENTRO:', Obs);
      if i <> 0 then
      begin
        if Obs[i+7] = ' ' then J:= I+11
        else J:= I+10;
//        J:= PosEx(' ', Obs, I+6);
        Centro:= Trim(Copy(Obs, I+7, J-(I+6)));
      end
     else
      Centro:= '0';
      
      vStr:= '';
      BaseICM:= IntToStr(Round(CDS_FiltroTotBaseICM.AsFloat * 100));
      BaseIPI:= IntToStr(Round(CDS_FiltroTotBaseIPI.AsFloat * 100));
      CriaStr(Result, 180);

      Molda('1', '0', 1, 3, True, Result);
      Molda(TiraChar(CGCMF), '0', 4, 17, True, Result);

      if fNota.RadioGroup.ItemIndex = 0 then
        Molda('BRMP', ' ', 18, 21, False, Result) //BRMP=Marcopolo, BRCF=Ciferal
      else
        Molda('BRCF', ' ', 18, 21, False, Result); //BRMP=Marcopolo, BRCF=Ciferal

      Molda(Centro, ' ', 22, 25, False, Result); //Tabela 1

      Molda(CDS_FiltroNumero.AsString, '0', 26, 35, True, Result);
      Molda('NFF', ' ', 36, 39, False, Result); //EspecieNF=NF ou NFF

      Molda('0', ' ', 39,  39,  False, Result);
      Molda(FormatDateTime('ddmmyyyy', CDS_FiltroDataDocumento.AsDateTime), '0', 40, 47, True, Result);
      Molda(CDS_FiltroCodFiscal.AsString, '0', 48, 51, True, Result);
      Molda('Z045', ' ', 52,  55,  False, Result); //Condição pagamento, tabela 2
      Molda(IntToStr(Round(CDS_FiltroTotNota.AsFloat * 100)), '0', 56, 68, True, Result); //??
      Molda(IntToStr(Round(CDS_FiltroTotBruto.AsFloat * 100)), '0', 69, 79, True, Result);
      Molda(IntToStr(Round(CDS_FiltroTotIPI.AsFloat * 100)), '0', 80, 90, True, Result);
      Molda(IntToStr(Round(CDS_FiltroTotBruto.AsFloat * 100)), '0', 91, 101, True, Result);
      Molda(IntToStr(Round(CDS_FiltroTotICM.AsFloat * 100)), '0', 102, 112, True, Result);
      Molda(IntToStr(Round(CDS_FiltroTotFrete.AsFloat * 100)), '0', 113, 123, True, Result);
      Molda(IntToStr(Round(CDS_FiltroTotNota.AsFloat * 100)), '0', 124, 136, True, Result);
      Molda('', ' ', 137,  146,  False, Result); //Nota fiscal saída
      Molda('', ' ', 147,  156,  False, Result); //nota fiscal remessa
      Molda('', ' ', 157, 172,  False, Result); //Ato concessório
      Molda(IntToStr(QtdeItem), '0', 173, 176, True, Result);
      Molda(IntToStr(QtdeTit), '0', 177, 180, True, Result);
    end;
end;


function ItemNota : AnsiString;
var
  CodigoPeca, Observacao: String;
  I, J: Integer;
// Remessa, Erro: String;
  TotalItem, QuantUnPed, PrecoUnitario: Double;
  UM: String;
  X: Integer;
begin
  X:= 0;
  with Dtm_Notas do
    begin
//      Erro:= 'A nota Nº ' + CDS_FiltroNumero.AsString + ' foi faturada em unidade errada. Cancele-a e fature outra nota em sub - unidade.';
//      Observacao:= CDS_MsgObservacao1.AsString;
      Observacao:= GetProObs(CDS_MCliProCodProduto.AsString);

      I:= PosEx('COD PROD: ', Observacao);
      if I <> 0 then
      begin
        J:= PosEx('|', Observacao, I+10);
        CodigoPeca:= Trim(Copy(Observacao, I+9, J-(I+9)));
      end
     else
      CodigoPeca:= '0';

      I:= PosEx('UM: ', Observacao);
      if I <> 0 then
      begin
        J:= PosEx('|', Observacao, I+4);
        UM:= Trim(Copy(Observacao, I+3, J-(I+3)));
      end
     else
      UM:= 'L';

     if UM = 'L' then
       QuantUnPed:= GetProVol(CDS_MCliProCODPRODUTO.AsString, CDS_MCliProQuantAtendida.AsFloat)
    else
       QuantUnPed:= GetProPeso(CDS_MCliProCODPRODUTO.AsString, CDS_MCliProQuantAtendida.AsFloat);

{      if CDS_MCliPro.RecNo > 1 then
      while X < CDS_MCliPro.RecNo do
        begin
          Observacao:= Copy(Observacao, Pos('REM: ', UpperCase(Observacao)) + 5, Length(Observacao) - (Pos('REM: ', UpperCase(Observacao)) + 5));
          inc(X)
        end;
      if Pos('COD PROD: ', UpperCase(Observacao)) > 0 then
        CodigoPeca:= Copy(Observacao, Pos('COD PROD: ', UpperCase(Observacao)) + 10, 9);
      if Pos('REM: ', UpperCase(Observacao)) > 0 then
        Remessa:= Copy(Observacao, Pos('REM: ', UpperCase(Observacao)) + 5, 7);
                                       }
      TotalItem:= ((CDS_MCliProPreco.AsFloat/CDS_MCliProUNIDADEESTOQUE.AsFloat)*CDS_MCliProQuantAtendida.AsFloat)-CDS_MCliProVALICM.AsFloat;
      PrecoUnitario:= TotalItem/QuantUnPed;

      CriaStr(Result, 207);
      Molda('002', '0', 1, 3, True, Result);
      Molda(CDS_FiltroNumero.AsString, '0', 4, 13, True, Result);
      Molda('NFF', ' ', 14,  17,  False, Result); //Especie= NFF ou NF
      Molda('0', ' ', 17, 17, False, Result);
      Molda(GetOrdemCOmpra(CDS_FiltroCodPedido.AsString), '0', 18, 27, True, Result); //Pedido Compra
      Molda('10', '0', 28, 32, True, Result); //Item Pedido Compra
      Molda(CodigoPeca, ' ', 33, 50, False, Result); //Codigo Material
      Molda(GetITDescricao(CDS_MCliProCodProduto.AsString), ' ', 51, 90, False, Result); //Descrição Material
      Molda(UM, ' ', 91, 93, False, Result); //Unidade de medida - Tabela 3
      Molda(CDS_MCliProClassifFiscal.AsString, '0', 94, 101, True, Result);
      Molda('Q3', ' ', 102, 103, False, Result); //Código imposto - Tabela 4
      Molda(IntToStr(Round(QuantUnPed*1000)), '0', 104, 114, True, Result);
      Molda(IntToStr(Round(QuantUnPed*1000)), '0', 115, 125, True, Result); //Quant Unidade preço pedido
      Molda(UM, ' ', 126, 128, False, Result); //Unidade Medida preço pedido
      Molda('1', '0', 129, 131, True, Result); //Unidade preço
      Molda(IntToStr(Round(PrecoUnitario*100)), '0', 132, 142, True, Result);
      Molda(IntToStr(Round(Round(PrecoUnitario*100)*QuantUnPed)), '0', 143, 153, True, Result);
      Molda(IntToStr(CDS_MCliProAliqIPI.AsInteger), '0', 154, 155, True, Result);
      Molda(IntToStr(Round(CDS_MCliProValIPI.AsFloat * 100)), '0', 156, 166, True, Result);
      Molda(IntToStr(Round(CDS_MCliProValBaseIPI.AsFloat * 100)), '0', 167, 177, True, Result);
      Molda(IntToStr(CDS_MCliProAliqICM.AsInteger), '0', 178, 179, True, Result);
      Molda(IntToStr(Round(CDS_MCliProValICM.AsFloat * 100)), '0', 180, 190, True, Result);
      Molda(IntToStr(Round(CDS_MCliProValBaseICM.AsFloat * 100)), '0', 191, 201, True, Result);
      Molda('9999', '0', 202, 205, True, Result); //Grupo Mercadorias Tabela 5
      Molda('0', '0', 206, 206, True, Result); //Origem Material Tabela 6
      Molda('2', '0', 207, 207, True, Result); //Utilização material Tabela 7
    end;
end;

function Fatura : String;
begin
  with Dtm_Notas do
    begin
      CriaStr(Result, 36);
      Molda('003', '0', 1, 3, True, Result);
      Molda('0', '0', 4, 13, True, Result);
      Molda('NFF', ' ', 14, 16, False, Result); //Especie NFF, NF
      Molda(CDS_FiltroSerie.AsString, ' ', 17, 17, False, Result);
      Molda(FormatDateTime('ddmmyyyy', CDS_FaturaDataVencimento.AsDateTime), '0', 18, 25, True, Result);
      Molda(FloatToStr(CDS_FaturaTotPrestacao.AsFloat * 100), '0', 26, 36, True, Result);
    end;
end;

function ListaPreco(CodFor: Integer; CodPro: String): String;
begin
  with Dtm_Notas do
    begin
      CriaStr(Result, 62);
      Molda(IntToStr(CodFor), '0', 1, 6, True, Result);
      Molda('', ' ', 7, 24, False, Result); //Código Material
      Molda('', '0', 25, 44, True, Result); //Valor Unitário
      Molda('', ' ', 45, 62, False, Result); //Cod Material Referencia
    end;
end;

function Trailler(Qtde: Integer) : String;
begin
  CriaStr(Result, 13);
  Molda('999', '0', 1, 3, True, Result);
  Molda(IntToStr(Qtde), '0', 4, 13, True, Result);
end;

procedure TfNota.RadioGroupClick(Sender: TObject);
begin
  Dtm_Notas.Filtra;
end;

procedure TfNota.DataINIChange(Sender: TObject);
begin
    Dtm_Notas.Filtra;
end;

procedure TfNota.FormActivate(Sender: TObject);
begin
  Dtm_Notas.Filtra;
end;

procedure TfNota.FormCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'GeraNota.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'GeraNota.Ini');
      Edit1.Text:= ArqIni.ReadString('Values', 'DefaultDir', ExtractFilePath(Application.ExeName) + 'Arquivos');
      fNota.Top:= ArqIni.ReadInteger('Values', 'Form Top', fNota.Top);
      fNota.Left:= ArqIni.ReadInteger('Values', 'Form Left', fNota.Left);
      ArqIni.Free;
    end
  else
    Edit1.Text:= ExtractFilePath(Application.ExeName) + 'Arquivos';

  DataIni.Date:= now;
  DataFim.Date:= now;
end;

procedure TfNota.BtnGerarClick(Sender: TObject);
var
  Pre, DataHora: String;
  vLinha: AnsiString;
  vArq: TextFile;
  Cont: Integer;
begin
  try
    Screen.Cursor:= crHourGlass;
  with Dtm_Notas do
    begin
      CDS_Filtro.First;
      Gauge1.MaxValue:= CDS_Filtro.RecordCount * 3 + 1;

      case RadioGroup.ItemIndex of
        0: Pre:= 'MP';
        1: Pre:= 'CF';
        2: Pre:= 'SY';
      end;

      if not DirectoryExists(Edit1.Text) then
      if not CreateDir(Edit1.Text) then
        raise Exception.Create('O diretório para salvar o arquivo não existe e é impossivel cria-lo.');

      AssignFile(vArq, Edit1.Text + '\' + Pre + '338427' + '0' + CDS_FiltroNumero.AsString + '.txt');
      ReWrite(vArq); //Cria o arquivo em branco
      DataHora:= FormatDateTime('ddmmyyyyhhnnss', Now);

      vLinha:= Header(DataHora, '', IntToStr(CDS_Filtro.RecordCount)); // Passa os dados formatados para vLinha
      Writeln(vArq,vLinha); //Passa as informações de vLinha para o arquivo
      Gauge1.Progress := Gauge1.Progress + 1;
      vLinha:= '';
      Cont:= 1;

      while not CDS_Filtro.Eof do //Escreve no arquivo todos os registros tipo 01
        begin
          inc(Cont);
          vLinha:= Nota(CDS_MCliPro.RecordCount, CDS_Fatura.RecordCount);
          Writeln(vArq, vLinha);
          Gauge1.Progress := Gauge1.Progress + 1;
          vLinha:= '';
          CDS_MCliPro.First;
          Gauge1.MaxValue:= Gauge1.MaxValue +  CDS_MCliPro.RecordCount - 1;
          while not CDS_MCliPro.Eof do //Escreve todos registros 02
            begin
              inc(Cont);
              vLinha:= ItemNota;
              Gauge1.Progress := Gauge1.Progress + 1;
              Writeln(vArq, vLinha);
              vLinha:= '';
              CDS_MCliPro.Next;
            end;
          CDS_Fatura.First;
          Gauge1.MaxValue:= Gauge1.MaxValue + CDS_Fatura.RecordCount - 1;          
          while not CDS_Fatura.Eof do //Escreve todos registros 03
            begin
              inc(Cont);
              vLinha:= Fatura;
              Gauge1.Progress := Gauge1.Progress + 1;
              Writeln(vArq, vLinha);
              vLinha:= '';
              CDS_Fatura.Next;
            end;
          CDS_Filtro.Next;
        end;

{      CDS_Filtro.First;
      while not CDS_Filtro.Eof do
        begin
          CDS_MCliPro.First;
          while not CDS_MCliPro.Eof do //Escreve todos registros 02
            begin
              inc(Cont);
              vLinha:= ItemNota;
              Gauge1.Progress := Gauge1.Progress + 1;
              Writeln(vArq, vLinha);
              vLinha:= '';
              CDS_MCliPro.Next;
            end;
          CDS_Filtro.Next;
        end;

      CDS_Filtro.First;
      while not CDS_Filtro.Eof do
        begin
          CDS_Fatura.First;
          while not CDS_Fatura.Eof do //Escreve todos registros 03
            begin
              inc(Cont);
              vLinha:= Fatura;
              Gauge1.Progress := Gauge1.Progress + 1;
              Writeln(vArq, vLinha);
              vLinha:= '';
              CDS_Fatura.Next;
            end;
          CDS_Filtro.Next;
        end;                 }

      vLinha:= Trailler(Cont + 1);
      Writeln(vArq, vLinha);
      Gauge1.Progress := Gauge1.Progress + 1;
      vLinha:= '';

      CloseFile(vArq); //Fecha o arquivo gerado
    end;
  Application.MessageBox('Arquivo gerado com sucesso!', 'Completo', MB_OK);
  finally
    Screen.Cursor:= crDefault;
    Gauge1.Progress:= 0;
  end;
end;

procedure TfNota.Button1Click(Sender: TObject);
begin
  fDir.ShowModal;
end;

procedure TfNota.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ArqIni: TIniFile;
begin
  ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) + 'GeraNota.Ini');
  ArqIni.WriteString('Values', 'DefaultDir', Edit1.Text);
  ArqIni.WriteInteger('Values', 'Form Top', fNota.Top);
  ArqIni.WriteInteger('Values', 'Form Left', fNota.Left);
end;

end.
