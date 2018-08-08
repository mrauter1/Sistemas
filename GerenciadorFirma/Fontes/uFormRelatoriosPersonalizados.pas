unit uFormRelatoriosPersonalizados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxCustomData, cxStyles, cxTL, cxTLdxBarBuiltInMenu,
  dxSkinsCore, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls,
  cxInplaceContainer, cxTLData, cxDBTL, uConSqlServer, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFormRelatoriosPersonalizados = class(TForm)
    cxDBTreeList1: TcxDBTreeList;
    PanelConsulta: TPanel;
    PanelInfo: TPanel;
    PanelControles: TPanel;
    EdtNome: TDBEdit;
    EdtDescricao: TDBEdit;
    BtnSalvar: TButton;
    BtnDefineCampos: TButton;
    QryConsultas: TFDQuery;
    DsConsultas: TDataSource;
    QryConsultasID: TFDAutoIncField;
    QryConsultasNome: TStringField;
    QryConsultasDescricao: TStringField;
    QryConsultasSql: TMemoField;
    DBMemoSql: TDBMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    class procedure AbreRelatorios;
  end;

var
  FormRelatoriosPersonalizados: TFormRelatoriosPersonalizados;

implementation

{$R *.dfm}

{ TFormRelatoriosPersonalizados }

class procedure TFormRelatoriosPersonalizados.AbreRelatorios;
var
  vFrm: TFormRelatoriosPersonalizados;
begin
  vFrm:= TFormRelatoriosPersonalizados.Create(Application);
  vFrm.Show;
end;

procedure TFormRelatoriosPersonalizados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

end.
