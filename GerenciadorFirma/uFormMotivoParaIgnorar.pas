unit uFormMotivoParaIgnorar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxDBEdit, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBCtrls;

type
  TFormMotivoIgnorar = class(TForm)
    DsMotivos: TDataSource;
    QryMotivos: TFDQuery;
    BtnOK: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    MemoObs: TMemo;
    QryMotivosCod: TFDAutoIncField;
    BtnCancel: TBitBtn;
    QryMotivosMotivo: TStringField;
    CbxMotivo: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
  private
    { Private declarations }
    OK: Boolean;
  public
    class function SelecionaMotivo(out pCod: Integer; out pObs: String): Boolean;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFormMotivoIgnorar }

procedure TFormMotivoIgnorar.BtnCancelClick(Sender: TObject);
begin
  Ok:= False;
  Close;
end;

procedure TFormMotivoIgnorar.BtnOKClick(Sender: TObject);
begin
  if QryMotivosCod.AsInteger = 0 then
  begin
    ShowMessage('É necessário informar um motivo.');
    cbxMotivo.SetFocus;
    Exit;
  end;

  OK:= True;
  Close;
end;

procedure TFormMotivoIgnorar.FormCreate(Sender: TObject);
begin
  OK:= False;
  QryMotivos.Locate('Cod', 0, []);
end;

class function TFormMotivoIgnorar.SelecionaMotivo(out pCod: Integer;
  out pObs: String): Boolean;
var
  FForm: TFormMotivoIgnorar;
begin
  FForm:= TFormMotivoIgnorar.Create(nil);
  try
    FForm.ShowModal;
    Result:= FForm.OK;
    if Result then
    begin
      pCod:= FForm.QryMotivosCod.AsInteger;
      pObs:= FForm.MemoObs.Lines.Text;
    end
   else
    begin
      pCod:= 0;
      pObs:= '';
    end;
  finally
    FForm.Free;
  end;
end;

end.
