unit uFrmCalculadoraDeFretes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, uConSqlServer, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxTextEdit, cxCurrencyEdit, cxSplitter, Vcl.Mask,
  Vcl.Buttons;

type
  TFrmCalculadoraDeFretes = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    EditCidade: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBGridFrete: TDBGrid;
    DBGridParametros: TDBGrid;
    FDQryFrete: TFDQuery;
    BtnCalcular: TButton;
    EditValor: TcxCurrencyEdit;
    EditPeso: TcxCurrencyEdit;
    CbxUF: TComboBox;
    DSFrete: TDataSource;
    FDQryParametros: TFDQuery;
    cxSplitter1: TcxSplitter;
    DsParametros: TDataSource;
    FDQryFreteValorCalculado: TFMTBCDField;
    FDQryFreteCodTransp: TStringField;
    FDQryFreteNomeTransp: TStringField;
    FDQryFreteValor_Parametros: TFMTBCDField;
    FDQryFreteValor_Frete: TBCDField;
    FDQryFreteExcedente_Peso: TFMTBCDField;
    FDQryFreteExcedente_NF: TFMTBCDField;
    FDQryParametrosCODNEGOCIACAO: TIntegerField;
    FDQryParametrosCODPARAM: TIntegerField;
    FDQryParametrosNOME: TStringField;
    FDQryParametrosTIPO: TStringField;
    FDQryParametrosVALOR: TBCDField;
    FDQryParametrosBASE: TStringField;
    FDQryParametrosLINKCLIENTE_SN: TStringField;
    FDQryParametrosARREDONDA_FRACAO: TStringField;
    EditCodTransp: TcxTextEdit;
    FDQryFreteCODNEGOCIACAO: TIntegerField;
    Button1: TButton;
    BtnPesquisar: TBitBtn;
    FDQryParametrosValorCalculado2: TFMTBCDField;
    FDQryParametrosFracao_Peso2: TBCDField;
    FDQryParametrosValor_Minimo2: TBCDField;
    procedure BtnCalcularClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditCodTranspKeyPress(Sender: TObject; var Key: Char);
    procedure EditCodTranspExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FDQryFreteAfterScroll(DataSet: TDataSet);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure CarregaParametros;
    function NomeCidadeFormatado: String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCalculadoraDeFretes: TFrmCalculadoraDeFretes;

implementation

{$R *.dfm}

uses
  uFrmPesquisaTransp, Utils;

function TFrmCalculadoraDeFretes.NomeCidadeFormatado: String;
begin
  Result:= UpperCase(Trim(RemoveAcento(EditCidade.Text)));
end;

procedure TFrmCalculadoraDeFretes.CarregaParametros;
begin
  FDQryParametros.Close;
  FDQryParametros.ParamByName('CodNegociacao').AsString:= FDQryFreteCODNEGOCIACAO.AsString;
  FDQryParametros.ParamByName('UF').AsString:= CbxUF.Text;
  FDQryParametros.ParamByName('CIDADE').AsString:= NomeCidadeFormatado;
  FDQryParametros.ParamByName('Peso').AsFloat:= EditPeso.Value;
  FDQryParametros.ParamByName('Valor').AsFloat:= EditValor.Value;
  FDQryParametros.Open;
end;

procedure TFrmCalculadoraDeFretes.BtnCalcularClick(Sender: TObject);
begin
  FDQryParametros.Close;
  FDQryFrete.Close;
  FDQryFrete.ParamByName('CodTransp').AsString:= EditCodTransp.Text;
  FDQryFrete.ParamByName('UF').AsString:= CbxUF.Text;
  FDQryFrete.ParamByName('CIDADE').AsString:= NomeCidadeFormatado;
  FDQryFrete.ParamByName('Peso').AsFloat:= EditPeso.Value;
  FDQryFrete.ParamByName('Valor').AsFloat:= EditValor.Value;
  FDQryFrete.Open;

  CarregaParametros;
end;

procedure TFrmCalculadoraDeFretes.BtnPesquisarClick(Sender: TObject);
var
  FFrm: TFrmPesquisaTransp;
begin
  FFrm:= TFrmPesquisaTransp.Create(Self);
  try
    FFrm.ShowModal;
    EditCodTransp.Text:= FFrm.CodTransporte;
  finally
    FFrm.Free;
  end;
end;

procedure TFrmCalculadoraDeFretes.Button1Click(Sender: TObject);
begin
  ConSqlServer.ExecutaComando('exec AtzNegociacao');
end;

procedure TFrmCalculadoraDeFretes.EditCodTranspExit(Sender: TObject);
begin
  if Trim(EditCodTransp.Text) = '' then
    Exit;

  while Length(EditCodTransp.Text) < 6 do
    EditCodTransp.Text:= '0'+EditCodTransp.Text;

end;

procedure TFrmCalculadoraDeFretes.EditCodTranspKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#8, '0'..'9']) then
    Key:= #0;
end;

procedure TFrmCalculadoraDeFretes.FDQryFreteAfterScroll(DataSet: TDataSet);
begin
  CarregaParametros;
end;

procedure TFrmCalculadoraDeFretes.FormCreate(Sender: TObject);
begin
  CbxUF.ItemIndex:= CbxUF.Items.IndexOf('RS');
end;

procedure TFrmCalculadoraDeFretes.FormResize(Sender: TObject);
begin
  EditCidade.Width:= BtnCalcular.Left-EditCidade.Left-5;
end;

end.
