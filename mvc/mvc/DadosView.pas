unit DadosView;

interface

uses
  ViewBase, uMVCInterfaces, SysUtils, Controls, Classes, StdCtrls, DBCtrls, Dialogs, uDadosControleBase;

type
  THackControl = class(TControl);

  TBeforeMudaEstadoEvent = procedure (Estado: TViewEstado) of object;
  TOnDataChangeEvent = procedure of object;
  TOnAtivaEvent = procedure of object;
  TOnInativaEvent = procedure of object;
  TAlteraRegistroEvent = procedure of object;
  TVerificaPoderEvent = procedure (var Pode: Boolean) of object;

  TEventContainer = class
    Event: TNotifyEvent;
  end;

  TDadosView = class(TViewBase, IDadosView)
  private
    FBtnList: TList;
    FEventList: TList;
    fBtnAdd: TControl;
    fBtnEdit: TControl;
    fBtnCancel: TControl;
    fBtnConfirm: TControl;
    fBtnDel: TControl;

    fEstado: TViewEstado;
    FBeforeMudaEstado: TBeforeMudaEstadoEvent;
    fOnDataChange: TOnDataChangeEvent;
    FOnAtiva: TOnAtivaEvent;
    FOnInativa: TOnInativaEvent;
    FOnInsere: TAlteraRegistroEvent;
    FOnEdita: TAlteraRegistroEvent;
    FOnDelete: TAlteraRegistroEvent;
    FVerificaPodeInserir, FVerificaPodeEditar, FVerificaPodeDeletar: TVerificaPoderEvent;
    FVerificaPodeConfirmar, FVerificaPodeCancelar: TVerificaPoderEvent;
    FConfirmarDelecao: Boolean;
    FAutoAddEventosControles: Boolean;
    procedure BtnAddClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnConfirmClick(Sender: TObject);
    procedure AddControlEvent(Botao: TControl; Event: TNotifyEvent);
    procedure FreeControlEvent;    
    function TemEvento(Botao: TControl): Boolean;
  protected
    procedure ExecutaEvento(Botao: TControl; Sender: TObject);
    function podeInserir: Boolean;
    function podeEditar: Boolean;
    function podeDeletar: Boolean;
    function PodeConfirmar: Boolean;
    function PodeCancelar: Boolean;

    procedure ConfiguraBotao(Botao: TControl; NewEvent: TNotifyEvent; Refresh: Boolean = false);
    procedure DoBeforeMudaEstado(Estado: TViewEstado); virtual;
    procedure DoAtiva; virtual;
    procedure DoInativa; virtual;
    procedure DoInsere; virtual;
    procedure DoEdita; virtual;
    procedure DoDelete; virtual;
    procedure DoVerificaPodeInserir(var Pode: Boolean);
    procedure DoVerificaPodeEditar(var Pode: Boolean);
    procedure DoVerificaPodeDeletar(var Pode: Boolean);
    procedure DoVerificaPodeConfirmar(var Pode: Boolean);
    procedure DoVerificaPodeCancelar(var Pode: Boolean);

    function ConfirmaDelete: Boolean; virtual;
    function GetDadosControle: IDadosControleBase;
    property DadosControle: IDadosControleBase read GetDadosControle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetButtonAdd(Value: TControl);
    procedure SetButtonEdit(Value: TControl);
    procedure SetButtonCancel(Value: TControl);
    procedure SetButtonConfirm(Value: TControl);
    procedure SetButtonDel(Value: TControl);

    procedure UpdateControles; virtual;

    //Deve ser chamado quando um formulario sobreescever os eventos OnClick
    //dos botões (BtnAdd, BtnEdit, etc...);
    procedure UpdateEventosControles; virtual;
    function GetEstado: TViewEstado;
    procedure SetEstado(Value: TViewEstado);
    procedure DataChange; virtual;

    property Estado: TViewEstado read GetEstado write SetEstado;
  published
    property AutoAddEventosControles: Boolean read FAutoAddEventosControles write FAutoAddEventosControles;
    property ConfirmarDelecao: Boolean read fConfirmarDelecao write fConfirmarDelecao;
    property BeforeMudaEstado: TBeforeMudaEstadoEvent read FBeforeMudaEstado write FBeforeMudaEstado;
    property OnDataChange: TOnDataChangeEvent read fOnDataChange write fOnDataChange;
    property OnAtiva: TOnAtivaEvent read FOnAtiva write FOnAtiva;
    property OnInativa: TOnInativaEvent read FOnInativa write FOnInativa;
    property OnInsere: TAlteraRegistroEvent read FOnInsere write FOnInsere;
    property OnEdita: TAlteraRegistroEvent read FOnEdita write FOnEdita;
    property OnDelete: TAlteraRegistroEvent read FOnDelete write FOnDelete;

    property VerificaPodeInserir: TVerificaPoderEvent read FVerificaPodeInserir write FVerificaPodeInserir;
    property VerificaPodeEditar: TVerificaPoderEvent read FVerificaPodeEditar write FVerificaPodeEditar;
    property VerificaPodeDeletar: TVerificaPoderEvent read FVerificaPodeDeletar write FVerificaPodeDeletar;
    property VerificaPodeConfirmar: TVerificaPoderEvent read FVerificaPodeConfirmar write FVerificaPodeConfirmar;
    property VerificaPodeCancelar: TVerificaPoderEvent read FVerificaPodeCancelar write FVerificaPodeCancelar;

    property BtnAdd: TControl read fBtnAdd write SetButtonAdd;
    property BtnEdit: TControl read fBtnEdit write SetButtonEdit;
    property BtnCancel: TControl read fBtnCancel write SetButtonCancel;
    property BtnConfirm: TControl read fBtnConfirm write SetButtonConfirm;
    property BtnDel: TControl read fBtnDel write SetButtonDel;
  end;

