unit ViewBase2;

interface

uses
  uMVCInterfaces, Dialogs;

type
  TViewBase = class(TComponent, IView)
  private
    fControle: IControleBase;
  protected
    procedure DoAfterSetControle; virtual;
  public
    procedure MostraMensagem(Mensagem: String); virtual;
    procedure SetControle(Value: IControleBase);
    function GetControle: IControleBase;
    property Controle: IControleBase read GetControle write SetControle;

    //O ponteiro para a interface é passado por referencia para ser setado como nil
    procedure vFree(var InterfaceRef);
  end;

implementation

procedure TViewBase.DoAfterSetControle;
begin
  //Implementado por decendentes
end;

procedure TViewBase.MostraMensagem(Mensagem: String);
begin
  ShowMessage(Mensagem);
end;

procedure TViewBase.SetControle(Value: IControleBase);
begin
  fControle:= Value;
  DoAfterSetControle;
end;

function TViewBase.GetControle: IControleBase;
begin
  Result:= fControle;
end;

//O ponteiro para a interface é passado por referencia para ser setado como nil 
procedure TViewBase.vFree(var InterfaceRef);
begin
  Self.Free;
  Pointer(InterfaceRef):= nil;
end;


end.
