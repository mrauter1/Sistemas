unit uDadosViewBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ViewBase, StdCtrls, ExtCtrls, uMVCInterfaces,
  uCadControle, DBCtrls, DB;

type
  TBeforeMudaEstadoEvent = procedure (Editando: TViewEstado) of object;
  TOnDataChangeEvent = procedure of object;
  TOnAtivaEvent = procedure of object;
  TOnInativaEvent = procedure of object;
  TAlteraRegistroEvent = procedure of object;

  TDadosViewBase = class(TViewBase, IDadosView)
    Panel1: TPanel;
    BtnAdd: TButton;
    BtnEdit: TButton;
    BtnCancel: TButton;
    BtnPost: TButton;
    BtnDel: TButton;
    procedure BtnAddClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnPostClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fEstado: TViewEstado;
    fOldEditExit: TNotifyEvent;
    fiIndiceEdit: TEdit;
    fCampoIndice: String;
    fIndiceDataLink: TFieldDataLink;
    FBeforeMudaEstado: TBeforeMudaEstadoEvent;
    fOnDataChange: TOnDataChangeEvent;
    FOnAtiva: TOnAtivaEvent;
    FOnInativa: TOnInativaEvent;
    FOnInsere: TAlteraRegistroEvent;
    FOnEdita: TAlteraRegistroEvent;
    FOnDelete: TAlteraRegistroEvent;
    FConfirmarDelecao: Boolean;
    fDesabilitaEditIndiceEmEdicao: Boolean;
    fAutoAdicionaRegistro: Boolean;
    fConfirmaAdicao: Boolean;
  protected
    procedure AdicionaRegistro(Chave: String; ConfirmaDialogo: Boolean = false); virtual;
    procedure CarregaRegistroIndice;
    procedure SetiIndiceEdit(Value: TEdit); virtual;
    procedure iIndiceEditExit(Sender: TObject);
    function DialogoNovoCad(Chave: Variant): Boolean;
    procedure UpdateiIndiceEdit;
    procedure IndiceDataChange(Sender: TObject); virtual;
    procedure DoIndiceChange(NovoIndice: variant); virtual;
    procedure DoBeforeMudaEstado(Estado: TViewEstado); virtual;
    procedure DoAtiva; virtual;
    procedure DoInativa; virtual;
    procedure DoInsere; virtual;
    procedure DoEdita; virtual;
    procedure DoDelete; virtual;
    procedure UpdateControles; virtual;
    function GetCadControle: ICadControle;
    function ConfirmaDelete: Boolean; virtual;
    property CadControle: ICadControle read GetCadControle;

    function ValorIndiceDef(Default: Variant): Variant;
    procedure DoAfterSetControle; override;
  public
    function GetEstado: TViewEstado;
    procedure SetEstado(Value: TViewEstado);
    procedure SetCampoIndice(Value: String);
    procedure DataChange; virtual;

//    property iIndiceEdit: TEdit read fiIndiceEdit write SetiIndiceEdit;
    property Estado: TViewEstado read GetEstado write SetEstado;
    property CampoIndice: String read fCampoIndice write SetCampoIndice;
  published
    property ConfirmarDelecao: Boolean read fConfirmarDelecao write fConfirmarDelecao;
    property DesabilitaEditIndiceEmEdicao: Boolean read fDesabilitaEditIndiceEmEdicao write fDesabilitaEditIndiceEmEdicao;
    property AutoAdicionaRegistro: Boolean read fAutoAdicionaRegistro write fAutoAdicionaRegistro;
    property ConfirmaAdicao: Boolean read fConfirmaAdicao write fConfirmaAdicao;

    property BeforeMudaEstado: TBeforeMudaEstadoEvent read FBeforeMudaEstado write FBeforeMudaEstado;
    property OnDataChange: TOnDataChangeEvent read fOnDataChange write fOnDataChange;
    property OnAtiva: TOnAtivaEvent read FOnAtiva write FOnAtiva;
    property OnInativa: TOnInativaEvent read FOnInativa write FOnInativa;
    property OnInsere: TAlteraRegistroEvent read FOnInsere write FOnInsere;
    property OnEdita: TAlteraRegistroEvent read FOnEdita write FOnEdita;
    property OnDelete: TAlteraRegistroEvent read FOnDelete write FOnDelete;
  end;

