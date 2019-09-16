unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinXmas2008Blue, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Data.FMTBcd,
  Data.SqlExpr, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, uDmSqlUtils, uDmFDConnection,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TForm1 = class(TForm)
    GridTranspDBTableView1: TcxGridDBTableView;
    GridTranspLevel1: TcxGridLevel;
    GridTransp: TcxGrid;
    DsTransp: TDataSource;
    GridTranspDBTableView1CODTRANSPORTE: TcxGridDBColumn;
    GridTranspDBTableView1NOMETRANSPORTE: TcxGridDBColumn;
    GridTranspDBTableView1NUMENTREGAS: TcxGridDBColumn;
    GridTranspDBTableView1VOLUMES: TcxGridDBColumn;
    GridTranspDBTableView1AREATOTAL: TcxGridDBColumn;
    GridTranspDBTableView1PESOTOTAL: TcxGridDBColumn;
    GridTranspLevel2: TcxGridLevel;
    cxViewTranspDetalhe: TcxGridDBTableView;
    DsTranspDetalhe: TDataSource;
    cxViewTranspDetalheORIG: TcxGridDBColumn;
    cxViewTranspDetalheCODPEDIDO: TcxGridDBColumn;
    cxViewTranspDetalheSITUACAO: TcxGridDBColumn;
    cxViewTranspDetalheRAZAOSOCIAL: TcxGridDBColumn;
    cxViewTranspDetalheDATAENTREGA: TcxGridDBColumn;
    cxViewTranspDetalheTRANQUANTIDADE: TcxGridDBColumn;
    cxViewTranspDetalheTRANVOLUME: TcxGridDBColumn;
    cxViewTranspDetalheCODTRANSPORTE: TcxGridDBColumn;
    cxViewTranspDetalheNOMETRANSPORTE: TcxGridDBColumn;
    cxViewTranspDetalheAREA: TcxGridDBColumn;
    cxViewTranspDetalhePESOBRUTO: TcxGridDBColumn;
    QryTransp: TFDQuery;
    QryTranspCODTRANSPORTE: TStringField;
    QryTranspNOMETRANSPORTE: TStringField;
    QryTranspNUMENTREGAS: TIntegerField;
    QryTranspVOLUMES: TLargeintField;
    QryTranspAREATOTAL: TFMTBCDField;
    QryTranspPESOTOTAL: TFMTBCDField;
    QryTranspDetalhe: TFDQuery;
    QryTranspDetalheORIG: TStringField;
    QryTranspDetalheCODPEDIDO: TStringField;
    QryTranspDetalheSITUACAO: TStringField;
    QryTranspDetalheRAZAOSOCIAL: TStringField;
    QryTranspDetalheDATAENTREGA: TDateField;
    QryTranspDetalheTRANQUANTIDADE: TIntegerField;
    QryTranspDetalheTRANVOLUME: TStringField;
    QryTranspDetalheCODTRANSPORTE: TStringField;
    QryTranspDetalheNOMETRANSPORTE: TStringField;
    QryTranspDetalheAREA: TFMTBCDField;
    QryTranspDetalhePESOBRUTO: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  if QryTransp.Active then
    QryTransp.Close;

  if QryTranspDetalhe.Active then
    QryTranspDetalhe.Close;

  QryTransp.Open;
  QryTranspDetalhe.Open;
end;

end.
