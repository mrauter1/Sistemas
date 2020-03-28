unit uFormSubGrupoExtras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConSqlServer, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCalendar,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFormSubGrupoExtras = class(TForm)
    cxGridDadosGrupo: TcxGrid;
    cxGridDadosGrupoDBTableView: TcxGridDBTableView;
    cxGridDadosGrupoLevel: TcxGridLevel;
    DsGrupoSubExtras: TDataSource;
    QryGrupoSubExtras: TFDQuery;
    QryGrupoSubExtrasCODGRUPOSUB: TStringField;
    QryGrupoSubExtrasONU: TIntegerField;
    QryGrupoSubExtrasRISCO: TIntegerField;
    QryGrupoSubExtrasFABRICACAO: TDateField;
    QryGrupoSubExtrasMESESVALIDADE: TIntegerField;
    cxGridDadosGrupoDBTableViewCODGRUPOSUB: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewONU: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewRISCO: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewFABRICACAO: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewMESESVALIDADE: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewDATAVALIDADE: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewDESCRICAOETIQUETA: TcxGridDBColumn;
    DBNavigator1: TDBNavigator;
    QryGrupoSubExtrasDescricaoEtiqueta: TStringField;
    QryGrupoSubExtrasDATAVALIDADE: TDateField;
    QryGrupoSubExtrasDiasParaEntrega: TIntegerField;
    cxGridDadosGrupoDBTableViewDiasParaEntrega: TcxGridDBColumn;
    QryGrupoSubExtrasSubclasseRisco: TMemoField;
    QryGrupoSubExtrasDescricaoRisco: TMemoField;
    cxGridDadosGrupoDBTableViewSubclasserisco: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewDescricaoRisco: TcxGridDBColumn;
    procedure QryGrupoSubExtrasMESESVALIDADEChange(Sender: TField);
    procedure FormCreate(Sender: TObject);
    procedure QryGrupoSubExtrasDATAVALIDADEChange(Sender: TField);
    procedure QryGrupoSubExtrasFABRICACAOChange(Sender: TField);
  private
    FEditandoValidade: Boolean;
  public
    { Public declarations }
  end;

{var
  FormSubGrupoExtras: TFormSubGrupoExtras;}

implementation

{$R *.dfm}

procedure TFormSubGrupoExtras.FormCreate(Sender: TObject);
begin
  FEditandoValidade:= False;

  if not QryGrupoSubExtras.Active then
    QryGrupoSubExtras.open;
end;

procedure TFormSubGrupoExtras.QryGrupoSubExtrasDATAVALIDADEChange(
  Sender: TField);
begin
  if FEditandoValidade then
    Exit;

  if QryGrupoSubExtras.State <> dsEdit then
    Exit;

  FEditandoValidade:= True;
  try
    QryGrupoSubExtrasMESESVALIDADE.Clear;
  finally
    FEditandoValidade:= False;
  end;
end;

procedure TFormSubGrupoExtras.QryGrupoSubExtrasFABRICACAOChange(Sender: TField);
begin
  if FEditandoValidade then
    Exit;

  if QryGrupoSubExtras.State <> dsEdit then
    Exit;

  if (not (QryGrupoSubExtrasMESESVALIDADE.IsNull)) and (not (QryGrupoSubExtrasFABRICACAO.IsNull)) then
  begin
    FEditandoValidade:= True;
    try
      QryGrupoSubExtrasDATAVALIDADE.AsDateTime:= IncMonth(QryGrupoSubExtrasFABRICACAO.AsDateTime, QryGrupoSubExtrasMESESVALIDADE.AsInteger)-1;
    finally
      FEditandoValidade:= False;
    end;
  end;

end;

procedure TFormSubGrupoExtras.QryGrupoSubExtrasMESESVALIDADEChange(
  Sender: TField);
begin
  if FEditandoValidade then
    Exit;

  if QryGrupoSubExtras.State <> dsEdit then
    Exit;

  if not (QryGrupoSubExtrasFABRICACAO.IsNull) then
  begin
    FEditandoValidade:= True;
    try
      QryGrupoSubExtrasDATAVALIDADE.AsDateTime:= IncMonth(QryGrupoSubExtrasFABRICACAO.AsDateTime, QryGrupoSubExtrasMESESVALIDADE.AsInteger)-1;
    finally
      FEditandoValidade:= False;
    end;
  end;
end;

end.
