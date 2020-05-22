unit Ladder.ORM.DaoUtils;

interface

uses
  AdoDB, System.Contnrs, generics.collections, System.Classes, Data.DB, uDmConnection,
  FireDAC.Comp.Client, System.SysUtils, SynDB, System.Rtti;

type
  TDaoUtils = class
  private
    FConnection: TSQLDBConnectionProperties;
    property Connection: TSQLDBConnectionProperties read FConnection;
  public
    class var RttiContext: TRttiContext;
    constructor Create(pConnection: TSQLDBConnectionProperties);

    function ExecuteNoResult(const pSQL: String): Integer;

    function SelectAsJSon(const pSql: String): String;
    function SelectAsDataset(const pSql: String; AOwner: TComponent = nil): TDataSet;
    function SelectAsDocVariant(const pSql: String): Variant;

    function SelectValue(const pSql: String): Variant;
    function SelectDouble(const pSQL: String; pValorDef: Double = 0): Double;
    function SelectInt(const pSQL: String; pValorDef: Integer = 0): Integer;

//    function GetLastID: Integer;

    // Popula o record com o primeiro registro retornado pelo banco
    function SelectAsRecord(var Rec; TypeInfo: pointer; const pSql: String): Boolean;
    // Retorna um array populado com o retorno da query
    function SelectAsArray(var pArray; TypeInfo: pointer; const pSql: String): Boolean;
    // Popula o objeto com o primeiro registro retornado pelo banco
    function SelectAsObject(var ObjectInstance; const pSql: String): Boolean;

    // Popula um objectlist, cada registro retornado será um objeto na lista. TItemClass = Classe dos Itens do ObjectList
    // ATENÇÃO:: AS PROPRIEDADES DO OBJETO QUE DEVEM SER RETORNADAS TEM QUE ESTAR NA SEÇÃO PUBLISHED!!!
    function SelectAsObjectList(var ObjectInstance: TObjectList; ItemClass: TClass; const pSql: String): Boolean; overload;
    function SelectAsObjectList<T: class>(var ObjectList: TObjectList<T>; ItemClass: TClass; const pSql: String): Boolean; overload;
  end;

procedure CopyFields(Source, Dest: TDataSet);

implementation

uses
  mORMot, MormotVCL, SynCommons, SynDBVCL, Ladder.Utils, TypInfo;

{ TDaoUtils }

procedure CopyFields(Source, Dest: TDataSet);
var
  Field, NewField: Data.DB.TField;
  FieldDef: TFieldDef;
begin
  for Field in Source.Fields do
  begin
    FieldDef := Dest.FieldDefs.AddFieldDef;
    FieldDef.DataType := Field.DataType;
    FieldDef.Size := Field.Size;
    FieldDef.Name := Field.FieldName;

    NewField := FieldDef.CreateField(Dest);
    NewField.Visible := Field.Visible;
    NewField.DisplayLabel := Field.DisplayLabel;
    NewField.DisplayWidth := Field.DisplayWidth;
    NewField.EditMask := Field.EditMask;

   if IsPublishedProp(Field, 'currency')  then
     SetPropValue(NewField, 'currency', GetPropValue(Field, 'currency'));

  end;
end;
{function TDaoUtils.GetUltimoID: Integer;
begin
  Result:= SelectInt(' SELECT SCOPE_IDENTITY() ');
end;                  }

constructor TDaoUtils.Create(pConnection: TSQLDBConnectionProperties);
begin
  inherited Create;

  FConnection:= pConnection;
end;

function TDaoUtils.ExecuteNoResult(const pSQL: String): Integer;
begin
  Result:= Connection.ExecuteNoResult(pSql, []);
end;

function TDaoUtils.SelectAsJSon(const pSql: String): String;
begin
  Result:= Connection.Execute(pSql, []).FetchAllAsJSON(True);
end;

function TDaoUtils.SelectAsDataset(const pSql: String; AOwner: TComponent = nil): TDataSet;
begin
  Result:= ToDataSet(AOwner,Connection.Execute(pSql,[]));
end;

function TDaoUtils.SelectAsDocVariant(const pSql: String): Variant;
begin
  Result:= _Json(SelectAsJSon(pSql));
end;

function TDaoUtils.SelectDouble(const pSQL: String; pValorDef: Double = 0): Double;
begin
  Result:= VarToFloatDef(SelectValue(pSql), pValorDef);
end;

function TDaoUtils.SelectInt(const pSQL: String; pValorDef: Integer = 0): Integer;
begin
  Result:= VarToIntDef(SelectValue(pSql), pValorDef);
end;

function TDaoUtils.SelectValue(const pSql: String): Variant;
begin
  with Connection.Execute(pSql, []) do
    if Step then
      Result:= ColumnVariant(0)
    else
      Result:= null;
end;

function TDaoUtils.SelectAsObjectList(var ObjectInstance: TObjectList;
  ItemClass: TClass; const pSql: String): Boolean;
begin
  Result:= ObjectLoadJSon(ObjectInstance, SelectAsJSon(pSql), ItemClass);
end;

function TDaoUtils.SelectAsObjectList<T>(var ObjectList: TObjectList<T>;
  ItemClass: TClass; const pSql: String): Boolean;
var
  FResults, fVariant: Variant;
  I: Integer;
  Instance: TObject;
begin
  Result:= False;

  FResults:= SelectAsDocVariant(pSql);

  if FResults._Count = 0 then Exit;

  for I := 0 to FResults._Count-1 do
  begin
    fVariant:= _ByRef(FResults._(I), JSON_OPTIONS[true]);
    Instance:= ItemClass.Create;
    Result:= ObjectLoadJSon(Instance, fVariant._JSON, nil);
    ObjectList.Add(Instance);
  end;
end;

function TDaoUtils.SelectAsObject(var ObjectInstance;
  const pSql: String): Boolean;
var
  FResults, fVariant: Variant;
begin
  Result:= False;
  FResults:= SelectAsDocVariant(pSql);
  if FResults._Count = 0 then Exit;

  fVariant:= _ByRef(FResults._(0), JSON_OPTIONS[true]);

  Result:= ObjectLoadJSon(ObjectInstance, fVariant._JSON, nil);
end;

function TDaoUtils.SelectAsRecord(var Rec; TypeInfo: pointer;
  const pSql: String): Boolean;
var
  FResults, fVariant: Variant;
begin
  Result:= False;
  FResults:= SelectAsDocVariant(pSql);
  if FResults._Count = 0 then Exit;

  fVariant:= _ByRef(FResults._(0), JSON_OPTIONS[true]);
  Result:= RecordLoadJSON(Rec, fVariant._JSON, TypeInfo);
end;

function TDaoUtils.SelectAsArray(var pArray; TypeInfo: pointer;
  const pSql: String): Boolean;
var
  FResults, fVariant: Variant;
  fJson: String;
  I: Integer;
  aDynArray: TDynArray;
begin
  Result:= False;

  aDynArray.Init(TypeInfo,pArray);

  fJSon:= SelectAsJSon(pSql);

  aDynArray.LoadFromJSON(PUTF8Char(WinAnsiToUtf8(fJSon)));

  Result:= True;
end;

initialization
  TDaoUtils.RttiContext:= TRttiContext.Create;

end.

