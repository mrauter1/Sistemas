unit uFrmPesquisaTransp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uConFirebird, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmPesquisaTransp = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    BtnPesquisar: TBitBtn;
    EditNomeTransp: TEdit;
    DBGrid1: TDBGrid;
    FDQueryTransp: TFDQuery;
    DSTransp: TDataSource;
    FDQueryTranspCODTRANSPORTE: TStringField;
    FDQueryTranspNOMETRANSPORTE: TStringField;
    FDQueryTranspCIDADE: TStringField;
    FDQueryTranspESTADO: TStringField;
    FDQueryTranspFONE: TStringField;
    FDQueryTranspNOMETRANSPORTEFANT: TStringField;
    procedure BtnPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditNomeTranspKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    CodTransporte: String;
    { Public declarations }
  end;

var
  FrmPesquisaTransp: TFrmPesquisaTransp;

implementation

{$R *.dfm}

procedure TFrmPesquisaTransp.BtnPesquisarClick(Sender: TObject);
var
  FFiltro: String;

  procedure AddFiltro(pFiltro: String);
  begin
    if FFiltro <> '' then
      FFiltro:= FFiltro+' AND ';

    FFiltro:= FFiltro+pFiltro;
  end;
begin
  FFiltro:= '';

  if Trim(EditNomeTransp.Text) <> '' then
    AddFiltro('Upper(NOMETRANSPORTE) LIKE ''%'+UpperCase(EditNomeTransp.Text)+'%'' ');

  if FFiltro <> '' then
  begin
    FDQueryTransp.Filter:= FFiltro;
    FDQueryTransp.Filtered:= True;
  end
 else
  begin
    FDQueryTransp.Filtered:= False;
  end;
end;

procedure TFrmPesquisaTransp.DBGrid1DblClick(Sender: TObject);
begin
  CodTransporte:= FDQueryTranspCODTRANSPORTE.AsString;
  Close;
end;

procedure TFrmPesquisaTransp.EditNomeTranspKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    BtnPesquisar.Click;

end;

procedure TFrmPesquisaTransp.FormShow(Sender: TObject);
begin
  if not FDQueryTransp.Active then
    FDQueryTransp.Open;
end;

end.