implementation

{$R *.dfm}

procedure TDadosViewBase.DoAfterSetControle;
begin
  fIndiceDataLink.DataSource:= CadControle.GetDataSource;
  inherited;
end;

function TDadosViewBase.GetEstado: TViewEstado;
begin
  Result:= fEstado;
end;

procedure TDadosViewBase.SetEstado(Value: TViewEstado);
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

function TDadosViewBase.DialogoNovoCad(Chave: Variant): Boolean;
begin
  Result:= (MessageDlg('Deseja adicionar registro?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes);
  if Result then
    CadControle.AdicionarCad(Chave);
end;

procedure TDadosViewBase.AdicionaRegistro(Chave: String; ConfirmaDialogo: Boolean = false);
begin
  if ConfirmaDialogo then
    DialogoNovoCad(Chave)
  else CadControle.AdicionarCad(Chave);
end;

function TDadosViewBase.ValorIndiceDef(Default: Variant): Variant;
begin
  if Assigned(fIndiceDataLink.Field) then
  begin
    if fIndiceDataLink.Field.IsNull then
      Result:= Default
    else Result:= fIndiceDataLink.Field.AsVariant;
  end else
   Result:= Default;
end; 

procedure TDadosViewBase.CarregaRegistroIndice;
var
  vChave: variant;
begin
  if iIndiceEdit.Text = VarToStr(ValorIndiceDef('')) then
    Exit;

  try
    vChave:= StrToIntDef(iIndiceEdit.Text, 0);
    if not CadControle.CarregarCad(vChave) then
    begin
      if (vChave <> 0) and (fAutoAdicionaRegistro) then
      begin
        iIndiceEdit.Text:= IntToStr(vChave);
        AdicionaRegistro(vChave, fConfirmaAdicao);
      end;
    end;
  finally
    iIndiceEdit.Text:= VarToStr(ValorIndiceDef(''));
  end;

end;

procedure TDadosViewBase.iIndiceEditExit(Sender: TObject);
begin
  if Estado in ([vInserindo, vEditando]) then
  begin
    if Assigned(fIndiceDataLink.Field) then
      fIndiceDataLink.Field.AsString:= iIndiceEdit.Text;
  end
 else
  begin
     CarregaRegistroIndice;
  end;

  if Assigned(fOldEditExit) then
    fOldEditExit(Sender);
end;

procedure TDadosViewBase.SetiIndiceEdit(Value: TEdit);
begin
  if fiIndiceEdit = Value then exit;

  fiIndiceEdit:= Value;
  fOldEditExit:= fiIndiceEdit.OnExit;
  fiIndiceEdit.OnExit:= iIndiceEditExit;
end;

procedure TDadosViewBase.DataChange;
begin
  if Assigned(FOnDataChange) then
    FOnDataChange;
end;

procedure TDadosViewBase.DoAtiva;
begin
  if Assigned(FOnAtiva) then
    FOnAtiva;
end;

procedure TDadosViewBase.DoInativa;
begin
  if Assigned(FOnInativa) then
    FOnInativa;
end;

procedure TDadosViewBase.DoInsere;
begin
  if Assigned(FOnInsere) then
    FOnInsere;
end;

procedure TDadosViewBase.DoDelete;
begin
  if Assigned(FOnDelete) then
    FOnDelete;
end;

procedure TDadosViewBase.DoIndiceChange(NovoIndice: variant);
begin
  if iIndiceEdit <> nil then
    iIndiceEdit.Text:= VarToStrDef(NovoIndice, '');
end;

procedure TDadosViewBase.IndiceDataChange(Sender: TObject);
var
  ValorIndice: variant;
begin
  if (FIndiceDataLink.Field = nil) then
    ValorIndice:= null
  else ValorIndice:= FIndiceDataLink.Field.AsVariant;

  DoIndiceChange(ValorIndice);
end;

procedure TDadosViewBase.FormCreate(Sender: TObject);
begin
  inherited;

  FIndiceDataLink:= TFieldDataLink.Create;
  FIndiceDataLink.OnDataChange:= IndiceDataChange;
  fConfirmarDelecao:= True;
  fDesabilitaEditIndiceEmEdicao:= True;
  fAutoAdicionaRegistro:= True;
  fConfirmaAdicao:= True;
end;

procedure TDadosViewBase.FormDestroy(Sender: TObject);
begin
  fIndiceDataLink.Free;
  inherited;
end;

procedure TDadosViewBase.FormShow(Sender: TObject);
begin
  inherited;
  Estado:= vAtivo;
  UpdateControles;
end;

procedure TDadosViewBase.DoEdita;
begin
  UpdateControles;
  if Assigned(FOnEdita) then
    FOnEdita;
end;

procedure TDadosViewBase.DoBeforeMudaEstado(Estado: TViewEstado);
begin
  if Assigned(FBeforeMudaEstado) then
    FBeforeMudaEstado(Estado);
end;

procedure TDadosViewBase.UpdateControles;
var
  FEditando: Boolean;
begin
  fEditando:= (fEstado in ([vInserindo, vEditando]));

  BtnAdd.Enabled:= (not fEditando) and (Inserir in CadControle.GetPermissoes);
  BtnEdit.Enabled:= (not fEditando) and (not CadControle.IsEmpty) and (Editar in CadControle.GetPermissoes);
  BtnDel.Enabled:= (not fEditando) and (not CadControle.IsEmpty) and (Excluir in CadControle.GetPermissoes);

  BtnCancel.Enabled:= fEditando;
  BtnPost.Enabled:= BtnCancel.Enabled;

  UpdateiIndiceEdit;
end;

procedure TDadosViewBase.UpdateiIndiceEdit;
begin
  if (iIndiceEdit = nil) or (fIndiceDataLink.Field = nil)  then
    Exit;

  if not CadControle.PodeNavegar then
  begin
    iIndiceEdit.Enabled:= False;
    Exit;
  end;
  
  if fDesabilitaEditIndiceEmEdicao then
  begin
    iIndiceEdit.Enabled:= (not (Estado in ([vInserindo, vEditando])));
//    or (fIndiceDataLink.Field.AsString = '');
  end;

end;

procedure TDadosViewBase.SetCampoIndice(Value: String);
begin
  fCampoIndice:= Value;
  fIndiceDataLink.FieldName:= Value;
end;

function TDadosViewBase.GetCadControle: ICadControle;
begin
  Result:= (Controle as ICadControle);
end;

procedure TDadosViewBase.BtnAddClick(Sender: TObject);
begin
  CadControle.BtnAddClick;
end;

procedure TDadosViewBase.BtnCancelClick(Sender: TObject);
begin
  CadControle.BtnCancelClick;
end;

procedure TDadosViewBase.BtnDelClick(Sender: TObject);
begin
  if ConfirmaDelete then
  begin
    if CadControle.BtnDeletClick then
    begin
      UpdateControles;
      DoDelete;
    end;
  end;
end;

procedure TDadosViewBase.BtnEditClick(Sender: TObject);
begin
  CadControle.BtnEditClick;
end;

procedure TDadosViewBase.BtnPostClick(Sender: TObject);
begin
  CadControle.BtnConfirmClick;
end;

function TDadosViewBase.ConfirmaDelete: Boolean;
begin
  if FConfirmarDelecao then
    Result:= (MessageDlg('Confirma deleção do registro?',
       mtConfirmation, [mbYes, mbNo], 0) = mrYes)
  else Result:= True;
end;


end.
