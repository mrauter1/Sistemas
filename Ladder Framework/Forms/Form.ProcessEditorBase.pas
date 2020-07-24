unit Form.ProcessEditorBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ComCtrls, uConClasses, Ladder.Activity.Classes, Vcl.CheckLst, Ladder.Parser,
  System.Generics.Collections, Ladder.Activity.Manager;

type
  TParamPageControl = class(TPageControl)
  public
    Edit: TEdit;
    Control: TComponent;
  end;

  TFormProcessEditorBase = class(TForm)
  public
  private
    function GetControlHeight(pTipo: TTipoParametro): Integer;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    function CriaLabel(pParent: TWinControl; Position: TPoint; pParametro: TParametroCon): TLabel;
    function CriaPageControl(pBox: TWinControl; Position: TPoint; pParametro: TParametroCon): TParamPageControl;
    function CreateTabSheet(pPageControl: TPageControl; pCaption, pName: String): TTabSheet;

    function CriaDateTimePicker(pBox: TWinControl; pParametro: TParametroCon; pValorParam: Variant): TDateTimePicker;
    function CriaEdit(pBox: TWinControl; pParametro: TParametroCon; pExpression: String): TEdit;
    function CriaParComboBox(pBox: TWinControl; pParametro: TParametroCon; pValorParam: Variant): TComboBox;
    function CriaParMaskEdit(pBox: TWinControl; pParametro: TParametroCon; pValorParam: Variant): TMaskEdit;
    function CriaParChecklistBox(pBox: TWinControl; pParametro: TParametroCon; pValorParam: Variant): TCheckListBox;

    // Return a valid Expression matching the visual component value
    function ControlToExpression(pComponent: TComponent; pParametroCon: TParametroCon): String; virtual;

    // Return a valid Expression matching pValue value
    function ParamValueToExpression(pValue: Variant): String; virtual;

    // For each TParameterCon create a PageControl with an TEDit for Expression and a component matching the field type (eg.: TDateTimePicker for ptDate)
    // For each TParameterCon there must be a AProcess.Input of the same name
    // The values shown on the visual components are computed from the AProcess.Input.Expression.
    procedure CreateScreenParameters(AScreenParameters: TObjectList<TParametroCon>; AParameterContainer: IActivityElementContainer; pBox: TWinControl); virtual;

    // Map the values of the visual components to AProcess.Inputs.Expression values
    procedure ScreenParamToProcess(pScreenParameters: TObjectList<TParametroCon>; AParameterContainer: IActivityElementContainer; pBox: TWinControl); virtual;

    // For each TParameterCon in AScreenParameters an Input will be added to AProcess.Input if it does not exist already
    procedure RefreshProcessInputs(AScreenParameters: TObjectList<TParametroCon>; AParameterContainer: IActivityElementContainer); virtual;

    class function ActivityManager: TActivityManager; virtual;
  end;

implementation

uses
  uConsultaPersonalizada, Ladder.Utils, Utils, SynCommons, Ladder.ServiceLocator;

{$R *.dfm}

function TFormProcessEditorBase.GetControlHeight(pTipo: TTipoParametro): Integer;
begin
  case pTipo of
    ptCheckListBox: Result:= 110
    else Result:= 20;
  end;
end;

function TFormProcessEditorBase.CriaLabel(pParent: TWinControl; Position: TPoint; pParametro: TParametroCon): TLabel;
begin
  Result:= TLabel.Create(pParent);
  with Result do
  begin
    Visible   := true;
    Left      := Position.X;
    Top       := Position.Y;
    Height    := 20;
    AutoSize  := True;
    WordWrap  := True;
    Width     := 70;
    Alignment := taRightJustify;
    Caption   := pParametro.Nome + sLineBreak + '('+pParametro.Descricao+')';
    Name      := 'L'+pParametro.Nome;
    Font.Color:=ClBlue;
    Parent    := pParent;
  end;
end;

