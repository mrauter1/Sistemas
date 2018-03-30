unit uSidControle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCadControle, DB;

type
  TRelatorioClass = class of TFormRelBase;

  TSidControle = class(TCadControle)
    procedure DataSourceStateChange(Sender: TObject);
  private
  protected
    procedure DoBeforeDelet(var Cancela: Boolean); override;
    procedure DoBeforeCancel(var Cancela: Boolean); override;
    procedure DoAfterConfirm; override;
    procedure DoAfterCancel; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TSidControle.DataSourceStateChange(Sender: TObject);
begin
  inherited;
  DataSource.AutoEdit:= not IsEmpty;  
end;

procedure TSidControle.DoAfterCancel;
begin
  inherited;
  CadModelo.CarregaVazio;
end;

procedure TSidControle.DoAfterConfirm;
begin
  inherited;
  CadModelo.CarregaVazio;
end;

procedure TSidControle.DoBeforeCancel(var Cancela: Boolean);
begin
  if Not (Cds.State in ([dsInsert, dsEdit])) then
    CadModelo.CarregaVazio;    
  inherited;
end;

procedure TSidControle.DoBeforeDelet(var Cancela: Boolean);
begin
  if CDS.State in [dsEdit, dsInsert] then
    Cds.Cancel;
end;


end.
