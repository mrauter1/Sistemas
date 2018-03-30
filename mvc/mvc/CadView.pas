unit CadView;

interface

uses
  DadosView, StdCtrls, Classes, Controls, DBCtrls, uMVCInterfaces, variants, SysUtils, Dialogs;

type
  TCadView = class(TDadosView, ICadView)
  private
    fOldEditExit: TNotifyEvent;
    fiIndiceEdit: TEdit;
    fBtnConsulta: TControl;
    fCampoIndice: String;
    fIndiceDataLink: TFieldDataLink;
    fDesabilitaEditIndiceEmEdicao: Boolean;
    fAutoAdicionaRegistro: Boolean;
    fConfirmaAdicao: Boolean;
    fCarregaRegistro: Boolean;
    procedure ChecaCampoIndice;
  protected
    function AchaRegistro(Chave: variant): Boolean; virtual;
    function DialogoNovoCad(Chave: Variant): Boolean;
    procedure UpdateiIndiceEdit; virtual;
    procedure DoAfterSetControle; override;
    procedure AdicionaRegistro(Chave: String; ConfirmaDialogo: Boolean = false); virtual;
    procedure SetiIndiceEdit(Value: TEdit); virtual;
    procedure SetBtnConsulta(Value: TControl); virtual;
    procedure iIndiceEditExit(Sender: TObject);
    procedure BtnConsultaClick(Sender: TObject);
    procedure IndiceDataChange(Sender: TObject); virtual;
    procedure DoIndiceChange(NovoIndice: variant); virtual;
    function GetCadControle: ICadControle;
    function podeConsultar: Boolean;
    function ValorIndiceDef(Default: Variant): Variant;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IndiceAsString: string;
    procedure AbreRegistroIndice;
    procedure SetCampoIndice(Value: String);
    procedure UpdateControles; override;
    procedure UpdateEventosControles; override;
    property CadControle: ICadControle read GetCadControle;    
  published
    property BtnConsulta: TControl read FBtnConsulta write SetBtnConsulta;
    property iIndiceEdit: TEdit read fiIndiceEdit write SetiIndiceEdit;
    property CampoIndice: String read fCampoIndice write SetCampoIndice;
    property DesabilitaEditIndiceEmEdicao: Boolean read fDesabilitaEditIndiceEmEdicao write fDesabilitaEditIndiceEmEdicao;
    property AutoAdicionaRegistro: Boolean read fAutoAdicionaRegistro write fAutoAdicionaRegistro;
    property ConfirmaAdicao: Boolean read fConfirmaAdicao write fConfirmaAdicao;

    //Se carrega registro for true carrega tabela utilizando o valor do indice como parametro
    //se for false apenas localiza o registro no clientdataset em memória (Locate).
    property CarregaRegistro: Boolean read fCarregaRegistro write fCarregaRegistro;
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
  fCarregaRegistro:= True;
end;

destructor TCadView.Destroy;
begin
  FIndiceDataLink.Free;
  inherited;
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

function TCadView.AchaRegistro(Chave: variant): Boolean;
begin
  if fCarregaRegistro then
    Result:= CadControle.CarregarCad(Chave)
  else Result:= CadControle.Localiza(CampoIndice, Chave);
end;

procedure TCadView.AbreRegistroIndice;
var
  vChave: variant;
begin
  if iIndiceEdit.Text = IndiceAsString then
    Exit;

  try
    vChave:= StrToIntDef(iIndiceEdit.Text, 0);
    if not AchaRegistro(vChave) then
    begin
      if (vChave <> 0) and (fAutoAdicionaRegistro) then
      begin
        iIndiceEdit.Text:= IntToStr(vChave);
        AdicionaRegistro(vChave, fConfirmaAdicao);
      end;
    end;
  finally
    iIndiceEdit.Text:= IndiceAsString;
  end;

end;

procedure TCadView.ChecaCampoIndice;
begin
  if CampoIndice = '' then
    raise Exception.Create('Não há campo de indice definido! Defina a propriedade CampoIndice em TCadView!');
end;

procedure TCadView.iIndiceEditExit(Sender: TObject);
begin
  try
    ChecaCampoIndice;
    if Estado in ([vInserindo, vEditando]) then
    begin
      if Assigned(fIndiceDataLink.Field) then
        fIndiceDataLink.Field.AsString:= iIndiceEdit.Text;
    end
   else
    begin
       AbreRegistroIndice;
    end;
  finally
    if Assigned(fOldEditExit) then
      fOldEditExit(Sender);
  end;
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

function TCadView.IndiceAsString: string;
begin
  Result:= VarToStr(ValorIndiceDef(''));
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

procedure TCadView.UpdateControles;
begin
  inherited;
  if Assigned(BtnConsulta) then
    BtnConsulta.Enabled:= podeConsultar;
  UpdateiIndiceEdit;
end;

procedure TCadView.UpdateEventosControles;
begin
  inherited;
  ConfiguraBotao(FBtnConsulta, BtnConsultaClick, True);
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

procedure TCadView.BtnConsultaClick(Sender: TObject);
var
  CodConsulta: Variant;
  Temp: String;
begin
  ExecutaEvento(BtnConsulta, Sender);
  CodConsulta:= CadControle.Consulta;
  temp:= VarToStrDef(CodConsulta, '');
  if temp <> '' then
  begin
    if Assigned(iIndiceEdit) then
      fiIndiceEdit.Text:= temp;
    AbreRegistroIndice;
  end;
//  if Assigned(fOldBtnClick) then
//    fOldBtnClick(Sender);
end;

function TCadView.podeConsultar: Boolean;
begin
  Result:= False;
  if not Assigned(CadControle) then Exit;

  if not CadControle.PodeNavegar then Exit;

  Result:= (not (Estado in ([vInserindo, vEditando])))
    and (Consultar in CadControle.GetPermissoes);
end;

procedure TCadView.SetBtnConsulta(Value: TControl);
begin
  FBtnConsulta:= Value;
  ConfiguraBotao(FBtnConsulta, BtnConsultaClick);
  if Assigned(FBtnConsulta) then  
    FBtnConsulta.Enabled:= podeConsultar;
end;

procedure TCadView.SetCampoIndice(Value: String);
begin
  fCampoIndice:= Value;
  fIndiceDataLink.FieldName:= Value;
end;

end.
