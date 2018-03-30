unit uControleBase;

interface

uses
  SysUtils, Classes, uMVCInterfaces, ViewBase, uModeloBase;

//Esta classe � respons�vel pela comunica��o da view com o modelo.
//Qualquer intera��o entre a view e o modelo passa pelo controle que valida a a��o
// e repassa para o modelo se necess�rio.
// O Controle atualiza a view quando houver alguma altera��o no estado do modelo
// que deve aparecer na view.

// A comunica��o view <--> controle se d� atrav�s de Interface, sendo poss�vel
// a comunica��o com qualquer classe que implementa a Interface (Iview).

type
  TSetModeloEvent = procedure of object;

  TControleBase = class(TDataModule, IControleBase)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    fFreeModelView: Boolean;
    fModelo: TModeloBase;
    FOnSetModelo: TSetModeloEvent;
  protected
    fView: IView;
    procedure SetModelo(Value: TModeloBase); virtual;
    procedure SetView(Value: IView); virtual;
    procedure DoSetModelo; virtual;
    procedure FreeView;
  published
    property OnSetModelo: TSetModeloEvent read FOnSetModelo write FOnSetModelo;
    property Modelo: TModeloBase read fModelo write SetModelo;
    property View: IView read fView write SetView;

      //Quando a propriedado FreeModelView for
    //true nunca chamar free explicito na view se ela implementar vFree
    property FreeModelView: Boolean read fFreeModelView write fFreeModelView;
  end;

implementation

{$R *.dfm}

procedure TControleBase.SetModelo(Value: TModeloBase);
begin
  fModelo:= Value;
  DoSetModelo;
end;

procedure TControleBase.SetView(Value: IView);
begin
  fView:= Value;
  if fView <> nil then
    fView.Controle:= Self;
end;

procedure TControleBase.DataModuleCreate(Sender: TObject);
begin
  fFreeModelView:= True;
end;

procedure TControleBase.DataModuleDestroy(Sender: TObject);
begin
  if FreeModelView then
  begin
//    if fModelo.Owner = Self then
//      fModelo.Free;
//    if Assigned(fView) then fView.vFree;
  end;
end;

procedure TControleBase.DoSetModelo;
begin
  if Assigned(FOnSetModelo) then
    FOnSetModelo;
end;

procedure TControleBase.FreeView;
begin
  fView.vFree(fView);
end;

end.