implementation

uses
  MVCUtils;

constructor TDadosView.Create(AOwner: TComponent);
begin
  inherited;
  fConfirmarDelecao:= True;
  fAutoAddEventosControles:= True;
  fEstado:= vAtivo;
  FBtnList:= TList.Create;
  FEventList:= TList.Create;
end;

destructor TDadosView.Destroy;
begin
  FreeControlEvent;
  inherited;
end;

procedure TDadosView.FreeControlEvent;
  procedure ClearEventList;
  var
    F: TEventContainer;
  begin
    while FEventList.Count > 0 do
    begin
      F := FEventList.Last;
      F.Free;
      FEventList.Delete(FEventList.Count-1);
    end;
  end;

begin
  FBtnList.Clear;
  FBtnList.Free;
  ClearEventList;
  FEventList.Free;
end;

procedure TDadosView.AddControlEvent(Botao: TControl; Event: TNotifyEvent);
var
  TE: TEventContainer;
  c: Integer;
begin
  c:= FBtnList.IndexOf(Botao);
  if c < 0 then
  begin
    FBtnList.Add(Botao);

    TE:= TEventContainer.Create;
    TE.Event:= Event;
    FEventList.Add(TE);
  end
 else
  begin
    TEventContainer(FEventList[c]).Event:= Event;
  end;
end;

function TDadosView.GetDadosControle: IDadosControleBase;
begin
  Result:= (Controle as IDadosControleBase);
end;

function TDadosView.GetEstado: TViewEstado;
begin
  Result:= fEstado;
end;

function TDadosView.PodeCancelar: Boolean;
begin
  Result:= False;
  if Assigned(DadosControle) then
  begin
    Result:= fEstado in ([vInserindo, vEditando]);
  end;
  DoVerificaPodeCancelar(Result);
end;

function TDadosView.PodeConfirmar: Boolean;
begin
  Result:= False;
  if Assigned(DadosControle) then
  begin
    Result:= fEstado in ([vInserindo, vEditando]);
  end;
  DoVerificaPodeConfirmar(Result);
end;

function TDadosView.podeDeletar: Boolean;
begin
  Result:= False;
  if Assigned(DadosControle) then
  begin
    Result:= (not (fEstado in ([vInserindo, vEditando]))) and (not DadosControle.IsEmpty) and
      (Excluir in DadosControle.GetPermissoes);
  end;
  DoVerificaPodeDeletar(Result);
end;

function TDadosView.podeEditar: Boolean;
begin
  Result:= False;
  if Assigned(DadosControle) then
  begin
    Result:= (not (fEstado in ([vInserindo, vEditando]))) and
      (not DadosControle.IsEmpty) and (Editar in DadosControle.GetPermissoes);
  end;
  DoVerificaPodeEditar(Result);
