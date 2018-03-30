unit uSidListControle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadControle, DB;

type
  TSidListControle = class(TCadControle)
    procedure DataSourceStateChange(Sender: TObject);
  private
  protected
    procedure DoBeforeDelet(var Cancela: Boolean); override;
    procedure DoSetModelo; override;
  public
    { Public declarations }
  end;

var
  SidListControle: TSidListControle;

implementation

{$R *.dfm}

procedure TSidListControle.DataSourceStateChange(Sender: TObject);
begin
  inherited;
  DataSource.AutoEdit:= not IsEmpty;  
end;

procedure TSidListControle.DoBeforeDelet(var Cancela: Boolean);
begin
  if CDS.State in [dsEdit, dsInsert] then
    Cds.Cancel;
end;

procedure TSidListControle.DoSetModelo;
begin
  inherited;
  DataSource.AutoEdit:= not IsEmpty;  
end;

end.
