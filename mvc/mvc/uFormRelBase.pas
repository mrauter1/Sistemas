unit uFormRelBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uMVCInterfaces, ViewBase, DadosView, CadView, ppComm, ppRelatv,
  ppProd, ppClass, ppReport, uConexaoDBX, ppCtrls, ppBands,
  ppPrnabl, ppStrtch, ppSubRpt, ppCache, ppDB, ppDBPipe, StdCtrls, uFormViewBase,
  DB;

type
  TFormRelBase = class(TFormViewBase)
    ppReport: TppReport;
    BtnVisualizar: TButton;
    ppDBPipelinePedidos: TppDBPipeline;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppDetailBand2: TppDetailBand;
    ppSummaryBand1: TppSummaryBand;
    ppLabel1: TppLabel;
    ppLabelData: TppLabel;
    ppLabel2: TppLabel;                      
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppLabel4: TppLabel;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppLine1: TppLine;
    ppDBPipelineItens: TppDBPipeline;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppTitleBand2: TppTitleBand;
    ppDetailBand3: TppDetailBand;
    ppSummaryBand2: TppSummaryBand;
    ppLabel3: TppLabel;
    ppDBText5: TppDBText;
    ppLabel5: TppLabel;
    ppDBText6: TppDBText;
    ppLabel6: TppLabel;
    ppDBText7: TppDBText;
    ppLabel7: TppLabel;
    ppDBText8: TppDBText;
    ppLabel8: TppLabel;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    procedure BtnVisualizarClick(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  FormRelBase: TFormRelBase;

implementation

{$R *.dfm}

uses
  uPedidoControle;

procedure TFormRelBase.BtnVisualizarClick(Sender: TObject);
begin
  ppLabelData.Caption:= DateToStr(Now);
  View.CadControle.Carregar;
  ppReport.Reset;
  ppReport.Print;
end;

end.
