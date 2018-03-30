unit uConLocal;

interface

uses
  System.SysUtils, System.Classes, udmSqlUtils, Data.DBXFirebird, Data.DB,
  Data.SqlExpr;

type
  TDmConLocal = class(TDmSqlUtils)
    Embedded: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmConLocal: TDmConLocal;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TDmConLocal.DataModuleCreate(Sender: TObject);
begin
  FSqlConnection:= Embedded;

  inherited;

end;

end.
