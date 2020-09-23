unit uFrmPesquisaNeg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uConFirebird, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmPesquisaNeg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    BtnPesquisar: TBitBtn;
    Label2: TLabel;
    EditCodTransp: TEdit;
    EditNomeTransp: TEdit;
    DBGrid1: TDBGrid;
    FDQueryNegociacao: TFDQuery;
    FDQueryNegociacaoCODNEGOCIACAO: TIntegerField;
    FDQueryNegociacaoCODFILIAL: TStringField;
    FDQueryNegociacaoCODTRANSP: TStringField;
    FDQueryNegociacaoSITUACAO: TIntegerField;
    FDQueryNegociacaoVIGENCIA_INI: TDateField;
    FDQueryNegociacaoVIGENCIA_FIM: TDateField;
    FDQueryNegociacaoTIPO_CALCULO: TIntegerField;
    FDQueryNegociacaoEMUSO: TStringField;
    FDQueryNegociacaoEXCLUIDA_SN: TStringField;
    FDQueryNegociacaoCODTRANSPORTE: TStringField;
    FDQueryNegociacaoNOMETRANSPORTE: TStringField;
    DSNegociacao: TDataSource;
    procedure BtnPesquisarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditNomeTranspKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditCodTranspKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    CodNegociacao: Integer;
    { Public declarations }
  end;

var
  FrmPesquisaNeg: TFrmPesquisaNeg;

implementation

{$R *.dfm}

procedure TFrmPesquisaNeg.BtnPesquisarClick(Sender: TObject);
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
  if Trim(EditCodTransp.Text) <> '' then
    AddFiltro('CODTRANSP = '+EditCodTransp.Text);

  if Trim(EditNomeTransp.Text) <> '' then
    AddFiltro('Upper(NOMETRANSPORTE) LIKE ''%'+UpperCase(EditNomeTransp.Text)+'%'' ');

  if FFiltro <> '' then
  begin
    FDQueryNegociacao.Filter:= FFiltro;
    FDQueryNegociacao.Filtered:= True;
  end
 else
  begin
    FDQueryNegociacao.Filtered:= False;
  end;
end;

procedure TFrmPesquisaNeg.DBGrid1DblClick(Sender: TObject);
begin
  CodNegociacao:= FDQueryNegociacaoCODNEGOCIACAO.AsInteger;
  Close;
end;

procedure TFrmPesquisaNeg.EditCodTranspKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EditNomeTransp.Clear;

  if Key = VK_RETURN then
    BtnPesquisar.Click;
end;

procedure TFrmPesquisaNeg.EditNomeTranspKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EditCodTransp.Clear;

  if Key = VK_RETURN then
    BtnPesquisar.Click;

end;

procedure TFrmPesquisaNeg.FormShow(Sender: TObject);
begin
  if not FDQueryNegociacao.Active then
    FDQueryNegociacao.Open;
end;

end.
