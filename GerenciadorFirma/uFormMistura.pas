unit uFormMistura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Data.DB, uDmEstoqProdutos,
  Vcl.ComCtrls, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm3 = class(TForm)
    DataSource1: TDataSource;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    Ajustes: TTabSheet;
    Insumos: TTabSheet;
    Panel1: TPanel;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    CdsConversor: TClientDataSet;
    CdsConversorCODINSUMO: TStringField;
    CdsConversorNOMEINSUMO: TStringField;
    CdsConversorDENSIDADE: TFloatField;
    CdsConversorLITROS: TFloatField;
    CdsConversorKILOSTOTAL: TFloatField;
    CdsConversorKILOSPARCIAL: TFloatField;
    CdsConversorPERCENTVOLUME: TFloatField;
    CdsConversorPERCENTPESO: TFloatField;
    Label3: TLabel;
    Edit3: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

end.
