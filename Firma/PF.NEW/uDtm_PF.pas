unit uDtm_PF;

interface

uses
  SysUtils, Classes,  DB, SqlExpr, FMTBcd, DBClient, Provider, Controls, IniFiles, Forms,
  Data.DBXInterBase, Data.DBXFirebird, Dialogs;

type
  TDtm_PF = class(TDataModule)
  private

  public
  end;



var
  Dtm_PF: TDtm_PF;
  Ini: TDateTime;
  Fim: TDateTime;

implementation

uses DateUtils, Utils, System.Variants;

{$R *.dfm}

{ TDtm_PF }

end.
