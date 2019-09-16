unit uAnp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, uDtm_Anp, StdCtrls, Gauges, IniFiles, DateUtils, Grids, DBGrids,
  Data.DB;

type
  TfAnp = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    CBXMes: TComboBox;
    EditAno: TEdit;
    Gauge1: TGauge;
    BtnGerar: TButton;
    Button1: TButton;
    Edit1: TEdit;
    Label2: TLabel;
    DBGrid: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnGerarClick(Sender: TObject);
    function IncCont: Integer;
    function RegCont: String;
    procedure Notas;

    function Movimento(Cont, CodOp, NumNota: Integer; NumSerie, ID, CodMun, CodAtiv, CodPro, Inst2: String;
    QtUnANP, QtKG: Real; Data: TDateTime): String;
    procedure MovVenda;
    procedure MovCompra;
    procedure CalculaTotais(CodGrupo: String);    
    procedure EstoqueIni(Cont: Integer; CodGrupo: String);
    procedure EstoqueFim(Cont: Integer; CodGrupo: String);
    procedure TotalGeralSaida(Cont: Integer; CodGrupo: String);
    procedure TotalizadorSaida;
    procedure TotalGeralEntrada(Cont: Integer; CodGrupo: String);
    procedure TotalizadorEntrada;
    procedure MovConsumo;       

    procedure DadosCliente(CodCliente: String; var ID, CodMun, CodAtiv: String);
    procedure DadosFor(CodFor: String; var Inst2, ID, CodMun, CodAtiv, CodPais, CodSerieNF: String);
    procedure ProDados(CodProduto: String; var ProdOp, ModalMov, Veiculo, LicImp,
    NumImp, Caract, Metodo, UnMed, ValorCaract, OpResult, MassaEspecifica: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function TiraChar(vStr: String): String;
  Procedure CriaStr(var vStr: String; Tamanho: Integer);
  procedure Molda(Texto, Preenchimento: string; PosIni, PosFim: integer; AlinDireita: Boolean; Var Linha: String);

var
  fAnp: TfAnp;
  vArq: TextFile;
  Ini, Fim: TDateTime;
  ProFim: String;
  VolFimEnt, PesoFimEnt, VolFimSai, PesoFimSai,
  VolEstIni, PesoEstIni, VolEstFim, PesoEstFim: Double;
  ContJ: Integer;

implementation

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

function TfAnp.RegCont: String;
var
 Total: Word;
begin
  Total:= (Dtm_Anp.CDS_MovCli.RecordCount+Dtm_Anp.CDS_MovFor.RecordCount+1)+56;
  Gauge1.MaxValue:= Total-1;

  Result:= '';
  CriaStr(Result, 33);
  Molda('0'{Contador Sequencial}, '0', 1, 10, True, Result);
  Molda('1092661453'{'1092661453000187'}, '0', 11, 20, True, Result);
  Molda(FormatDateTime('mmyyyy', Ini), '0', 21, 26, True, Result);
  Molda(IntToStr(Total), '0', 27, 33, True, Result);

  writeln(vArq, Result);
end;

procedure TfAnp.ProDados(CodProduto: String; var ProdOp, ModalMov, Veiculo, LicImp,
 NumImp, Caract, Metodo, UnMed, ValorCaract, OpResult, MassaEspecifica: String);
var
  Obs: String;
  I, J: Integer;
begin
  with Dtm_ANP do
  begin
    SQL.Close;

    SQL.Sql.Clear;

    SQL.Sql.Add('Select D.DESCRICAOPRO, P.Peso, P.Cubagem from Prodesc_Adicional D, Produto P');
    SQL.Sql.Add('where P.CodProduto =:Cod and D.CodProDesc = P.CodProDescAdicional');

    SQL.ParamByName('Cod').AsString := CodProduto;

    SQL.Open;

    Obs:= SQL.FieldByName('DESCRICAOPRO').AsString;
    if Obs = '' then Exit;
    I:= PosEx(':', Obs);
    J:= PosEx(#13, Obs, I);
    ProdOp:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    ModalMov:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    Veiculo:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    LicImp:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    NumImp:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    Caract:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    Metodo:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    UnMed:= Trim(Copy(Obs, I+1, J-I));

    ValorCaract:= FloatToStr(Round(Sql.FieldByName('Peso').AsFloat/(Sql.FieldByName('Cubagem').AsFloat)*100));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    if J= 0 then J:= Length(Obs)+1;
    OpResult:= Trim(Copy(Obs, I+1, J-I));

//    I:= PosEx(':', Obs, J);
//    J:= PosEx(#13, Obs, I);
    MassaEspecifica:= FloatToStr(Round(Sql.FieldByName('Peso').AsFloat/(Sql.FieldByName('Cubagem').AsFloat)*1000));
  end;
end;

procedure TfAnp.DadosCliente(CodCliente: String; var ID, CodMun, CodAtiv: String);
begin
  CodMun:= '0'; CodAtiv:= '0';
  with Dtm_Anp do
  begin
    SQl.Close;
    SQL.Sql.Clear;

    Sql.sql.Add('select ANP.Identificacao, ANP.CodMunicipio, Anp.CodAtividade '+
                'from ClienteInformeAnp ANP where ANP.CodCliente =:Cod');

    Sql.ParamByName('Cod').AsString:= CodCliente;
    Sql.Open;

    if Sql.Eof then
    begin
      Sql.Sql.Clear;
      Sql.SQL.Add('insert into ClienteInformeAnp(CodCliente, Identificacao) '+
                  'Values(:CodCliente, :ID)');
      Aux.Sql.Clear;
      Aux.Sql.Add('select NumeroCGCMF from Cliente where CodCliente =:CodCliente');
      Aux.ParamByName('CodCliente').AsString:= CodCliente;
      Aux.Open;
      ID:= Trim(TiraChar(Aux.FieldByName('NumeroCGCMF').AsString));
      Sql.ParamByName('CodCliente').AsString:= CodCliente;
      Sql.ParamByName('ID').AsString:= ID;
      Sql.ExecSQL;
    end
   else if Trim(Sql.FieldByName('Identificacao').AsString) = '' then
    begin
//      Sql.Sql.Clear;
//      Sql.SQL.Add('Update ClienteInformeAnp set Identificacao =:ID '+
//                  'where CodCliente =:CodCliente');
      Aux.Sql.Clear;
      Aux.Sql.Add('select NumeroCGCMF from Cliente where CodCliente =:CodCliente');
      Aux.ParamByName('CodCliente').AsString:= CodCliente;
      Aux.Open;
      ID:= Trim(TiraChar(Aux.FieldByName('NumeroCGCMF').AsString));
      CodMun:= SQL.FieldByName('CodMunicipio').AsString;
      CodAtiv:= SQL.FieldByName('CodAtividade').AsString;
//      Sql.ParamByName('CodCliente').AsString:= CodCliente;
//      Sql.ParamByName('ID').AsString:= ID;
//      Sql.ExecSQL;
    end
   else
    begin
      ID:= SQL.FieldByName('Identificacao').AsString;
      CodMun:= SQL.FieldByName('CodMunicipio').AsString;
      CodAtiv:= SQL.FieldByName('CodAtividade').AsString;
    end;
  end;
end;

procedure TfAnp.DadosFor(CodFor: String; var Inst2, ID, CodMun, CodAtiv, CodPais, CodSerieNF: String);
var
  Obs: String;
  I, J: Integer;
begin
  with Dtm_ANP do
  begin
    SQL.Close;

    SQL.Sql.Clear;

    SQL.Sql.Add('Select OBSERVACAO, NumeroCGCMF from Forneced ');
    SQL.Sql.Add('where CodFornecedor =:Cod');

    SQL.ParamByName('Cod').AsString := CodFor;

    SQL.Open;

    Obs:= SQL.FieldByName('OBSERVACAO').AsString;
    if Obs = '' then Exit;
    I:= PosEx('ANP:', Obs);
    if I = 0 then Exit;
    i:= PosEx(':', Obs, I+1);
    I:= PosEx(':', Obs, I+1);
    J:= PosEx(#13, Obs, I);
    Inst2:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    ID:= Trim(Copy(Obs, I+1, J-I));
    if (ID = '') or (ID = '0') then
      ID:= SQL.FieldByName('NumeroCGCMF').AsString;

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    CodMun:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    CodAtiv:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
    J:= PosEx(#13, Obs, I);
    CodPais:= Trim(Copy(Obs, I+1, J-I));

    I:= PosEx(':', Obs, J);
//    J:= PosEx(#13, Obs, I);
    CodSerieNF:= Trim(Copy(Obs, I+1, 3));
  end;
end;

function TfAnp.Movimento(Cont, CodOp, NumNota: Integer; NumSerie, ID, CodMun, CodAtiv, CodPro, Inst2: String;
  QtUnANP, QtKG: Real; Data: TDateTime): String;
var
  ProdOp, ModalMov, Veiculo, LicImp,
 NumImp, Caract, Metodo, UnMed, ValorCaract, OpResult, MassaEspecifica: String;
begin
  ProDados(CodPro, ProdOp, ModalMov, Veiculo, LicImp,
  NumImp, Caract, Metodo, UnMed, ValorCaract, OpResult, MassaEspecifica);

  Result:= '';
  CriaStr(Result, 198);
  Molda(IntTOStr(Cont){Contador Sequencial}, '0', 1, 10, True, Result);
  Molda('1092661453', '0', 11, 20, True, Result);
  Molda(FormatDateTime('mmyyyy', Ini){IntToStr(MesRef)}, '0', 21, 26, True, Result);
  Molda(IntToStr(CodOp){Cod Op.}, '0', 27, 33, True, Result);
  Molda('1032967'{Cod Inst.}, '0', 34, 40, True, Result);
  Molda(Inst2{Cod Inst.2}, '0', 41, 47, True, Result);
  Molda(ProdOp{Cod Prod. Oper.}, '0', 48, 56, True, Result);
  Molda(FloatToStr(round(QtUnANP)){Qt.Prod.Op.unANP}, '0', 57, 71, True, Result);
  Molda(FloatToStr(round(QtKG)){Qt.Prod.Op.Kg}, '0', 72, 86, True, Result);
  Molda(ModalMov{Cod Modal Mv}, '0', 87, 87, True, Result);
  Molda(Veiculo{Cod Veiculo}, '0', 88, 94, True, Result);
  Molda(ID{ID.Terceiro Envolvido}, '0', 95, 108, True, Result);
  Molda(CodMun{Cod Municipio}, '0', 109, 115, True, Result);
  Molda(CodAtiv{Cod Ativ.Econ.Terceiro}, '0', 116, 120, True, Result);
  Molda(IntToStr(1554){Cod país}, '0', 121, 124, True, Result);
  Molda(LicImp{Num.Licença.Imp.}, '0', 125, 134, True, Result);
  Molda(NumImp{Num. Declaracao Imp.}, '0', 135, 144, True, Result);
  Molda(IntToStr(NumNota){Num.NotaFiscalOpCom.}, '0', 145, 151, True, Result);
  Molda(NumSerie{Cod SerieNotaFisc.}, '0', 152, 153, True, Result);
  Molda(FormatDateTime('ddmmyyyy', Data){Data Op.Com.}, '0', 154, 161, True, Result);
  Molda(''{Cod.Serv.Acordado}, '0', 162, 162, True, Result);
  Molda(Caract{Cod Caracteristica}, '0', 163, 165, True, Result);
  Molda(Metodo{Cod Mtd.Aferição}, '0', 166, 168, True, Result);
  Molda(UnMed{Cod Un.Med.}, '0', 169, 170, True, Result);
  Molda(ValorCaract{Val.Caract.}, '0', 171, 180, True, Result);
  Molda(OpResult{CodProOpResultante}, '0', 181, 189, True, Result);
  Molda(MassaEspecifica{MassaPro.}, '0', 190, 196, True, Result);
  Molda(''{RecipienteGLP}, '0', 197, 198, True, Result);
  writeln(vArq, Result);
end;

procedure TfAnp.MovVenda;
var
  ID, CodMun, CodAtiv, CurGru, PPro: String;
  Comp, PNum: Integer;
  PData: TDateTime;
  Vol, Peso: Double;
begin
//  Quant:= 0;
  Vol:= 0;
  Peso:= 0;
  with Dtm_Anp do
  begin
    DadosCliente(CDS_MovCliCodCliente.AsString, ID, CodMun, CodAtiv);

{    Mov.Sql.Clear;

    Mov.Sql.Add('Select MCPro.ChaveNFPro, Pro.CodProduto, Pro.CodGrupoSub from MCli MC, MCliPro MCPro, Produto Pro');
    Mov.Sql.Add('where MC.Numero =:Numero and MCPro.ChaveNF = MC.ChaveNF and Pro.CodProduto = MCPro.CodProduto');
    Mov.Sql.Add('order by Pro.CodGrupoSub');

    Mov.parambyname('Numero').AsString := CDS_MovCliNumero.AsString;
//    Sql.ParamByName('CodGrupoSub').AsString:= GetProGrupo(Cds_MovCliCODPRODUTO).AsString;

    Mov.Open;      }

    CurGru:= GetProGrupo(CDS_MovCliCodProduto.AsString);
    PNum:= Cds_MovCliNumero.AsInteger;
    PPro:= CDS_MovCliCodProduto.AsString;
    PData:= Cds_MovCliDataDocumento.AsDateTime;
    while (GetProGrupo(CDS_MovCliCodProduto.AsString) = CurGru)
    and (Cds_MovCliNUMERO.AsInteger = PNum) and not (CDS_MovCli.Eof) do
    begin
      PPro:= CDS_MovCliCodProduto.AsString;
      Vol:= Vol+ Round(GetProVol(PPro, Cds_MovCliQUANTATENDIDA.AsFloat));
      Peso:= Peso+ Round(GetProPeso(PPro, Cds_MovCliQUANTATENDIDA.AsFloat));
      Cds_MovCli.Next;
    end;

    if CDS_MovCliCodComprovante.AsString = '007' then
    begin
     Comp:= 1012004;
//       if Quant < 0 then
//        Quant:= Quant*-1
    end
   else
    Comp:= 1012002;

//    Vol:= GetProVol(PPro, Quant);
//    Peso:= GetPropeso(PPro, Quant);

    Movimento(IncCont, Comp, PNum, '04', ID, CodMun, CodAtiv,
    PPro, '', Vol, Peso, PData);
  end;
end;

procedure TfAnp.MovCompra;
var
  Inst2, ID, CodMun, CodAtiv, CodPais, CodSerieNF, CurGru, PPro: String;
  PNum: Integer;
  PData: TDateTime;
  Vol, Peso: Double;
begin
//  Quant:= 0;
  Peso:= 0;
  Vol:= 0;
  with Dtm_Anp do
  begin
    DadosFor(CDS_MovForCODFORNECEDOR.AsString, Inst2, ID, CodMun, CodAtiv, CodPais, CodSerieNF);

    PPro:= CDS_MovForCodProduto.AsString;
    PNum:= Cds_MovForNumero.AsInteger;
    PData:= Cds_MovForDataEntrada.AsDateTime;
    CurGru:= GetProGrupo(CDS_MovForCodProduto.AsString);
    while (GetProGrupo(CDS_MovForCodProduto.AsString) = CurGru)
    and (Cds_MovForNUMERO.AsInteger = PNum) and not (CDS_MovFor.Eof) do
    begin
      Vol:= Vol+ Round(GetProVol(PPro, Cds_MovForQUANT.AsFloat));
      Peso:= Peso+ Round(GetProPeso(PPro, Cds_MovForQUANT.AsFloat));
      Cds_MovFor.Next;
    end;

//    Vol:= GetProVol(PPro, Quant);
//    Peso:= GetPropeso(PPro, Quant);

    Movimento(IncCont, 1011001, PNum, CodSerieNF,ID,CodMun,CodAtiv,
    PPro, Inst2, Vol, Peso, PData);
  end;
end;

procedure TfAnp.CalculaTotais(CodGrupo: String);
var
  CodPro: String;
begin
  VolFimSai:= 0;
  PesoFimSai:= 0;
  with Dtm_Anp do
  begin
    Sql.Sql.Clear;
    Sql.Sql.Add('select MCPro.ChaveNF, MCPro.QuantAtendida, P.CodProduto, P.UnidadeEstoque, P.Cubagem, P.Peso '  +
                   'from MCli MC, MCliPro MCPro, Produto P ' +
                   'where MC.DataDocumento between :DataIni and :DataFim '+
                   'and (MC.CodComprovante=:Vendas or MC.CodCOmprovante=:VendaTerc or MC.CodComprovante=:Transf) '+
                   'and MCPro.ChaveNF = MC.ChaveNF and P.CodGrupoSub =:CodGrupo ' +
                   'and MCPro.CodProduto = P.CodProduto');
    Sql.ParamByName('DataIni').AsDate:= Ini;
    Sql.ParamByName('DataFim').AsDate:= Fim;
    SQL.ParamByName('Vendas').AsString:= '001';
    SQL.ParamByName('VendaTerc').AsString:= '035';
    SQL.ParamByName('Transf').AsString:= '042';
//    SQL.ParamByName('SaiIns').AsString:= '100';
    Sql.ParamByName('CodGrupo').AsString:= CodGrupo;

    Sql.Open;
    if Sql.Eof then
    begin
      Sql.Sql.Clear;
      Sql.Sql.Add('select P.CodProduto from Produto P where P.CodGrupoSub =:CodGrupo');
      Sql.ParamByName('CodGrupo').AsString:= CodGrupo;
      Sql.Open;
      CodPro:= Sql.FieldByName('CodProduto').AsString
    end
   else
    begin
      CodPro:= Sql.FieldByName('CodProduto').AsString;
      while not Sql.Eof do
      begin
        VolFimSai:= VolFimSai+Round((Sql.FieldByName('QuantAtendida').AsFloat/SQl.FieldByName('UnidadeEstoque').AsFloat)
         *SQl.FieldByName('Cubagem').AsFloat*1000);
        PesoFimSai:= PesoFimSai+Round((Sql.FieldByName('QuantAtendida').AsFloat/SQl.FieldByName('UnidadeEstoque').AsFloat)
         *SQl.FieldByName('Peso').AsFloat);

        Sql.Next;
      end;
    end;
  end;

    ProFim:= CodPro;

  VolFimEnt:= 0;
  PesoFimEnt:= 0;

  with Dtm_Anp do
  begin
    Sql.Sql.Clear;
    Sql.Sql.Add('select MFPro.Quant, P.CodProduto, P.UnidadeEstoque, P.Cubagem, P.Peso '  +
                   'from MFor MF, MForPro MFPro, Produto P ' +
                   'where MF.DataEntrada between :DataIni and :DataFim '+
                   'and MF.CodComprovante=:Compras '+
                   'and MFPro.ChaveNF = MF.ChaveNF and P.CodGrupoSub =:CodGrupo ' +
                   'and MFPro.CodProduto = P.CodProduto');
    Sql.ParamByName('DataIni').AsDate:= Ini;
    Sql.ParamByName('DataFim').AsDate:= Fim;
    SQL.ParamByName('Compras').AsString:= '010';
    Sql.ParamByName('CodGrupo').AsString:= CodGrupo;

    Sql.Open;
    if Sql.Eof then
    begin
      Sql.Sql.Clear;
      Sql.Sql.Add('select P.CodProduto from Produto P where P.CodGrupoSub =:CodGrupo');
      Sql.ParamByName('CodGrupo').AsString:= CodGrupo;
      Sql.Open;
      CodPro:= Sql.FieldByName('CodProduto').AsString;
    end
   else
    begin
      CodPro:= Sql.FieldByName('CodProduto').AsString;
      while not Sql.Eof do
      begin
        VolFimEnt:= VolFimEnt+Round((Sql.FieldByName('Quant').AsFloat/SQl.FieldByName('UnidadeEstoque').AsFloat)
         *SQl.FieldByName('Cubagem').AsFloat*1000);
        PesoFimEnt:= PesoFimEnt+Round((Sql.FieldByName('Quant').AsFloat/SQl.FieldByName('UnidadeEstoque').AsFloat)
         *SQl.FieldByName('Peso').AsFloat);

        Sql.Next;
      end;
    end;

    ProFim:= CodPro;
  end;
end;

procedure TfAnp.EstoqueIni(Cont: Integer; CodGrupo: String);
var
  TotalPeso, TotalVol: Double;
  CodPro: String;
begin
  TotalVol:= 0;
  TotalPeso:= 0;
  with Dtm_Anp do
  begin
    SQL.Sql.Clear;

    SQL.SQL.Add('select EM.CodProduto, EM.SaldoAtual, EM.Codanomes, P.Cubagem, P.Peso, P.UnidadeEstoque');
    SQL.SQL.Add('from EstoqMes EM, Produto P');
    SQL.SQL.Add('where Em.CodAnoMes =:Mes and');
    Sql.SQL.Add('P.CodGrupoSub =:CodGrupo and');
    SQL.SQL.Add('EM.CodProduto = P.CodProduto');
    SQL.SQL.Add('Order by EM.CodProduto');

//    DecodeDate(Ini, Ano, Mes, Dia);
{    if Mes = 1 then
    begin
      Mes:= 12;
      Dec(Ano);
    end
   else Dec(Mes);   }
//    Data:= EncodeDate(Ano, Mes, Dia);

    SQl.ParamByName('Mes').AsString:= FormatDateTime('yyyymm', IncMonth(Ini, -1));
    Sql.ParamByName('CodGrupo').AsString:= CodGrupo;

    SQL.Open;
    CodPro:= Sql.FieldByName('CodProduto').AsString;
    while not Sql.Eof do
    begin
      TotalVol:= TotalVol +
      Round((SQl.FieldByName('SaldoAtual').AsFloat / SQl.FieldByName('UnidadeEstoque').AsFloat)
       *SQl.FieldByName('Cubagem').AsFloat*1000);

      TotalPeso:= TotalPeso +
      Round((SQl.FieldByName('SaldoAtual').AsFloat / SQl.FieldByName('UnidadeEstoque').AsFloat)
       *SQl.FieldByName('Peso').AsFloat);
       Sql.Next;
    end;
    VolEstIni:= TotalVol;
    PesoEstIni:= TotalPeso;

    Movimento(Cont, 3010003, 0, '0', '0', '0', '0',
    CodPro, '0', TotalVol,
     TotalPeso,StartOfTheMonth(Ini));
  end;
end;

procedure TfAnp.EstoqueFim(Cont: Integer; CodGrupo: String);
var
  TotalPeso, TotalVol: Double;
  CodPro: String;
begin
  TotalVol:= 0;
  TotalPeso:= 0;
  with Dtm_Anp do
  begin
    SQL.Sql.Clear;

    SQL.SQL.Add('select EM.CodProduto, EM.SaldoAtual, EM.Codanomes, P.Cubagem, P.Peso, P.UnidadeEstoque');
    SQL.SQL.Add('from EstoqMes EM, Produto P');
    SQL.SQL.Add('where Em.CodAnoMes =:Mes and');
    Sql.SQL.Add('P.CodGrupoSub =:CodGrupo and');
    SQL.SQL.Add('EM.CodProduto = P.CodProduto');
    SQL.SQL.Add('Order by EM.CodProduto');

    SQl.ParamByName('Mes').AsString:= FormatDateTime('yyyymm', Ini);
    Sql.ParamByName('CodGrupo').AsString:= CodGrupo;

    SQL.Open;
    CodPro:= Sql.FieldByName('CodProduto').AsString;
    while not Sql.Eof do
    begin
      TotalVol:= TotalVol +
      Round((SQl.FieldByName('SaldoAtual').AsFloat / SQl.FieldByName('UnidadeEstoque').AsFloat)
       *SQl.FieldByName('Cubagem').AsFloat*1000);

      TotalPeso:= TotalPeso +
      Round((SQl.FieldByName('SaldoAtual').AsFloat / SQl.FieldByName('UnidadeEstoque').AsFloat)
       *SQl.FieldByName('Peso').AsFloat);
      Sql.Next;
    end;

    VolEstFim:= TotalVol;
    PesoEstFim:= TotalPeso;

    Movimento(Cont, 3020003, 0, '0', '0', '0', '0',
    CodPro, '0', TotalVol,
     TotalPeso, EndOfTheMonth(Ini));
  end;
end;

procedure TfAnp.TotalGeralSaida(Cont: Integer; CodGrupo: String);
var
  TotalVol, TotalPeso, PesoCons, VolCons: Double;
begin
{  TotalVol:= 0;
  TotalPeso:= 0;
  with Dtm_Anp do
  begin
    Sql.Sql.Clear;
    Sql.Sql.Add('select MCPro.ChaveNF, MCPro.QuantAtendida, P.CodProduto, P.UnidadeEstoque, P.Cubagem, P.Peso '  +
                   'from MCli MC, MCliPro MCPro, Produto P ' +
                   'where MC.DataDocumento between :DataIni and :DataFim '+
                   'and (MC.CodComprovante=:Vendas or MC.CodCOmprovante=:VendaTerc or MC.CodComprovante=:Transf) '+
                   'and MCPro.ChaveNF = MC.ChaveNF and P.CodGrupoSub =:CodGrupo ' +
                   'and MCPro.CodProduto = P.CodProduto');
    Sql.ParamByName('DataIni').AsDate:= Ini;
    Sql.ParamByName('DataFim').AsDate:= Fim;
    SQL.ParamByName('Vendas').AsString:= '001';
    SQL.ParamByName('VendaTerc').AsString:= '035';
    SQL.ParamByName('Transf').AsString:= '042';
//    SQL.ParamByName('SaiIns').AsString:= '100';
    Sql.ParamByName('CodGrupo').AsString:= CodGrupo;

    Sql.Open;
    if Sql.Eof then
    begin
      Sql.Sql.Clear;
      Sql.Sql.Add('select P.CodProduto from Produto P where P.CodGrupoSub =:CodGrupo');
      Sql.ParamByName('CodGrupo').AsString:= CodGrupo;
      Sql.Open;
      CodPro:= Sql.FieldByName('CodProduto').AsString
    end
   else
    begin
      CodPro:= Sql.FieldByName('CodProduto').AsString;
      while not Sql.Eof do
      begin
        TotalVol:= TotalVol+Round((Sql.FieldByName('QuantAtendida').AsFloat/SQl.FieldByName('UnidadeEstoque').AsFloat)
         *SQl.FieldByName('Cubagem').AsFloat*1000);
        TotalPeso:= Round(TotalPeso+(Sql.FieldByName('QuantAtendida').AsFloat/SQl.FieldByName('UnidadeEstoque').AsFloat)
         *SQl.FieldByName('Peso').AsFloat);

        Sql.Next;
      end;
    end;

    ProFim:= CodPro;
    VolFimSai:= TotalVol;
    PesoFimSai:= TotalPeso;}
    TotalVol:= VolFimSai;
    TotalPeso:= PesoFimSai;

    PesoCons:= PesoEstIni + (PesoFimEnt-PesoFimSai)-PesoEstFim;
    VolCons:= VolEstIni + (VolFimEnt-VolFimSai)-VolEstFim;

    if VolCons >= 0 then
    begin
      TotalPeso:= TotalPeso+PesoCons;
      TotalVol:= TotalVol+VolCons;
    end;

    Movimento(Cont, 4012998, 0, '0', '0', '0', '0',
    ProFim, '0', TotalVol,
     TotalPeso, EndOfTheMonth(Ini));
end;

procedure TfAnp.TotalGeralEntrada(Cont: Integer; CodGrupo: String);
var
  TotalVol, TotalPeso, PesoCons, VolCons: Double;
begin
{  TotalVol:= 0;
  TotalPeso:= 0;

  with Dtm_Anp do
  begin
    Sql.Sql.Clear;
    Sql.Sql.Add('select MFPro.Quant, P.CodProduto, P.UnidadeEstoque, P.Cubagem, P.Peso '  +
                   'from MFor MF, MForPro MFPro, Produto P ' +
                   'where MF.DataEntrada between :DataIni and :DataFim '+
                   'and MF.CodComprovante=:Compras '+
                   'and MFPro.ChaveNF = MF.ChaveNF and P.CodGrupoSub =:CodGrupo ' +
                   'and MFPro.CodProduto = P.CodProduto');
    Sql.ParamByName('DataIni').AsDate:= Ini;
    Sql.ParamByName('DataFim').AsDate:= Fim;
    SQL.ParamByName('Compras').AsString:= '010';
    Sql.ParamByName('CodGrupo').AsString:= CodGrupo;

    Sql.Open;
    if Sql.Eof then
    begin
      Sql.Sql.Clear;
      Sql.Sql.Add('select P.CodProduto from Produto P where P.CodGrupoSub =:CodGrupo');
      Sql.ParamByName('CodGrupo').AsString:= CodGrupo;
      Sql.Open;
      CodPro:= Sql.FieldByName('CodProduto').AsString;
    end
   else
    begin
      CodPro:= Sql.FieldByName('CodProduto').AsString;
      while not Sql.Eof do
      begin
        TotalVol:= TotalVol+Round((Sql.FieldByName('Quant').AsFloat/SQl.FieldByName('UnidadeEstoque').AsFloat)
         *SQl.FieldByName('Cubagem').AsFloat*1000);
        TotalPeso:= TotalPeso+Round((Sql.FieldByName('Quant').AsFloat/SQl.FieldByName('UnidadeEstoque').AsFloat)
         *SQl.FieldByName('Peso').AsFloat);

        Sql.Next;
      end;
    end;

    ProFim:= CodPro;
    VolFimEnt:= TotalVol;
    PesoFimEnt:= TotalPeso;}
    TotalVol:= VolFimEnt;
    TotalPeso:= PesoFimEnt;

    PesoCons:= PesoEstIni + (PesoFimEnt-PesoFimSai)-PesoEstFim;
    VolCons:= VolEstIni + (VolFimEnt-VolFimSai)-VolEstFim;

    if VolCons < 0 then
    begin
      TotalPeso:= TotalPeso-PesoCons;
      TotalVol:= TotalVol-VolCons;
    end;

    Movimento(Cont, 4011998, 0, '0', '0', '0', '0',
    ProFim, '0', TotalVol,
     TotalPeso, EndOfTheMonth(Ini));
end;

function TfAnp.IncCont: Integer;
begin
  Result:= ContJ;
  inc(ContJ);
  Gauge1.Progress:= Gauge1.Progress+1;
end;

procedure TfAnp.MovConsumo;
var
  TotalPeso, TotalVol: Double;
begin
   TotalVol:= VolEstIni + (VolFimEnt - VolFimSai) - VolEstFim;
   TotalPeso:= PesoEstIni + (PesoFimEnt - PesoFimSai) - PesoEstFim;
   if TotalVol = 0 then
    exit
  else
   if TotalVol < 0 then
   begin
//     Application.MessageBox('Diferença de estoque negativo!', 'Erro!');
     Movimento(IncCont, 1011999, 0, '0', '0', '0', '0', ProFim, '0', TotalVol*-1, TotalPeso*-1, EndOfTheMonth(Ini));
//     Movimento(IncCont, 1021998, 0, '0', '0', '0', '0', ProFim, '0', TotalVol*-1, TotalPeso*-1, EndOfTheMonth(Ini));
   end
  else
   begin
     Movimento(IncCont, 1022003, 0, '0', '0', '0', '0', ProFim, '0', TotalVol, TotalPeso, EndOfTheMonth(Ini));
     Movimento(IncCont, 1022998, 0, '0', '0', '0', '0', ProFim, '0', TotalVol, TotalPeso, EndOfTheMonth(Ini));
   end;
end;

procedure TfAnp.TotalizadorSaida;
var
  TotalPeso, TotalVol: Double;
begin
   TotalVol:= VolFimSai;
   TotalPeso:= PesoFimSai;
   Movimento(IncCont, 1012998, 0, '0', '0', '0', '0', ProFim, '0', TotalVol, TotalPeso, EndOfTheMonth(Ini));
end;

procedure TfAnp.TotalizadorEntrada;
var
  TotalPeso, TotalVol, PesoCons, VolCons: Double;
begin
    PesoCons:= PesoEstIni + (PesoFimEnt-PesoFimSai)-PesoEstFim;
    VolCons:= VolEstIni + (VolFimEnt-VolFimSai)-VolEstFim;

    TotalVol:= VolFimEnt;
    TotalPeso:= PesoFimEnt;
    if VolCons < 0 then
    begin
      TotalPeso:= TotalPeso-PesoCons;
      TotalVol:= TotalVol-VolCons;
    end;
  Movimento(IncCont, 1011998, 0, '0', '0', '0', '0', ProFim, '0', TotalVol, TotalPeso, EndOfTheMonth(Ini));
end;

procedure TfAnp.Notas;
begin
  with Dtm_Anp do
  begin
    CDS_MovCli.First;
    CDS_MovFor.First;

    ContJ:= 1;
    EstoqueIni(IncCont, '0010026');
    EstoqueFim(IncCont, '0010026');
    CalculaTotais('0010026');
    TotalGeralEntrada(IncCont, '0010026');
    TotalizadorEntrada;
    TotalGeralSaida(IncCont, '0010026');
    TotalizadorSaida;
    MovConsumo;

    EstoqueIni(IncCont, '0010027');
    EstoqueFim(IncCont, '0010027');
    CalculaTotais('0010027');
    TotalGeralEntrada(IncCont, '0010027');
    TotalizadorEntrada;
    TotalGeralSaida(IncCont, '0010027');
    TotalizadorSaida;
    MovConsumo;

    EstoqueIni(IncCont, '0010023');
    EstoqueFim(IncCont, '0010023');
    CalculaTotais('0010023');
    TotalGeralEntrada(IncCont, '0010023');
    TotalizadorEntrada;
    TotalGeralSaida(IncCont, '0010023');
    TotalizadorSaida;
    MovConsumo;

    EstoqueIni(IncCont, '0010015');
    EstoqueFim(IncCont, '0010015');
    CalculaTotais('0010015');
    TotalGeralEntrada(IncCont, '0010015');
    TotalizadorEntrada;
    TotalGeralSaida(IncCont, '0010015');
    TotalizadorSaida;
    MovConsumo;

    EstoqueIni(IncCont, '0010028');
    EstoqueFim(IncCont, '0010028');
    CalculaTotais('0010028');    
    TotalGeralEntrada(IncCont, '0010028');
    TotalizadorEntrada;
    TotalGeralSaida(IncCont, '0010028');
    TotalizadorSaida;
    MovConsumo;

    EstoqueIni(IncCont, '0010024');
    EstoqueFim(IncCont, '0010024');
    CalculaTotais('0010024');
    TotalGeralEntrada(IncCont, '0010024');
    TotalizadorEntrada;
    TotalGeralSaida(IncCont, '0010024');
    TotalizadorSaida;
    MovConsumo;

    EstoqueIni(IncCont, '0010029');
    EstoqueFim(IncCont, '0010029');
    CalculaTotais('0010029');    
    TotalGeralEntrada(IncCont, '0010029');
    TotalizadorEntrada;
    TotalGeralSaida(IncCont, '0010029');
    TotalizadorSaida;
    MovConsumo;

    while (not CDS_MovCli.EoF) or (not CDS_MovFor.Eof) do
    begin
      if CDS_MovCliDataDocumento.AsDateTime = CDS_MovForDataEntrada.AsDateTime then
      begin
         if (not CDS_MovCli.EoF) then
         begin
           MovVenda;
//           CDS_MovCli.Next;
         end;
         if (not CDS_MovFor.EoF) then
         begin
           MovCompra;
//           CDS_MovFor.Next;
         end;
      end
    else
      if (CDS_MovCliDATADocumento.AsDateTime > CDS_MovForDATAEntrada.AsDateTime) and
        (not CDS_MovFor.EoF) then
      begin
         MovCompra;
//         CDS_MovFor.Next;
      end
    else
      if (CDS_MovCliDataDocumento.AsDateTime < CDS_MovForDATAEntrada.AsDateTime) and
      (not CDS_MovCli.EoF) then
      begin
        MovVenda;
//        CDS_MovCli.Next;
      end
    else
      if (not CDS_MovCli.EoF) then
      begin
         MovVenda;
//         CDS_MovCli.Next;
      end
    else
      if (not CDS_MovFor.EoF) then
      begin
         MovCompra;
//         CDS_MovFor.Next;
      end
    end;
  end;
end;


procedure TfAnp.FormCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'ANP.ini') then
  begin
    ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'ANP.Ini');
    Edit1.Text:= ArqIni.ReadString('Values', 'DefaultDir', ExtractFilePath(Application.ExeName) + 'Arquivos');
    fANP.Top:= ArqIni.ReadInteger('Values', 'Form Top', fAnp.Top);
    fANP.Left:= ArqIni.ReadInteger('Values', 'Form Left', fANP.Left);
    ArqIni.Free;
  end
else
  Edit1.Text:= ExtractFilePath(Application.ExeName) + 'Arquivos';
end;

procedure TfAnp.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ArqIni: TIniFile;
begin
  ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ANP.Ini');
  ArqIni.WriteString('Values', 'DefaultDir', Edit1.Text);
  ArqIni.WriteInteger('Values', 'Form Top', fANP.Top);
  ArqIni.WriteInteger('Values', 'Form Left', fANP.Left);
end;

procedure TfAnp.BtnGerarClick(Sender: TObject);
var
  Mes, Ano: Word;
begin
  Screen.Cursor:= crHourGlass;
  try
    Gauge1.Progress:= 0;

    if not DirectoryExists(Edit1.Text) then
    if not CreateDir(Edit1.Text) then
      raise Exception.Create('O diretório para salvar o arquivo não existe e é impossivel cria-lo.');


    Mes:= CBxMes.ItemIndex + 1;
    Ano:= StrToInt(EditAno.Text);
    Ini:= EncodeDate(Ano, Mes, 1);
    Fim:= EndOfAMonth(Ano, Mes);

    AssignFile(vArq, Edit1.Text + '\ANP'+FormatDateTime('MMMYY', Ini)+'.txt');
    ReWrite(vArq); //Cria o arquivo em branco

    Dtm_Anp.Filtra(Ini, Fim);
    RegCont;
    Notas;

    Application.MessageBox('Arquivo gerado com sucesso!', 'Completo', MB_OK);
//    fANP.EditAnoExit(Self);
  finally
    Screen.Cursor:= crDefault;
    Gauge1.Progress:= 0;
    CloseFile(vArq);
  end;
end;

end.
