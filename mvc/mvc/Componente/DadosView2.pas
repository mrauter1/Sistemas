unit DadosView2;

interface

uses
  uViewBase, uMVCInterfaces, Classes, StdCtrls, DBCtrls;

type
  TBeforeMudaEstadoEvent = procedure (Editando: TViewEstado) of object;
  TOnDataChangeEvent = procedure of object;
  TOnAtivaEvent = procedure of object;
  TOnInativaEvent = procedure of object;
  TAlteraRegistroEvent = procedure of object;

  TDadosView = class(TViewBase)
  private
    fBtnAdd: TControl;
    fBtnEdit: TControl;
    fBtnCancel: TControl;
    fBtnPost: TControl;
    fBtnDel: TControl;
    fEstado: TViewEstado;
    FBeforeMudaEstado: TBeforeMudaEstadoEvent;
    fOnDataChange: TOnDataChangeEvent;
    FOnAtiva: TOnAtivaEvent;
    FOnInativa: TOnInativaEvent;
    FOnInsere: TAlteraRegistroEvent;
    FOnEdita: TAlteraRegistroEvent;
    FOnDelete: TAlteraRegistroEvent;
    FConfirmarDelecao: Boolean;
  protected
    procedure DoBeforeMudaEstado(Estado: TViewEstado); virtual;
    procedure DoAtiva; virtual;
    procedure DoInativa; virtual;
    procedure DoInsere; virtual;
    procedure DoEdita; virtual;
    procedure DoDelete; virtual;
    procedure UpdateControles; virtual;
    function ConfirmaDelete: Boolean; virtual;
    function GetDadosControle: TDadosControleBase;
    property DadosControle: TDadosControleBase read GetDadosControle;
  public
    function GetEstado: TViewEstado;
    procedure SetEstado(Value: TViewEstado);
    procedure SetCampoIndice(Value: String);
    procedure DataChange; virtual;

    property Estado: TViewEstado read GetEstado write SetEstado;
  published
    property ConfirmarDelecao: Boolean read fConfirmarDelecao write fConfirmarDelecao;
    property BeforeMudaEstado: TBeforeMudaEstadoEvent read FBeforeMudaEstado write FBeforeMudaEstado;
    property OnDataChange: TOnDataChangeEvent read fOnDataChange write fOnDataChange;
    property OnAtiva: TOnAtivaEvent read FOnAtiva write FOnAtiva;
    property OnInativa: TOnInativaEvent read FOnInativa write FOnInativa;
    property OnInsere: TAlteraRegistroEvent read FOnInsere write FOnInsere;
    property OnEdita: TAlteraRegistroEvent read FOnEdita write FOnEdita;
    property OnDelete: TAlteraRegistroEvent read FOnDelete write FOnDelete;

    property BtnAdd: TControl read fBtnAdd write fBtnAdd;
    property BtnEdit: TControl read fBtnEdit write fBtnEdit;
    property BtnCancel: TControl read fBtnCancel write fBtnCancel;
    property BtnPost: TControl read fBtnPost write fBtnPost;
    property BtnDel: TControl read fBtnDel write fBtnDel;
  end;

implementation

function TDadosView.GetEstado: TViewEstado;
begin
  Result:= fEstado;
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

procedure TDadosView.DoDelete;
begin
  if Assigned(FOnDelete) then
    FOnDelete;
end;
procedure TDadosView.FormCreate(Sender: TObject);
begin
  inherited;
  fConfirmarDelecao:= True;
end;

procedure TDadosView.FormDestroy(Sender: TObject);
begin
  fIndiceDataLink.Free;
  inherited;
end;

procedure TDadosView.FormShow(Sender: TObject);
begin
  inherited;
  Estado:= vAtivo;
  UpdateControles;
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
var
  FEditando: Boolean;
begin
  fEditando:= (fEstado in ([vInserindo, vEditando]));

  BtnAdd.Enabled:= (not fEditando) and (Inserir in DadosControle.GetPermissoes);
  BtnEdit.Enabled:= (not fEditando) and (not DadosControle.IsEmpty) and (Editar in DadosControle.GetPermissoes);
  BtnDel.Enabled:= (not fEditando) and (not DadosControle.IsEmpty) and (Excluir in DadosControle.GetPermissoes);

  BtnCancel.Enabled:= fEditando;
  BtnPost.Enabled:= BtnCancel.Enabled;

  UpdateiIndiceEdit;
end;

procedure TDadosView.BtnAddClick(Sender: TObject);
begin
  DadosControle.BtnAddClick;
end;

procedure TDadosView.BtnCancelClick(Sender: TObject);
begin
  DadosControle.BtnCancelClick;
end;

procedure TDadosView.BtnDelClick(Sender: TObject);
begin
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
  DadosControle.BtnEditClick;
end;

procedure TDadosView.BtnPostClick(Sender: TObject);
begin
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
