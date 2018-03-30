unit uReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet, uDmEstoqProdutos,
  Data.DB;

type
  TfReport = class(TForm)
    ReportEstoq: TfrxReport;
    frxDBFilaEstoq: TfrxDBDataset;
    DsFilaEstoq: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fReport: TfReport;

implementation

{$R *.dfm}

end.