end;

function TDadosView.podeInserir: Boolean;
begin
  Result:= False;
  if Assigned(DadosControle) then
  begin
    Result:= (not (fEstado in ([vInserindo, vEditando])))
      and (Inserir in DadosControle.GetPermissoes);
  end;
  DoVerificaPodeInserir(Result);
end;

function TDadosView.TemEvento(Botao: TControl): Boolean;
begin
  Result:= not fBtnList.IndexOf(Botao) < 0;
end;

procedure TDadosView.ExecutaEvento(Botao: TControl; Sender: TObject);

  procedure VerificaLista;
  begin
    if fBtnList.Count <> fEventList.Count then
      raise Exception.Create('Erro interno: função TDadosView.ExecutaEvento. fBtnList e fEventList tem que ter mesmo número de itens!');
  end;

var
  c: Integer;
  e: TEventContainer;
begin
  c:= fBtnList.IndexOf(Botao);
  VerificaLista;
  if c < 0 then exit;
  e:= TEventContainer(fEventList[c]);
  if Assigned(e.Event) then
    e.Event(Sender);
end;

procedure TDadosView.ConfiguraBotao(Botao: TControl; NewEvent: TNotifyEvent; Refresh: Boolean = false);
begin
  if not fAutoAddEventosControles then Exit;

  if Assigned(Botao) then
  begin
    if not compareMethods(THackControl(Botao).OnClick, NewEvent) then
    begin
     if (Refresh) or (not TemEvento(Botao)) then
      AddControlEvent(Botao, THackControl(Botao).OnClick);

      THackControl(Botao).OnClick:= NewEvent;
    end;
  end;
end;

procedure TDadosView.SetButtonAdd(Value: TControl);
begin
  fBtnAdd:= Value;
  ConfiguraBotao(fBtnAdd, BtnAddClick);
  if Assigned(fBtnAdd) then
    fBtnAdd.Enabled:= PodeInserir;
end;

procedure TDadosView.SetButtonCancel(Value: TControl);
begin
  fBtnCancel:= Value;
  ConfiguraBotao(fBtnCancel, BtnCancelClick);
  if Assigned(fBtnCancel) then
    fBtnCancel.Enabled:= PodeConfirmar;
end;

procedure TDadosView.SetButtonConfirm(Value: TControl);
begin
  fBtnConfirm:= Value;
  ConfiguraBotao(fBtnConfirm, BtnConfirmClick);
  if Assigned(fBtnConfirm) then
    fBtnConfirm.Enabled:= PodeConfirmar;
end;

procedure TDadosView.SetButtonDel(Value: TControl);
begin
  fBtnDel:= Value;
  ConfiguraBotao(fBtnDel, BtnDelClick);
  if Assigned(fBtnDel) then
    fBtnDel.Enabled:= PodeDeletar;
end;

procedure TDadosView.SetButtonEdit(Value: TControl);
begin
  fBtnEdit:= Value;
  ConfiguraBotao(fBtnEdit, BtnEditClick);
  if Assigned(fBtnEdit) then
    fBtnEdit.Enabled:= PodeEditar;
end;

procedure TDadosView.SetEstado(Value: TViewEstado);
begin
  fEstado:= Value;
  DoBeforeMudaEstado(fEstado);
  case fEstado of
    vAtivo: DoAtiva;
    vInativo: DoInativa;
    vInserindo: DoInsere;
    vEditando: DoEdita;
  end;
  UpdateControles;
end;

procedure TDadosView.DataChange;
begin
  if Assigned(FOnDataChange) then
    FOnDataChange;
end;

procedure TDadosView.DoAtiva;
begin
  if Assigned(FOnAtiva) then
    FOnAtiva;
end;

procedure TDadosView.DoInativa;
begin
  if Assigned(FOnInativa) then
    FOnInativa;
end;

procedure TDadosView.DoInsere;
begin
  if Assigned(FOnInsere) then
    FOnInsere;
end;

procedure TDadosView.DoVerificaPodeCancelar(var Pode: Boolean);
begin
  if Assigned(FVerificaPodeCancelar) then
    FVerificaPodeCancelar(Pode);
