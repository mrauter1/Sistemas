unit uFormCompras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TForm2 = class(TForm)
    cxGridComprasCliente: TcxGrid;
    tvComprasCliente: TcxGridDBTableView;
    cxGridDBTableView6: TcxGridDBTableView;
    cxGridLevel3: TcxGridLevel;
    QryComprasCliente: TFDQuery;
    QryComprasClienteCodCliente: TStringField;
    StringField2: TStringField;
    QryComprasClienteProduto: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    QryComprasClienteCodProduto: TStringField;
    IntegerField1: TIntegerField;
    FMTBCDField1: TFMTBCDField;
    DateField1: TDateField;
    StringField7: TStringField;
    StringField8: TStringField;
    FloatField1: TFloatField;
    IntegerField2: TIntegerField;
    BCDField1: TBCDField;
    DsComprasCliente: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
