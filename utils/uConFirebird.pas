unit uConFirebird;

interface

uses
  System.SysUtils, System.Classes, uDmConnection, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, uAppConfig, Dialogs;

type
  TConFirebird = class(TDmConnection)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConFirebird: TConFirebird;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TConFirebird.DataModuleCreate(Sender: TObject);
begin
  try
    ModoDesconectado:= True;
    LerConnectionParams(AppConfig.ConFirebird);

    inherited;
  except on E: Exception do
    ShowMessage(E.Message);

  end;

end;

end.
