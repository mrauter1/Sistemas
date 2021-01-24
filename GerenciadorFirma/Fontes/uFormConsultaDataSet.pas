unit uFormConsultaDataSet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid;

type
  TFormConsultaDataSet = class(TForm)
    Panel1: TPanel;
    BtnCancelar: TBitBtn;
    btnOK: TBitBtn;
    DataSource: TDataSource;
    cxGridTabela: TcxGrid;
    ViewConsulta: TcxGridDBTableView;
    cxGridTabelaLevel1: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure ViewConsultaCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    RetornoOK: Boolean;
  public
    { Public declarations }
    // Retorna True se um registro válido foi selecionado e ModalResult = mrOK
    class function ConsultaDataSet(ACaption: String;
      ADataSet: TDataSet): Boolean;
  end;

implementation

{$R *.dfm}
{ TFormConsultaDataSet }

procedure TFormConsultaDataSet.BtnCancelarClick(Sender: TObject);
begin
  RetornoOK := False;
  Close;
end;

procedure TFormConsultaDataSet.btnOKClick(Sender: TObject);
begin
  RetornoOK := True;
  Close;
end;

class function TFormConsultaDataSet.ConsultaDataSet(ACaption: String;
  ADataSet: TDataSet): Boolean;
var
  FFrm: TFormConsultaDataSet;
begin
  FFrm := TFormConsultaDataSet.Create(Application);
  try
    FFrm.Caption := ACaption;
    FFrm.DataSource.DataSet := ADataSet;
    FFrm.ViewConsulta.ClearItems;
    FFrm.ViewConsulta.DataController.CreateAllItems();
    FFrm.ShowModal;
    Result := FFrm.RetornoOK;
  finally
    FFrm.Free;
  end;
end;

procedure TFormConsultaDataSet.FormCreate(Sender: TObject);
begin
  RetornoOK := False;
end;

procedure TFormConsultaDataSet.ViewConsultaCellDblClick
  (Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if DataSource.DataSet.RecordCount <> 0 then
  begin
    RetornoOK := True;
    Close;
  end;
end;

end.
