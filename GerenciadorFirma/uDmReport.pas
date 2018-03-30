unit uDmReport;

interface

uses
  System.SysUtils, System.Classes, uDmEstoqProdutos, frxClass, Data.DB,
  Datasnap.DBClient;

type
  TDmReport = class(TDataModule)
    frxReport1: TfrxReport;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmReport: TDmReport;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