end;

procedure TDadosView.DoVerificaPodeConfirmar(var Pode: Boolean);
begin
  if Assigned(FVerificaPodeConfirmar) then
    FVerificaPodeConfirmar(Pode);
end;

procedure TDadosView.DoVerificaPodeDeletar(var Pode: Boolean);
begin
  if Assigned(FVerificaPodeDeletar) then
    FVerificaPodeDeletar(Pode);
end;

procedure TDadosView.DoVerificaPodeEditar(var Pode: Boolean);
begin
  if Assigned(FVerificaPodeEditar) then
    FVerificaPodeEditar(Pode);
end;

procedure TDadosView.DoVerificaPodeInserir(var Pode: Boolean);
begin
  if Assigned(FVerificaPodeInserir) then
    FVerificaPodeInserir(Pode);
end;

procedure TDadosView.DoDelete;
begin
  if Assigned(FOnDelete) then
    FOnDelete;
end;

procedure TDadosView.DoEdita;
begin
  UpdateControles;
  if Assigned(FOnEdita) then
    FOnEdita;
end;

procedure TDadosView.DoBeforeMudaEstado(Estado: TViewEstado);
begin
  if Assigned(FBeforeMudaEstado) then
    FBeforeMudaEstado(Estado);
end;

procedure TDadosView.UpdateControles;
begin
  if Assigned(BtnAdd) then
    BtnAdd.Enabled:= PodeInserir;//(not fEditando) and (Inserir in DadosControle.GetPermissoes);

  if Assigned(BtnEdit) then
    BtnEdit.Enabled:= PodeEditar;//(not fEditando) and (not DadosControle.IsEmpty) and (Editar in DadosControle.GetPermissoes);

  if Assigned(BtnDel) then
    BtnDel.Enabled:= PodeDeletar;//(not fEditando) and (not DadosControle.IsEmpty) and (Excluir in DadosControle.GetPermissoes);

  if Assigned(BtnCancel) then
    BtnCancel.Enabled:= PodeCancelar;//fEditando;

  if Assigned(BtnConfirm) then
    BtnConfirm.Enabled:= PodeConfirmar;// BtnCancel.Enabled;
end;

//Este metodo server para os botoes poderem chamar seus eventos onclick definidos por um form herdado em design time
//quando já estiverem ligados ao componente TView em um form pai (herança).
//nestes casos ConfiguraBotão é chamado antes do onclick que foi definido em designtime no form filho
// ser reconhecido pelo objeto..
procedure TDadosView.UpdateEventosControles;
begin
  ConfiguraBotao(BtnAdd, BtnAddClick, True);
  ConfiguraBotao(BtnEdit, BtnEditClick, True);
  ConfiguraBotao(BtnCancel, BtnCancelClick, True);
  ConfiguraBotao(BtnConfirm, BtnConfirmClick, True);
  ConfiguraBotao(BtnDel, BtnDelClick, True);
end;

procedure TDadosView.BtnAddClick(Sender: TObject);
begin
  ExecutaEvento(BtnAdd, Sender);
  DadosControle.BtnAddClick;
end;

procedure TDadosView.BtnCancelClick(Sender: TObject);
begin
  ExecutaEvento(BtnCancel, Sender);
  DadosControle.BtnCancelClick;
end;

procedure TDadosView.BtnDelClick(Sender: TObject);
begin
  ExecutaEvento(BtnDel, Sender);
  if ConfirmaDelete then
  begin
    if DadosControle.BtnDeletClick then
    begin
      UpdateControles;
      DoDelete;
    end;
  end;
end;

procedure TDadosView.BtnEditClick(Sender: TObject);
begin
  ExecutaEvento(BtnEdit, Sender);
  DadosControle.BtnEditClick;
end;

procedure TDadosView.BtnConfirmClick(Sender: TObject);
begin
  ExecutaEvento(BtnConfirm, Sender);  
  DadosControle.BtnConfirmClick;
end;

function TDadosView.ConfirmaDelete: Boolean;
begin
  if FConfirmarDelecao then
    Result:= (MessageDlg('Confirma deleção do registro?',
       mtConfirmation, [mbYes, mbNo], 0) = mrYes)
  else Result:= True;
end;

end.
