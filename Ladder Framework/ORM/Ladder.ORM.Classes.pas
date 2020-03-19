unit uFrwUtils;

interface

uses
  SysUtils, Generics.Collections, {Spring.Collections, }System.Rtti,Data.DB, Contnrs, UntFuncoes;

type
  // Caso seja necessário trocar para um Int64 futuramente
  FrwID = Integer;

  IFrwObjectList<T: Class> = interface (IInvokable)
  {$REGION 'Property Accessors'}
    function GetCount: Integer;
    function GetItem(index: Integer): T;
  {$ENDREGION}

    function Contains(const Value: T): Boolean;
    function IndexOf(const item: T): Integer; overload;

    property Count: Integer read GetCount;
    property Items[index: Integer]: T read GetItem; default;

    function GetEnumerator: TList<T>.TEnumerator;
  end;

  // Mesma coisa que TObjectList<T>, mas com métodos virtuais
  TFrwObjectList<T: Class> = class(TObjectList<T>, IFrwObjectList<T>)
{$IFNDEF AUTOREFCOUNT}
  private const
    objDestroyingFlag = Integer($80000000);
    function GetRefCount: Integer; inline;
{$ENDIF}
  protected
  {$IFNDEF AUTOREFCOUNT}
    [Volatile] FRefCount: Integer;
    class procedure __MarkDestroying(const Obj); static; inline;
  {$ENDIF}
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
{$IFNDEF AUTOREFCOUNT}
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class function NewInstance: TObject; override;
    property RefCount: Integer read GetRefCount;
{$ENDIF}
  public
    function GetCount: Integer;
    function GetItem(index: Integer): T;

    function Add(const Value: T): Integer; virtual;
    procedure Insert(Index: Integer; const Value: T); virtual;
    function Remove(const Value: T): Integer; virtual;
  end;

  // Repository Pattern

  TBOCollection<T: Class> = class(TFrwObjectList<T>)
  private
    FPropChave: TRttiProperty;
    FDictionary: TDictionary<FrwID,T>;
  protected
    property PropChave: TRttiProperty read FPropChave;
  public
    constructor Create(pNomePropChave: String);
    destructor Destroy; override;

    function Get(pID: FrwID): T;

    function Values: TDictionary<FrwID, T>.TValueCollection;
    function Keys: TDictionary<FrwID, T>.TKeyCollection;
    function ContainsKey(Key: FrwID): Boolean;
    function ContainsValue(Value: T): Boolean;

    function GetValorChave(const pObject: T): FrwID;

    function Add(const Value: T): Integer; override;
    function Remove(const Value: T): Integer; override;
  end;

{  TFrwUtils = class
    constructor Create;
    procedure IFrwObjectListToDataSet<T: Class>(pObjectList: IFrwObjectList<T>; pDataSet: TDataSet);
  end;}

{var
  FrwUtils: TFrwUtils;}

implementation

{
constructor TFrwUtils.Create;
begin
  inherited;

  TFuncoes.CheckAssigned;
end;

procedure TFrwUtils.IFrwObjectListToDataSet<T>(pObjectList: IFrwObjectList<T>; pDataSet: TDataSet);
var
  I: Integer;
begin
  for I := 0 to pObjectList.Count-1 do
  begin
    pDataSet.Insert;
    Funcoes.ObjectToDataSet(pObjectList[I], pDataSet);
    pDataSet.Post;
  end;
end;
}
 {TFrwObjectList<T>}


{$IFNDEF AUTOREFCOUNT}

function TFrwObjectList<T>.GetRefCount: Integer;
begin
  Result := FRefCount and not objDestroyingFlag;
end;

class procedure TFrwObjectList<T>.__MarkDestroying(const Obj);
var
  LRef: Integer;
begin
  repeat
    LRef := TFrwObjectList<T>(Obj).FRefCount;
  until AtomicCmpExchange(TFrwObjectList<T>(Obj).FRefCount, LRef or objDestroyingFlag, LRef) = LRef;
end;

procedure TFrwObjectList<T>.AfterConstruction;
begin
// Release the constructor's implicit refcount
  AtomicDecrement(FRefCount);
end;

procedure TFrwObjectList<T>.BeforeDestruction;
begin
  if RefCount <> 0 then
    System.Error(reInvalidPtr);
end;

function TFrwObjectList<T>.GetCount: Integer;
begin
  Result:= Self.Count;
end;

function TFrwObjectList<T>.GetItem(index: Integer): T;
begin
  Result:= Self.Items[index];
end;

// Set an implicit refcount so that refcounting during construction won't destroy the object.
class function TFrwObjectList<T>.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  TFrwObjectList<T>(Result).FRefCount := 1;
end;

{$ENDIF AUTOREFCOUNT}

function TFrwObjectList<T>.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TFrwObjectList<T>._AddRef: Integer;
begin
{$IFNDEF AUTOREFCOUNT}
  Result := AtomicIncrement(FRefCount);
{$ELSE}
  Result := __ObjAddRef;
{$ENDIF}
end;

function TFrwObjectList<T>._Release: Integer;
begin
{$IFNDEF AUTOREFCOUNT}
  Result := AtomicDecrement(FRefCount);
  if Result = 0 then
  begin
    // Mark the refcount field so that any refcounting during destruction doesn't infinitely recurse.
    __MarkDestroying(Self);
    Destroy;
  end;
{$ELSE}
  Result := __ObjRelease;
{$ENDIF}
end;

{ TBOCollection<T> }

function TBOCollection<T>.ContainsKey(Key: FrwID): Boolean;
begin
  Result:= FDictionary.ContainsKey(Key);
end;

function TBOCollection<T>.ContainsValue(Value: T): Boolean;
begin
  Result:= FDictionary.ContainsValue(Value);
end;

constructor TBOCollection<T>.Create(pNomePropChave: String);
begin
  inherited Create;

  FPropChave:= TFuncoes.RttiContext.GetType(T).GetProperty(pNomePropChave);
  FDictionary:= TDictionary<Integer,T>.Create;
end;

destructor TBOCollection<T>.Destroy;
begin
  FDictionary.Free;

  inherited;
end;

function TBOCollection<T>.Get(pID: FrwID): T;
begin
  if not FDictionary.ContainsKey(pID) then
    Result:= nil
  else
    Result:= FDictionary[pID];
end;

function TBOCollection<T>.GetValorChave(const pObject: T): Integer;
begin
  Result:= FPropChave.GetValue(TObject(pObject)).AsInteger;
end;

function TBOCollection<T>.Values: TDictionary<FrwID, T>.TValueCollection;
begin
  Result:= FDictionary.Values;
end;

function TBOCollection<T>.Keys: TDictionary<FrwID, T>.TKeyCollection;
begin
  Result:= FDictionary.Keys;
end;

function TBOCollection<T>.Add(const Value: T): Integer;
begin
  Result:= inherited Add(Value);
  FDictionary.Add(GetValorChave(Value), Value);
end;

function TBOCollection<T>.Remove(const Value: T): Integer;
begin
  Result:= inherited Remove(Value);
  FDictionary.Remove(GetValorChave(Value));
end;

{ TFrwObjectList<T> }

function TFrwObjectList<T>.Add(const Value: T): Integer;
begin
  Result:= inherited Add(Value);
end;

procedure TFrwObjectList<T>.Insert(Index: Integer; const Value: T);
begin
  inherited Insert(Index, Value);
end;

function TFrwObjectList<T>.Remove(const Value: T): Integer;
begin
  Result:= inherited Remove(Value);
end;

{initialization
  FrwUtils:= nil;}

end.
