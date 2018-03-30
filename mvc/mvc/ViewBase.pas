unit ViewBase;

interface

uses
  uMVCInterfaces, Dialogs, Classes, FOrms, SysUtils;

type
  TSetControleEvent = procedure of object;

  TViewBase = class(TComponent, IView)
  private
    fControle: IControleBase;
    fOnSetControle: TSetControleEvent;
  protected
    procedure DoAfterSetControle; virtual;
  public
    procedure MostraMensagem(Mensagem: String); virtual;
    procedure SetControle(Value: IControleBase);
    function GetControle: IControleBase;
    property Controle: IControleBase read GetControle write SetControle;

    //O ponteiro para a interface é passado por referencia para ser setado como nil
    procedure vFree(var InterfaceRef);
    function ShowModal: Integer;
  published
    property OnSetControle: TSetControleEvent read fOnSetControle write fOnSetControle;
  end;

implementation

procedure TViewBase.DoAfterSetControle;
begin
  if Assigned(fOnSetControle) then
    FOnSetControle;
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

function TViewBase.ShowModal: Integer;
begin
  if Owner is TForm then
    Result:= (Owner as TForm).ShowModal
  else
    raise Exception.Create('Objeto precisa estar em um form para chamar ShowModal!');
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