function TFormProcessEditorBase.CriaParChecklistBox(pBox: TWinControl; pParametro: TParametroCon; pValorParam: Variant): TCheckListBox;
var
 FScrollBox: TScrollBox;
begin
  FScrollBox:= TScrollBox.Create(pBox);
  with FScrollBox do
  begin
    Visible   := true;
    Align     := alClient;
    Name      := 'S'+pParametro.Nome;
    BevelEdges:= [];
    BevelKind:= TBevelKind.bkNone;
    BevelOuter:= bvNone;
    BorderStyle:= bsNone;
    BorderWidth:= 0;
    Parent    := pBox;
  end;
  Result:= TCheckListBox.Create(FScrollBox);
  with Result do
  begin
    Visible   := true;
    Top       := 0;
    Left      := 0;
    Name      := 'V'+pParametro.Nome;
    if pParametro.Tamanho > 0 then
      Width:= pParametro.Tamanho
    else
      Width:= pBox.ClientWidth;

    Height    := 180;
    Parent    := FScrollBox;
    PopulaCheckListBoxQry(Result, pParametro.Sql, pValorParam);
  end;
end;

function TFormProcessEditorBase.CriaEdit(pBox: TWinControl; pParametro: TParametroCon; pExpression: String): TEdit;
begin
  Result:= TEdit.Create(pBox);
  with Result do
  begin
    Visible   := true;
    Align     := alClient;
    Name      := 'E'+pParametro.Nome;
    Text      := pExpression;
    Parent    := pBox;
  end;
end;

function TFormProcessEditorBase.CreateTabSheet(pPageControl: TPageControl; pCaption: String; pName: String): TTabSheet;
begin
  Result:= TTabSheet.Create(pPageControl);
  Result.Caption:= pCaption;
  Result.Name:= pName;
  Result.Parent:= pPageControl;
  Result.PageControl:= pPageControl;
end;

function TFormProcessEditorBase.CriaPageControl(pBox: TWinControl; Position: TPoint; pParametro: TParametroCon): TParamPageControl;
begin
  Result:= TParamPageControl.Create(pBox);
  with Result do
  begin
    Visible   := true;
    Top       := Position.Y;
    Left      := Position.X;
    Width     := pBox.ClientWidth-Left-10;
    Anchors   := [aktop, akLeft, akRight];
    Name      := 'PG'+pParametro.Nome;
    Height    := GetControlHeight(pParametro.Tipo)+22;
    Parent    := pBox;
    CreateTabSheet(Result, 'Expressão', 'TE'+pParametro.Nome);
    CreateTabSheet(Result, 'Valor', 'TV'+pParametro.Nome);
    TabIndex  := 1;
    TabHeight:= 14;
    Font.Size:= 7;
  end;
end;

function TFormProcessEditorBase.CriaParComboBox(pBox: TWinControl; pParametro: TParametroCon; pValorParam: Variant): TComboBox;
begin
  Result:= TComboBox.Create(pBox);
  with Result do
  begin
    Visible   := true;
    Top:= 0;
    Left:= 0;
    if pParametro.Tamanho > 0 then
      Width:= pParametro.Tamanho
    else
      Width:= pBox.ClientWidth;

//      Align     := alClient;
    Style     := csOwnerDrawFixed;
    Name      := 'V'+pParametro.Nome;
    Parent    := pBox;
    PopulaComboBoxQry(Result, pParametro.Sql, pValorParam);
  end;
end;

function TFormProcessEditorBase.CriaParMaskEdit(pBox: TWinControl; pParametro: TParametroCon; pValorParam: Variant): TMaskEdit;
begin
  Result:= TMaskEdit.Create(pBox);
  with Result do
  begin
    Visible   := true;
    Top:= 0;
    Left:= 0;

    if pParametro.Tamanho > 0 then
      Width:= pParametro.Tamanho
    else
      Width:= pBox.ClientWidth;

