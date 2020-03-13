unit uConSqlServer;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.DApt, IniFiles, Forms, uDmConnection, uAppConfig;

type
  TConSqlServer = class(TDmConnection)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

// Field[0] = keyfield; Field[1] = ResulField

var
  ConSqlServer: TConSqlServer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TConSqlServer.DataModuleCreate(Sender: TObject);
begin
  LerConnectionParams(AppConfig.ConSqlServer);

  inherited;

end;

end.
