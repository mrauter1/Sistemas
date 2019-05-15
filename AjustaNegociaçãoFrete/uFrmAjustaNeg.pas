unit uFrmAjustaNeg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConFirebird, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.UITypes, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxSplitter, Vcl.Menus, uConSqlServer, Vcl.ComCtrls;

type
  TFrmAjusteNeg = class(TForm)
    Panel1: TPanel;
    DBEditCodNeg: TDBEdit;
    Label1: TLabel;
    DBEditCodTransp: TDBEdit;
    Label2: TLabel;
    DBEditNomeTransp: TDBEdit;
    Label3: TLabel;
    BtnPesquisar: TBitBtn;
    FDQueryFaixas: TFDQuery;
    FDQueryCidades: TFDQuery;
    FDQueryNegociacao: TFDQuery;
    FDQueryFaixasCODFAIXA: TIntegerField;
    FDQueryFaixasCODNEGOCIACAO: TIntegerField;
    FDQueryFaixasTITULO: TStringField;
    FDQueryCidadesCODFAIXA: TIntegerField;
    FDQueryCidadesCODESTADO: TStringField;
    FDQueryCidadesNOMECIDADE: TStringField;
    FDQueryNegociacaoCODNEGOCIACAO: TIntegerField;
    FDQueryNegociacaoCODFILIAL: TStringField;
    FDQueryNegociacaoCODTRANSP: TStringField;
    FDQueryNegociacaoSITUACAO: TIntegerField;
    FDQueryNegociacaoVIGENCIA_INI: TDateField;
    FDQueryNegociacaoVIGENCIA_FIM: TDateField;
    FDQueryNegociacaoTIPO_CALCULO: TIntegerField;
    FDQueryNegociacaoEMUSO: TStringField;
    FDQueryNegociacaoEXCLUIDA_SN: TStringField;
    FDQueryNegociacaoNOMETRANSPORTE: TStringField;
    FDQueryNegociacaoCODTRANSPORTE: TStringField;
    DSNegociacao: TDataSource;
    DSFaixas: TDataSource;
    DSCidades: TDataSource;
    FDQueryEstados: TFDQuery;
    FDQueryEstadosCODESTADO: TStringField;
    FDQueryEstadosNOMEESTADO: TStringField;
    FDQueryEstadosCODESTADONFE: TStringField;
    cxSplitter1: TcxSplitter;
    MainMenu1: TMainMenu;
    Extras: TMenuItem;
    CalculadoraDeFretes1: TMenuItem;
    AtualizarDadosFrete1: TMenuItem;
    ConfernciadosFretesDosMovimentos1: TMenuItem;
    N1: TMenuItem;
    PageControl1: TPageControl;
    TabFaixas: TTabSheet;
    GroupBoxFaixas: TGroupBox;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    GroupBoxAdd: TGroupBox;
    MemoCidades: TMemo;
    PanelAddCidades: TPanel;
    Label4: TLabel;
    CbxUF: TComboBox;
    BtnAdicionaCidades: TButton;
    GroupBoxCidades: TGroupBox;
    DBGrid2: TDBGrid;
    Panel5: TPanel;
    BtnRemoveTodas: TButton;
    BtnRemoveCidadeSelecionada: TButton;
    GroupBoxErro: TGroupBox;
    MemoErros: TMemo;
    cxSplitter2: TcxSplitter;
    cxSplitter3: TcxSplitter;
    TabParametros: TTabSheet;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    MemoCidadesParam: TMemo;
    Panel6: TPanel;
    Label5: TLabel;
    CbxUFParam: TComboBox;
    BtnAddCidadeParam: TButton;
    GroupBox2: TGroupBox;
    GridCidadesDoParametro: TDBGrid;
    Panel7: TPanel;
    BtnRemoveTodasParam: TButton;
    BtnRemoveCidadeParam: TButton;
    GroupBox3: TGroupBox;
    MemoCidadesComErroParam: TMemo;
    cxSplitter4: TcxSplitter;
    cxSplitter5: TcxSplitter;
    QryParametros: TFDQuery;
    QueryCidadesParam: TFDQuery;
    QryParametrosCODNEGOCIACAO: TIntegerField;
    QryParametrosCODPARAM: TIntegerField;
    QryParametrosNOME: TStringField;
    GroupBoxParametros: TGroupBox;
    DBGrid3: TDBGrid;
    DSParametros: TDataSource;
    DSCidadesParametros: TDataSource;
    QueryCidadesParamCODNEGOCIACAO: TIntegerField;
    QueryCidadesParamCODPARAM: TIntegerField;
    QueryCidadesParamCODESTADO: TStringField;
    QueryCidadesParamNOMECIDADE: TStringField;
    ConfernciadosFretesdosMovimentos2: TMenuItem;
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FDQueryFaixasAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure BtnRemoveTodasClick(Sender: TObject);
    procedure BtnAdicionaCidadesClick(Sender: TObject);
    procedure BtnRemoveCidadeSelecionadaClick(Sender: TObject);
    procedure CalculadoraDeFretes1Click(Sender: TObject);
    procedure AtualizarDadosFrete1Click(Sender: TObject);
    procedure ConfernciadosFretesDosMovimentos1Click(Sender: TObject);
    procedure QryParametrosAfterScroll(DataSet: TDataSet);
    procedure BtnRemoveCidadeParamClick(Sender: TObject);
    procedure BtnRemoveTodasParamClick(Sender: TObject);
    procedure BtnAddCidadeParamClick(Sender: TObject);
    procedure ConfernciadosFretesdosMovimentos2Click(Sender: TObject);
  private
    procedure CarregaNegociacao(pCodNegociacao: Integer);
    procedure AbreCidades(pCodFaixa: Integer);
    procedure CarregaEstados;
    function VerificaCidadeExiste(pCidade, pUF: String): Boolean;
    procedure AdicionaCidadeNaFaixa(pCodUF, pCidade: String);
    procedure DeletaCidadeSelecionada;
    procedure DeletaCidadePeriodo(pCodNegociacao, pCodFaixa, pCodEstado,
      pNomeCidade: String);
    procedure DeletaCidadeFaixa(pCodNegociacao, pCodFaixa, pCodEstado,
      pNomeCidade: String);
    procedure AbreCidadesParam(pCodNegociacao, pCodParametro: Integer);
    procedure AdicionaCidadeNoParametro(pCodUF, pCidade: String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAjusteNeg: TFrmAjusteNeg;

implementation

uses
  uFrmPesquisaNeg, uFrmCalculadoraDeFretes, Utils, uConsultaPersonalizada;

{$R *.dfm}

procedure TFrmAjusteNeg.CalculadoraDeFretes1Click(Sender: TObject);
begin
  FrmCalculadoraDeFretes.Show;
end;

procedure TFrmAjusteNeg.CarregaEstados;

  procedure InternalCarregaEstados(pCbx: TComboBox);
  begin
    if not FDQueryEstados.Active then
      FDQueryEstados.Open;

    pCbx.Items.Clear;
    FDQueryEstados.First;
    while not FDQueryEstados.Eof do
    begin
      pCbx.Items.Add(FDQueryEstadosCodEstado.AsString);
      FDQueryEstados.Next;
    end;

    pCbx.ItemIndex:= pCbx.Items.IndexOf('RS');
  end;

begin
  InternalCarregaEstados(CbxUF);
  InternalCarregaEstados(CbxUFParam);
end;

procedure TFrmAjusteNeg.AbreCidades(pCodFaixa: Integer);
begin
  FDQueryCidades.Close;
  FDQueryCidades.ParamByName('CODFAIXA').Value:= pCodFaixa;
  FDQueryCidades.Open;
end;

procedure TFrmAjusteNeg.AbreCidadesParam(pCodNegociacao, pCodParametro: Integer);
begin
  QueryCidadesParam.Close;
  QueryCidadesParam.ParamByName('CODNEGOCIACAO').Value:= pCodNegociacao;
  QueryCidadesParam.ParamByName('CODPARAM').Value:= pCodParametro;
  QueryCidadesParam.Open;
end;

procedure TFrmAjusteNeg.CarregaNegociacao(pCodNegociacao: Integer);
begin
  FDQueryNegociacao.Close;
  FDQueryNegociacao.ParamByName('CODNEGOCIACAO').Value:= pCodNegociacao;
  FDQueryNegociacao.Open;

  FDQueryFaixas.Close;
  FDQueryFaixas.ParamByName('CODNEGOCIACAO').Value:= pCodNegociacao;
  FDQueryFaixas.Open;

  AbreCidades(FDQueryFaixasCodFaixa.AsInteger);

  QryParametros.Close;
  QryParametros.ParamByName('CODNEGOCIACAO').Value:= pCodNegociacao;
  QryParametros.Open;

  AbreCidadesParam(QryParametrosCODNEGOCIACAO.AsInteger, QryParametrosCODPARAM.AsInteger);
end;

procedure TFrmAjusteNeg.ConfernciadosFretesDosMovimentos1Click(Sender: TObject);
var
  vForm: TFrmConsultaPersonalizada;
begin
  vForm:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName('ConferenciaFreteMovs');
  vForm.Show;
end;

procedure TFrmAjusteNeg.ConfernciadosFretesdosMovimentos2Click(Sender: TObject);
var
  vForm: TFrmConsultaPersonalizada;
begin
  vForm:= TFrmConsultaPersonalizada.AbreConsultaPersonalizadaByName('FreteConf');
  vForm.Show;
end;

procedure TFrmAjusteNeg.FDQueryFaixasAfterScroll(DataSet: TDataSet);
begin
  AbreCidades(FDQueryFaixasCODFAIXA.AsInteger);
end;

procedure TFrmAjusteNeg.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage:= TabFaixas;

  CarregaEstados;
end;

procedure TFrmAjusteNeg.QryParametrosAfterScroll(DataSet: TDataSet);
begin
  AbreCidadesParam(QryParametrosCODNEGOCIACAO.AsInteger, QryParametrosCODPARAM.AsInteger);
end;

procedure TFrmAjusteNeg.BtnPesquisarClick(Sender: TObject);
var
  FFrm: TFrmPesquisaNeg;
begin
  FFrm:= TFrmPesquisaNeg.Create(Self);
  try
    FFrm.ShowModal;
    CarregaNegociacao(FFrm.CodNegociacao);
  finally
    FFrm.Free;
  end;
end;

procedure TFrmAjusteNeg.DeletaCidadePeriodo(pCodNegociacao, pCodFaixa, pCodEstado, pNomeCidade: String);
begin
  conFirebird.ExecutaComando('DELETE FROM NEG_FAIXA_CIDADES_PERIODO '
        +' WHERE '
        +' CODNEGOCIACAO = '+pCodNegociacao+' AND '
        +' CODFAIXA = '+pCodFaixa+' AND '
        +' CODESTADO = '''+pCodEstado+''' AND '
        +' NOMECIDADE = '''+pNomeCidade+''' ');
end;

procedure TFrmAjusteNeg.DeletaCidadeFaixa(pCodNegociacao, pCodFaixa, pCodEstado, pNomeCidade: String);
begin
  DeletaCidadePeriodo(pCodNegociacao, pCodFaixa, pCodEstado, pNomeCidade);

  conFirebird.ExecutaComando('DELETE FROM NEG_FAIXA_CIDADES '
        +' WHERE '
        +' CODFAIXA = '+pCodFaixa+' AND '
        +' CODESTADO = '''+pCodEstado+''' AND '
        +' NOMECIDADE = '''+pNomeCidade+''' ');
end;

procedure TFrmAjusteNeg.DeletaCidadeSelecionada;
begin
  DeletaCidadePeriodo(FDQueryFaixasCODNEGOCIACAO.AsString, FDQueryFaixasCodFaixa.AsString,
        FDQueryCidadesCODESTADO.AsString, FDQueryCidadesNOMECIDADE.AsString);

  FDQueryCidades.Delete;
end;

procedure TFrmAjusteNeg.BtnRemoveCidadeParamClick(Sender: TObject);
begin
  QueryCidadesParam.Delete;
end;

procedure TFrmAjusteNeg.BtnRemoveCidadeSelecionadaClick(Sender: TObject);
begin
  DeletaCidadeSelecionada;
end;

procedure TFrmAjusteNeg.BtnRemoveTodasClick(Sender: TObject);
begin
  if not FDQueryCidades.Active then
    Exit;

  FDQueryCidades.First;

  if MessageDlg('Você tem certeza que deseja remover todas as cidades desta faixa?',
           TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = ID_YES then
  begin
    while not FDQueryCidades.IsEmpty do
    begin
      DeletaCidadeSelecionada;
    end;
  end;

end;

procedure TFrmAjusteNeg.BtnRemoveTodasParamClick(Sender: TObject);
begin
  if not QueryCidadesParam.Active then
    Exit;

  QueryCidadesParam.First;

  if MessageDlg('Você tem certeza que deseja remover todas as cidades desta faixa?',
           TMsgDlgType.mtConfirmation, [mbYes, mbNo], 0) = ID_YES then
  begin
    while not QueryCidadesParam.IsEmpty do
    begin
      QueryCidadesParam.Delete;
    end;
  end;
end;

procedure TFrmAjusteNeg.BtnAddCidadeParamClick(Sender: TObject);
var
  I: Integer;
  NomeCidadeTratado: String;
begin
  MemoCidadesComErroParam.Clear;

  for I := 0 to MemoCidadesParam.Lines.Count-1 do
  begin
    if Trim(MemoCidadesParam.Lines[I]) = '' then
      Continue;

    NomeCidadeTratado:= UpperCase(Trim(RemoveAcento(MemoCidadesParam.Lines[I])));

    if VerificaCidadeExiste(NomeCidadeTratado, CbxUFParam.Text) then
    begin
      AdicionaCidadeNoParametro(CbxUFParam.Text, NomeCidadeTratado);
    end
   else
    begin
      MemoCidadesComErroParam.Lines.Add(MemoCidadesParam.Lines[I]);
    end;
  end;
end;

function TFrmAjusteNeg.VerificaCidadeExiste(pCidade, pUF: String): Boolean;
begin
  Result:= ConFirebird.RetornaInteiro(
            'SELECT COUNT(*) FROM TABCIDADES WHERE NOMECIDADE = '''+pCidade+''' '
            +' AND CODESTADO = '''+pUF+''' ') > 0;

end;

procedure TFrmAjusteNeg.AdicionaCidadeNaFaixa(pCodUF, pCidade: String);

  function CidadeJaEstaNaFaixa: Boolean;
  const
    cSql = 'SELECT COUNT(*) FROM NEG_FAIXA_CIDADES NFC '
          +'INNER JOIN NEG_FAIXAS NF ON NF.CODFAIXA = NFC.CODFAIXA '
          +'WHERE NF.CODNEGOCIACAO = %d and NF.CODFAIXA = %d AND NFC.NOMECIDADE = ''%s'' and NFC.CODESTADO = ''%s'' ';
  begin
    Result:= ConFirebird.RetornaInteiro(Format(cSql,
          [FDQueryFaixasCodNegociacao.AsInteger, FDQueryFaixasCodFaixa.AsInteger, pCidade, pCodUF])) > 0;
  end;

  function SqlInsertFaixaPeriodo: String;
  begin
    Result:=
      'INSERT INTO'
     +' NEG_FAIXA_CIDADES_PERIODO'
     +'('
     +'  CODNEGOCIACAO,'
     +'  CODFAIXA,'
     +'  CODESTADO,'
     +'  NOMECIDADE,'
     +'  DOMINGO_SN,'
     +'  SEGUNDA_SN,'
     +'  TERCA_SN,'
     +'  QUARTA_SN,'
     +'  QUINTA_SN,'
     +'  SEXTA_SN,'
     +'  SABADO_SN,'
     +'  DIASENTREGA_DOMINGO,'
     +'  DIASENTREGA_SEGUNDA,'
     +'  DIASENTREGA_TERCA,'
     +'  DIASENTREGA_QUARTA,'
     +'  DIASENTREGA_QUINTA,'
     +'  DIASENTREGA_SEXTA,'
     +'  DIASENTREGA_SABADO'
     +')                  '
     +'VALUES (          '
     +FDQueryFaixasCODNEGOCIACAO.AsString+', '
     +FDQueryFaixasCodFaixa.AsString+',  '
     +' '''+ pCodUf+''', '
     +' '''+ pCidade+''', '
     +'  ''N'','
     +'  ''S'','
     +'  ''S'',  '
     +'  ''S'', '
     +'  ''S'', '
     +'  ''S'','
     +'  ''N'','
     +'  2,'
     +'  2,'
     +'  2,'
     +'  2,'
     +'  2,'
     +'  4,'
     +'  3'
     +');'
  end;

  function VerificaEDeletaCidadeEmOutrasFaixas: Boolean;
  var
    FNomeFaixas: String;
    FQryFaixas: TDataSet;
  const
    cSql = 'SELECT NF.CODFAIXA, NF.TITULO FROM NEG_FAIXA_CIDADES NFC '
          +'INNER JOIN NEG_FAIXAS NF ON NF.CODFAIXA = NFC.CODFAIXA '
          +'WHERE NF.CODNEGOCIACAO = %d and NFC.NOMECIDADE = ''%s'' and NFC.CODESTADO = ''%s'' ';
  begin
    Result:= True;

    FNomeFaixas:= '';
    FQryFaixas:= ConFirebird.RetornaDataSet(Format(cSql,
          [FDQueryFaixasCodNegociacao.AsInteger, pCidade, pCodUF]));
    try
      if FQryFaixas.IsEmpty then // Cidade não está em outra faixa desta negociação
        Exit;

      FQryFaixas.First;

      while not FQryFaixas.Eof do
      begin
        if FNomeFaixas <> '' then
          FNomeFaixas:= FNomeFaixas+sLineBreak;

        FNomeFaixas:= FNomeFaixas+FQryFaixas.FieldByName('Titulo').AsString;
        FQryFaixas.Next;
      end;

      if MessageDlg('Cidade '+pCidade+' já está em outra(s) faixa(s): '+sLineBreak+FNomeFaixas
                  +sLineBreak+sLineBreak+'Você deseja remover esta cidade da(s) outra(s) faixa(s) para adicionar nesta?',
                  mtConfirmation, [mbYes, mbNo], 0) = IDYes then
      begin
        FQryFaixas.First;
        while not FQryFaixas.Eof do
        begin
          DeletaCidadeFaixa(FDQueryFaixasCodNegociacao.AsString, FQryFaixas.FieldByName('CodFaixa').AsString, pCodUF, pCidade);
          FQryFaixas.Next;
        end;
      end
     else
      begin
        Result:= False;
      end;
    finally
      FQryFaixas.Free;
    end;
  end;

begin
  if CidadeJaEstaNaFaixa then
    Exit;

  if not VerificaEDeletaCidadeEmOutrasFaixas then // Se retornou falso é porque o usuário não deletou a cidade das outras faixas
  begin
    MemoErros.Lines.Add(pCidade);
    Exit;
  end;

  FDQueryCidades.Insert;
  FDQueryCidadesCODFAIXA.AsInteger:= FDQueryFaixasCodFaixa.AsInteger;
  FDQueryCidadesCODESTADO.AsString:= pCodUF;
  FDQueryCidadesNOMECIDADE.AsString:= pCidade;
  FDQueryCidades.Post;

  ConFirebird.ExecutaComando(SqlInsertFaixaPeriodo);
end;

procedure TFrmAjusteNeg.AdicionaCidadeNoParametro(pCodUF, pCidade: String);

  function CidadeJaEstaNoParametro: Boolean;
  const
    cSql = 'SELECT COUNT(*) FROM NEG_PARAM_CIDADE NPC '
          +'WHERE NPC.CODNEGOCIACAO = %d and NPC.CODPARAM = %d AND NPC.NOMECIDADE = ''%s'' and NPC.CODESTADO = ''%s'' ';
  begin
    Result:= ConFirebird.RetornaInteiro(Format(cSql,
          [QryParametrosCodNegociacao.AsInteger, QryParametrosCodParam.AsInteger, pCidade, pCodUF])) > 0;
  end;

begin
  if CidadeJaEstaNoParametro then
    Exit;

  QueryCidadesParam.Insert;
  QueryCidadesParamCODNEGOCIACAO.AsInteger:= QryParametrosCODNEGOCIACAO.AsInteger;
  QueryCidadesParamCODPARAM.AsInteger:= QryParametrosCODPARAM.AsInteger;
  QueryCidadesParamCODESTADO.AsString:= pCodUF;
  QueryCidadesParamNOMECIDADE.AsString:= pCidade;
  QueryCidadesParam.Post;
end;

procedure TFrmAjusteNeg.AtualizarDadosFrete1Click(Sender: TObject);
begin
  ConSqlServer.ExecutaComando('exec AtzNegociacao');
end;

procedure TFrmAjusteNeg.BtnAdicionaCidadesClick(Sender: TObject);
var
  I: Integer;
  NomeCidadeTratado: String;
begin
  MemoErros.Clear;

  for I := 0 to MemoCidades.Lines.Count-1 do
  begin
    if Trim(MemoCidades.Lines[I]) = '' then
      Continue;

    NomeCidadeTratado:= UpperCase(Trim(RemoveAcento(MemoCidades.Lines[I])));

    if VerificaCidadeExiste(NomeCidadeTratado, CbxUF.Text) then
    begin
      AdicionaCidadeNaFaixa(CbxUF.Text, NomeCidadeTratado);
    end
   else
    begin
      MemoErros.Lines.Add(MemoCidades.Lines[I]);
    end;
  end;
end;

end.