//      Align     := alClient;
    Name      := 'V'+pParametro.Nome;
    Text      := LadderVarToStr(pValorParam, '');
    Parent    := pBox;
  end;
end;

function TFormProcessEditorBase.CriaDateTimePicker(pBox: TWinControl; pParametro: TParametroCon; pValorParam: Variant): TDateTimePicker;
begin
  Result:= TDateTimePicker.Create(pBox);
  with Result do
  begin
    Visible   := true;
    Top:= 0;
    Left:= 0;
    if pParametro.Tamanho > 0 then
      Width:= pParametro.Tamanho;

//      Align     := alClient;
    Name      := 'V'+pParametro.Nome;
    if LadderVarIsDateTime(pValorParam) then
      Date:= LadderVarToDateTime(pValorParam);

    Parent    := pBox;
  end;
end;

// Names that have a dot are considered to be multilevel.: eg.: "ParamMaster.ParamChild" ParamChild will be created as a child of ParamMaster
procedure TFormProcessEditorBase.RefreshProcessInputs(AScreenParameters: TObjectList<TParametroCon>; AParameterContainer: IActivityElementContainer);
var
  fParametro: TParametroCon;

  function ParameterConToExpression(AParam: TParametroCon): String;
  begin
    Result:= '';
    if AParam.ValorPadrao = '' then
      Exit;

    Result:= AParam.ValorPadrao;
  end;

  procedure CreateParam(AParametro: TParametroCon);
  var
    FCreatedParam: TParameter;
  begin
    FCreatedParam:= TParameter.Create(AParametro.Nome, tbAny, ParameterConToExpression(AParametro));

    if (AParameterContainer is TProcessoBase) then
      (AParameterContainer as TProcessoBase).Inputs.Add(FCreatedParam)
    else
      (AParameterContainer as TParameter).Parameters.Add(FCreatedParam);
  end;

begin
  for fParametro in AScreenParameters do
    if AParameterContainer.FindElement(fParametro.Nome) = nil then
      CreateParam(fParametro);

end;

procedure TFormProcessEditorBase.ScreenParamToProcess(pScreenParameters: TObjectList<TParametroCon>; AParameterContainer: IActivityElementContainer; pBox: TWinControl);
var
  FElement: IActivityElement;
  fPageControl: TParamPageControl;
  fParametro: TParametroCon;
  fParam: TParameter;
  FComponent: TComponent;
begin
  for fParametro in pScreenParameters do
  begin
    FElement:= AParameterContainer.FindElement(FParametro.Nome);
    if not (FElement is TParameter) then
      Continue;

    fParam:= (FElement as TParameter);

    FComponent:= pBox.FindComponent('PG'+FParametro.Nome);
    if not (FComponent is TParamPageControl) then
      Continue;

    fPageControl:= FComponent as TParamPageControl;
    if fPageControl.ActivePageIndex = 1 then
      fParam.Expression:= ControlToExpression(fPageControl.Control, fParametro)
    else
      fParam.Expression:= fPageControl.Edit.Text;

   end;
end;

constructor TFormProcessEditorBase.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TFormProcessEditorBase.CreateScreenParameters(AScreenParameters: TObjectList<TParametroCon>; AParameterContainer: IActivityElementContainer; pBox: TWinControl);
var
  FTop: Integer;
  FPageControl: TParamPageControl;
var
  fParametro: TParametroCon;
  fParam: TParameter;
  FValorParam: Variant;
  FIsExpression: Boolean;

const
  cMaxHeight = 350;

  function ValorPadraoParametro(pParam: TParametroCon): Variant;
  begin
    Result:= null;
    if pParam.ValorPadrao = '' then
      Exit;

    case fParametro.Tipo of
      ptComboBox: Result:= pParam.ValorPadrao;
      ptTexto: Result:= pParam.ValorPadrao;
      TTipoParametro.ptDateTime: Result:= LadderVarToDateTime(pParam.ValorPadrao);
      ptCheckListBox: Result:= StrToLadderArray(pParam.ValorPadrao, ',');
    end;
  end;

  function FindParam(ParamName: String): TParameter;
  var
    Element: IActivityElement;
  begin
    Element:= AParameterContainer.FindElement(ParamName);
    if Element is TParameter then
      Result:= (Element as TParameter)
    else
      Result:= nil;
  end;

