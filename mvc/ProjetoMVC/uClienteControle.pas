unit uClienteControle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uClienteModelo, uSidControle, DB, uConexaoBase, uMVCInterfaces,
  uInterfacesTesteMVC, uConBase, uCadControle;

type
  TClienteControle = class(TSidControle, IClienteControle)
    procedure DataModuleCreate(Sender: TObject);
  private
  protected
    procedure ConfiguraConsulta(FormConsulta: TfConBase); override;
  public

  end;

implementation

uses
  uClienteView, uDadosControleBase;

{$R *.dfm}

procedure TClienteControle.ConfiguraConsulta(FormConsulta: TfConBase);
begin
  FormConsulta.SetCamposFiltro('COD;NOME');
  FormConsulta.CamposResult:= 'COD';
  FormConsulta.CampoDefault:= 'NOME';
  FormConsulta.Caption:= 'Consulta Cliente';
end;

procedure TClienteControle.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ModeloClass:= TClienteModelo;
  ViewClass:= TClienteView;
end;

end.
