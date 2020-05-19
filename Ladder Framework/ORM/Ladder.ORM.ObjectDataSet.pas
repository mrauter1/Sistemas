unit Ladder.ORM.ObjectDataSet;

interface

uses
  Spring.Data.ObjectDataSet, Ladder.ORM.ModeloBD, System.Classes, System.TypInfo;

type
  TLadderDataSet = class(TObjectDataSet)
  private
    fModeloBD: TModeloBD;
  protected
    procedure InitRttiPropertiesFromItemType(AItemTypeInfo: PTypeInfo); override;
  public
    constructor Create(AOwner: TComponent; pModeloBD: TModeloBD);
  end;


implementation

uses
  Spring.Reflection, System.Rtti, Data.DB;

{ TLadderDataSet }

constructor TLadderDataSet.Create(AOwner: TComponent; pModeloBD: TModeloBD);
begin
  inherited Create(AOwner);
  fModeloBD:= pModeloBD;
end;

procedure TLadderDataSet.InitRttiPropertiesFromItemType(
  AItemTypeInfo: PTypeInfo);
var
  FFieldMapping: TFieldMapping;
begin
  if not Assigned(fModeloBD) then
  begin
    inherited;
    Exit;
  end;

  fProperties.Clear;

  for FFieldMapping in fModeloBD.MappedFieldList do
  begin
    if FFieldMapping.FieldName = '' then
      Continue;

    if Assigned(FFieldMapping.Prop) then
        fProperties.Add(fFieldMapping.Prop);

    Continue;
  end;

end;

end.
