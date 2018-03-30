unit uConexaoBase;

interface

uses
  SysUtils, Classes, DB;

type
  TConexaoBase = class(TDataModule)
  private
    { Private declarations }
  public
    function GetParams(Tabela: TDataSet): TParams; virtual; abstract;
    procedure SetParams(Value: TParams; Tabela: TDataSet); virtual; abstract;
    function GetSql(Tabela: TDataSet): String; virtual; abstract;
    procedure SetSql(SQL: String; Tabela: TDataSet); virtual; abstract;
    function CriaDataSet(Owner: TComponent): TDataSet; virtual; abstract;
  end;

var
  ConexaoBase: TConexaoBase;

implementation

{$R *.dfm}

end.
