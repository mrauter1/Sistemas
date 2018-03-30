unit CadView;

interface

uses
  DadosView, StdCtrls, Controls, Classes, DBCtrls, uMVCInterfaces, variants, SysUtils, Dialogs;

type
  TCadView = class(TDadosView, ICadView)
  private
    fOldEditExit: TNotifyEvent;
    fiIndiceEdit: TEdit;
    fCampoIndice: String;
    fIndiceDataLink: TFieldDataLink;
    fDesabilitaEditIndiceEmEdicao: Boolean;
    fAutoAdicionaRegistro: Boolean;
    fConfirmaAdicao: Boolean;
  protected
    function DialogoNovoCad(Chave: Variant): Boolean;
    procedure UpdateiIndiceEdit; virtual;
    procedure DoAfterSetControle; override;
    procedure AdicionaRegistro(Chave: String; ConfirmaDialogo: Boolean = false); virtual;
    procedure CarregaRegistroIndice;
    procedure SetiIndiceEdit(Value: TEdit); virtual;
    procedure iIndiceEditExit(Sender: TObject);
    procedure IndiceDataChange(Sender: TObject); virtual;
    procedure DoIndiceChange(NovoIndice: variant); virtual;
    function ValorIndiceDef(Default: Variant): Variant;
    function GetCadControle: ICadControle;
    property CadControle: ICadControle read GetCadControle;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetCampoIndice(Value: String);
    property CampoIndice: String read fCampoIndice write SetCampoIndice;
  published
    property iIndiceEdit: TEdit read fiIndiceEdit write SetiIndiceEdit;
    property DesabilitaEditIndiceEmEdicao: Boolean read fDesabilitaEditIndiceEmEdicao write fDesabilitaEditIndiceEmEdicao;
    property AutoAdicionaRegistro: Boolean read fAutoAdicionaRegistro write fAutoAdicionaRegistro;
    property ConfirmaAdicao: Boolean read fConfirmaAdicao write fConfirmaAdicao;
  end;

implementation

constructor TCadView.Create(AOwner: TComponent);
begin
  inherited;
  FIndiceDataLink:= TFieldDataLink.Create;
  FIndiceDataLink.OnDataChange:= IndiceDataChange;
  fDesabilitaEditIndiceEmEdicao:= True;
  fAutoAdicionaRegistro:= True;
  fConfirmaAdicao:= True;
end;

procedure TCadView.DoAfterSetControle;
begin
  fIndiceDataLink.DataSource:= CadControle.GetDataSource;
  inherited;
end;

function TCadView.GetCadControle: ICadControle;
begin
  Result:= (Controle as ICadControle);
end;

procedure TCadView.CarregaRegistroIndice;
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

procedure TCadView.iIndiceEditExit(Sender: TObject);
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

procedure TCadView.SetiIndiceEdit(Value: TEdit);
begin
  if fiIndiceEdit = Value then exit;

  fiIndiceEdit:= Value;
  fOldEditExit:= fiIndiceEdit.OnExit;
  fiIndiceEdit.OnExit:= iIndiceEditExit;
end;

procedure TCadView.DoIndiceChange(NovoIndice: variant);
begin
  if iIndiceEdit <> nil then
    iIndiceEdit.Text:= VarToStrDef(NovoIndice, '');
end;

procedure TCadView.IndiceDataChange(Sender: TObject);
var
  ValorIndice: variant;
begin
  if (FIndiceDataLink.Field = nil) then
    ValorIndice:= null
  else ValorIndice:= FIndiceDataLink.Field.AsVariant;

  DoIndiceChange(ValorIndice);
end;

procedure TCadView.UpdateiIndiceEdit;
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

function TCadView.DialogoNovoCad(Chave: Variant): Boolean;
begin
  Result:= (MessageDlg('Deseja adicionar registro?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes);
  if Result then
    CadControle.AdicionarCad(Chave);
end;

procedure TCadView.AdicionaRegistro(Chave: String; ConfirmaDialogo: Boolean = false);
begin
  if ConfirmaDialogo then
    DialogoNovoCad(Chave)
  else CadControle.AdicionarCad(Chave);
end;

function TCadView.ValorIndiceDef(Default: Variant): Variant;
begin
  if Assigned(fIndiceDataLink.Field) then
  begin
    if fIndiceDataLink.Field.IsNull then
      Result:= Default
    else Result:= fIndiceDataLink.Field.AsVariant;
  end else
   Result:= Default;
end;

procedure TCadView.SetCampoIndice(Value: String);
begin
  fCampoIndice:= Value;
  fIndiceDataLink.FieldName:= Value;
end;

end.
