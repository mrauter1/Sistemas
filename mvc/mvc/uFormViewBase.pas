unit uFormViewBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uMVCInterfaces, CadView, ViewBase, DadosView;

type

  //Formulário base: implementa os metodos das iterfces IView, IDadosView, ICadView
  TFormViewBase = class(TForm, IView, IDadosView, ICadView)
    View: TCadView;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    procedure MostraMensagem(Mensagem: String);
    procedure SetControle(Value: IControleBase);
    function GetControle: IControleBase;
    property Controle: IControleBase read GetControle write SetControle;
    procedure vFree(var InterfaceRef);

    function GetEstado: TViewEstado;
    procedure SetEstado(Value: TViewEstado);
    property Estado: TViewEstado read GetEstado write SetEstado;
    procedure DataChange;
  end;

var
  FormViewBase: TFormViewBase;

implementation

{$R *.dfm}

procedure TFormViewBase.DataChange;
begin
  View.DataChange;
end;

procedure TFormViewBase.FormShow(Sender: TObject);
begin
  View.UpdateControles;
  View.UpdateEventosControles;
end;

procedure TFormViewBase.SetControle(Value: IControleBase);
begin
  View.Controle:= Value;
end;

function TFormViewBase.GetControle: IControleBase;
begin
  Result:= View.Controle;
end;

function TFormViewBase.GetEstado: TViewEstado;
begin
  Result:= View.Estado;
end;

procedure TFormViewBase.MostraMensagem(Mensagem: String);
begin
  View.MostraMensagem(Mensagem);
end;

procedure TFormViewBase.SetEstado(Value: TViewEstado);
begin
  View.Estado:= Value;
end;

procedure TFormViewBase.vFree(var InterfaceRef);
begin
  Self.Release;
  Pointer(InterfaceRef):= nil;
end;

end.
