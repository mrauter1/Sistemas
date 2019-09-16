unit uDtm_Ano;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr;

type
  TDtm_Anp = class(TDataModule)
    Connnection: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dtm_Anp: TDtm_Anp;

implementation

{$R *.dfm}

procedure TDtm_Anp.DataModuleCreate(Sender: TObject);
begin
  Connnection.Open;
end;

end.