begin
  FTop:= 0;
  for fParametro in AScreenParameters do
  begin
    FIsExpression:= False;

    fParam:= FindParam(FParametro.Nome);
    if not Assigned(fParam) then
      Continue;
//      raise Exception.Create(Format('Input %s da consulta personalizada %s não encontrado.', [fParametro.Name, FConsulta.Name]);

    if fParam.Expression = '' then
      fValorParam:= null
    else
      FIsExpression:= not TActivityParser.TryParseExpression(fParam.Expression, FValorParam, nil); // If Expression can't be parsed to a literal value it is a complex expression

    CriaLabel(pBox, Point(4, FTop+4), fParametro);

    FPageControl:= CriaPageControl(pBox, Point(80, FTop), fParametro);
    FPageControl.Edit:= CriaEdit(FPageControl.Pages[0], fParametro, fParam.Expression);

    case fParametro.Tipo of
      ptComboBox: FPageControl.Control:= CriaParCombobox(FPageControl.Pages[1], fParametro, fValorParam);
      ptTexto: FPageControl.Control:= CriaParMaskEdit(FPageControl.Pages[1], fParametro, fValorParam);
      TTipoParametro.ptDateTime: FPageControl.Control:= CriaDateTimePicker(FPageControl.Pages[1], fParametro, fValorParam);
      ptCheckListBox: FPageControl.Control:= CriaParCheckListBox(FPageControl.Pages[1], fParametro, fValorParam);
    end;

    if fIsExpression then
      FPageControl.ActivePageIndex := 0
    else
      FPageControl.ActivePageIndex := 1;

    FTop:= FPageControl.Top+FPageControl.Height+3;
  end;

  if FTop >= cMaxHeight then
    Self.Height:= Self.Height + cMaxHeight - pBox.Height
  else
    Self.Height:= Self.Height + FTop - pBox.Height;
end;

class function TFormProcessEditorBase.ActivityManager: TActivityManager;
begin
  Result:= TFrwServiceLocator.Context.ActivityManager;
end;

function TFormProcessEditorBase.ControlToExpression(pComponent: TComponent; pParametroCon: TParametroCon): String;
begin
  Result:= '';

  if (pComponent is TComboBox) then
    Result:= '"'+VarToStr(TValorChave.ObterValor(TComboBox(pComponent)))+'"'
  else if (pComponent is TCheckListBox) then
    Result:= '['+TValorChave.ObterValoresSelecionados(TCheckListBox(pComponent), ',', True)+']'
  else if (pComponent is TMaskEdit) then
    Result:= '"'+TMaskEdit(pComponent).EditText+'"'
  else if (pComponent is TDateTimePicker) then
    Result:= LadderDateToStr(TDateTimePicker(pComponent).DateTime, True);

end;

function TFormProcessEditorBase.ParamValueToExpression(pValue: Variant): String;
var
  I: Integer;
begin
  Result:='';
  if VarIsNull(pValue) then
    Exit;

  if VarIsLadderArray(pValue) then
  begin
    Result:= '[';
    for I := 0 to TDocVariantData(pValue).Count-1 do
    begin
      if I = 0 then
        Result:= Result+Format('"%s"', [TDocVariantData(pValue).Values[I]])
      else
        Result:= Result+Format(',"%s"', [TDocVariantData(pValue).Values[I]]);
    end;
    Result:= Result+']';
    Exit;
  end;

  Result:= LadderVarToStr(pValue);
{  if LadderVarIsDateTime(pValue) then
    Result:= LadderDateToStr(pValue, True)
  else
    Result:= QuotedStr(VarToStrDef(pValue, ''));    }
end;

end.
