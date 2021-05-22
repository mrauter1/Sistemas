
unit uDmConnection;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXFirebird,
  Data.FMTBcd, Datasnap.DBClient, Datasnap.Provider, Inifiles, Forms, TypInfo,
  Variants, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Comp.Client, Utils, System.Rtti, Ladder.Parser,
  FireDAC.VCLUI.Wait, Ladder.Types;

type
 cfMapField = record
   SourceType: TFieldType;
   DestType: TFieldType;
 end;

{  TConnectionParams = record
    Server: String;
    Protocol: String;
    Port: Integer;
    Database: String;
  end;              }

type
  TOnReturnData = procedure (DataSet: TDataSet; var Return: Variant);

  TDmConnection = class(TDataModule)
    FDConnection: TFDConnection;
    procedure FDConnectionAfterCommit(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FModoDesconectado: Boolean;
    procedure SetModoDesconectado(const Value: BOolean);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AOwner: TComponent; pConParams: TConnectionParams); overload;

    procedure LerConnectionParams(pConParams: TConnectionParams; pOpen: Boolean=True);

    function CriaFDQuery(sql: String = ''; AParent: TComponent = nil): TFDQuery;
    function RetornaDataSet(sql: String; pAbrirDataSet: Boolean = True): TDataSet;
    function RetornaFDQuery(AOwner: TComponent; Sql: String; pAbrirDataSet: Boolean = True): TFDQuery;

    function ExecutaComando(pSql: String): LongInt;
    function ExecSql(pSql: String; const pParams: array of variant): LongInt;

    function RetornaValor(Sql: String; ValDefault: Variant): Variant; overload;
    function RetornaValor(Sql: String): Variant; overload;
    function RetornaInteiro(Sql: String; pDefault: Integer = 0): Integer;
    function RetornaDouble(const pSQL: String; pValorDef: Double = 0): Double;

    function RetornaArray<T>(Sql: String; ValDefault: T): TArray<T>; // Retorna o primeiro campo de múltiplos registros
    function RetornaVarArray(const Sql: String; ValDefault: Variant): Variant; // Retorna o primeiro campo de múltiplos registros
    function RetornaValores(const pSql: String): Variant; //Retorna múltiplos campos de um memos registro

    procedure DataSetToVarArray(const pSql: string; var Return: Variant; OnReturnData: TOnReturnData); overload;
    //DataSetToVarArray: Retorna múltiplos campos de múltiplos registros, se AddFieldNames for True, adiciona os nomes dos campos no index -1
    procedure DataSetToVarArray(const pSql: String; var Return: Variant; AddFieldNames: Boolean); overload;

    // transforma um field do tipo fkCalculated em fkLookup
    procedure TransformaEmLookup(pField: TField; pSql: String);

    procedure PopulaClientDataSet(pCds: TClientDataSet; pSql: String; pEmptyDataSet: Boolean = True);

    function OrdenaClientDataSet(parCds: TClientDataSet;
        const FieldName: String; PIndexOptions: TIndexOptions = []): Boolean;
    procedure CarregaConnectionInfo(pFile, pSection: String);

    class procedure CopyFieldDefs(Dest, Source: TDataSet; pMapedFields: array of cfMapField); overload;
    class procedure CopyFieldDefs(Dest, Source: TDataSet); overload;

    property ModoDesconectado: BOolean read FModoDesconectado write SetModoDesconectado;
  end;

procedure ReopenDataSet(pDataSet: TDataSet);
// Retorna um array com o nome dos campos que são diferentes entre um e outro dataset
function ComparaRecord(pDataSet1, pDataSet2: TDataSet; pCamposParaIgnorar: String = ''): TArray<String>;
procedure CopiarRecord(pSource, pDest: TDataSet);
procedure CopiaDadosDataSet(pSource, pDest: TDataSet);

implementation

uses
  Ladder.Orm.DaoUtils;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDmConnection }

procedure ReopenDataSet(pDataSet: TDataSet);
begin
  if pDataSet.Active then
    pDataSet.Close;

  pDataSet.Open;
end;

class procedure TDmConnection.CopyFieldDefs(Dest, Source: TDataSet; pMapedFields: array of cfMapField);
var
  FFieldType: TFieldType;
  Field, NewField: TField;
  FieldDef: TFieldDef;

  function GetFieldType: TFieldType;
  var
    I: Integer;
  begin
    for I := Low(pMapedFields) to High(pMapedFields) do
    begin
      if Field.DataType = pMapedFields[I].SourceType then
      begin
        Result:= pMapedFields[I].DestType;
        Exit;
      end;
    end;

    Result:= Field.DataType;
  end;

begin
  for Field in Source.Fields do
  begin
    FFieldType:= GetFieldType;

   // Skip unknown fields
    if FFieldType = ftUnknown then
      Continue;

    FieldDef := Dest.FieldDefs.AddFieldDef;

    FieldDef.DataType:= FFieldType;

    FieldDef.Size := Field.Size;
    FieldDef.Name := Field.FieldName;

    NewField := FieldDef.CreateField(Dest);
    NewField.Visible := Field.Visible;
    NewField.DisplayLabel := Field.DisplayLabel;
    NewField.DisplayWidth := Field.DisplayWidth;
    NewField.EditMask := Field.EditMask;

   if IsPublishedProp(Field, 'currency') then
     SetPropValue(NewField, 'currency', GetPropValue(Field, 'currency'));

  end;
end;

class procedure TDmConnection.CopyFieldDefs(Dest, Source: TDataSet);
begin
  TDmConnection.CopyFieldDefs(Dest, Source, []);
end;

function ComparaRecord(pDataSet1, pDataSet2: TDataSet; pCamposParaIgnorar: String = ''): TArray<String>;
var
  FField1, FField2: TField;

  function CampoIgnorado(pCampo: String): Boolean;
  var
    fStr: String;
  begin
    Result:= True;

    for fStr in pCamposParaIgnorar.Split([';']) do
      if Trim(fStr).ToUpper = pCampo.ToUpper then
        Exit;

    Result:= False;
  end;

begin
  SetLength(Result, 0);
  for FField1 in pDataSet1.Fields do
  begin
    if CampoIgnorado(FField1.FieldName) then
      Continue;

    FField2:= pDataSet2.FindField(FField1.FieldName);
    if Assigned(FField2) then
      if FField2.Value <> FField1.Value then
      begin
        SetLength(Result, Length(Result)+1);
        Result[High(Result)]:= FField1.FieldName;
      end;

  end;
end;

procedure CopiarRecord(pSource, pDest: TDataSet);
var
  I: Integer;
  FSourceField: TField;
begin
  for I := 0 to pDest.Fields.Count - 1 do
  begin
    FSourceField:= pSource.FindField(pDest.Fields[I].FieldName);
    if Assigned(FSourceField) then
      pDest.Fields[I].Value:= FSourceField.Value;

  end;
end;

procedure CopiaDadosDataSet(pSource, pDest: TDataSet);
begin
  pSource.First;
  while not pSource.Eof do
  begin
    pDest.Insert;
    CopiarRecord(pSource, pDest);
    pDest.Post;

    pSource.Next;
  end;
end;

constructor TDmConnection.Create(AOwner: TComponent);
begin
  ModoDesconectado:= False;

  inherited Create(AOwner);
end;

constructor TDmConnection.Create(AOwner: TComponent;
  pConParams: TConnectionParams);
begin
  Create(AOwner);
  LerConnectionParams(pConParams);
end;

function TDmConnection.CriaFDQuery(sql: String = ''; AParent: TComponent = nil): TFDQuery;
var
  FParent: TComponent;
begin
  if not Assigned(AParent) then
    FParent:= Self
  else
    FParent:= AParent;

  Result:= TFDQuery.Create(FParent);
  try
    Result.Connection:= FDConnection;
    Result.SQL.Text:= sql;
  except
    Result.Free;
    raise;
  end;
end;

procedure TDmConnection.DataModuleCreate(Sender: TObject);
begin
  if ModoDesconectado then
    FDConnection.Offline;
end;

function TDmConnection.RetornaDataSet(Sql: String; pAbrirDataSet: Boolean = True): TDataSet;
var
  fQuery: TFDQuery;
begin
  fQuery:= CriaFDQuery(Sql);
  try
    if pAbrirDataSet then
      fQuery.Open;
  except
    fQuery.Free;
    raise;
  end;

  Result:= fQuery;
end;

function TDmConnection.RetornaValor(Sql: String; ValDefault: Variant): Variant;
var
  FDataSet: TDataSet;
begin
  FDataSet:= RetornaDataSet(Sql);
  try
     Result:= FDataSet.Fields[0].AsVariant;
     if VarIsNull(Result) then
       Result:= ValDefault;
  finally
    FDataSet.Free;
  end;
end;


function TDmConnection.RetornaValor(Sql: String): Variant;
var
  FDataSet: TDataSet;
begin
  FDataSet:= RetornaDataSet(Sql);
  try
     Result:= FDataSet.Fields[0].AsVariant;
  finally
    FDataSet.Free;
  end;
end;

function TDmConnection.RetornaArray<T>(Sql: String; ValDefault: T): TArray<T>;
var
  FDataSet: TDataSet;
  I: Integer;
begin
  FDataSet:= RetornaDataSet(Sql);
  try
    SetLength(Result, FDataSet.RecordCount);
    I:= 0;

    FDataSet.First;
    while not FDataSet.Eof do
    begin
      FDataSet.Fields[0].Value;
      if VarIsNull(FDataSet.Fields[0].Value) then
        Result[I]:= ValDefault
      else
        Result[I]:= TValue.FromVariant(FDataSet.Fields[0].Value).AsType<T>;

      FDataSet.Next;
      Inc(I);
    end;

  finally
    FDataSet.Free;
  end;
end;

function TDmConnection.RetornaValores(const pSql: String): Variant;
var
  vQuery: TFDQuery;
  I: Integer;
begin
  vQuery:= CriaFDQuery(pSql);
  try
    vQuery.SQL.Text:= pSql;
    vQuery.Active:= True;

    if vQuery.Fields.Count = 0 then
    begin
      Result:= null;
    end
   else
    begin
      Result:= VarArrayCreate([0, vQuery.Fields.Count], varVariant);
      for I:= 0 to vQuery.Fields.Count - 1 do
        Result[I]:= vQuery.Fields[I].Value;
    end;

    vQuery.Close;
  finally
    vQuery.Free;
  end;
end;

procedure TDmConnection.DataSetToVarArray(const pSql: string; var Return: Variant; OnReturnData: TOnReturnData);
var
  FDataSet: TFDQuery;
begin
  FDataSet:= RetornaFDQuery(nil, pSql, True);
  try
    FDataSet.FetchAll;
    FDataSet.First;
    OnReturnData(FDataSet, Return);
  finally
    FDataSet.Free;
  end;
end;

procedure TDmConnection.DataSetToVarArray(const pSql: String; var Return: Variant; AddFieldNames: Boolean);
var
  FDataSet: TFDQuery;
  I, F: Integer;
  FNewRow: Variant;
  FLowBound: Integer;

  function NewRow(DataSet: TDataSet): Variant;
  begin
    Result:= VarArrayCreate([0, DataSet.FieldCount-1], varVariant);
  end;

begin
  FDataSet:= RetornaFDQuery(nil, pSql, True);
  try
    FDataSet.FetchAll;
    FDataSet.First;

    if AddFieldNames then
      FLowBound:= -1 // Store field name on index -1
    else FLowBound:= 0;

    Return:= VarArrayCreate([FLowBound, FDataSet.RecordCount-1], varVariant);

    if AddFieldNames then
    begin
      FNewRow:= NewRow(FDataSet);
      for F:= 0 to FDataSet.FieldCount-1 do
        FNewRow[F]:= FDataSet.Fields[F].FieldName;

      Return[-1]:= FNewRow;
    end;

    I:= 0;
    while not FDataSet.Eof do
    begin
      FNewRow:= NewRow(FDataSet);
      for F:= 0 to FDataSet.FieldCount-1 do
          FNewRow[F]:= FDataSet.Fields[F].AsVariant;

      Return[I]:= FNewRow;

      FDataSet.Next;
      Inc(I);
    end;
  finally
    FDataSet.Free;
  end;
end;

function TDmConnection.RetornaVarArray(const Sql: String; ValDefault: Variant): Variant;
var
  FDataSet: TDataSet;
  FValues: Variant;
  I: Integer;
begin
  FDataSet:= RetornaDataSet(Sql);
  try
    Result:= VarArrayCreate([0, FDataSet.RecordCount-1], varVariant);
    I:= 0;

    FDataSet.First;
    while not FDataSet.Eof do
    begin
      Result[I]:= FDataSet.Fields[0].AsVariant;
      if VarIsNull(Result[I]) then
        Result[I]:= ValDefault;

      FDataSet.Next;
      Inc(I);
    end;

  finally
    FDataSet.Free;
  end;
end;

procedure TDmConnection.SetModoDesconectado(const Value: BOolean);
begin
  FModoDesconectado := Value;

  if FModoDesconectado then
    FDConnection.Offline;
end;

function TDmConnection.ExecSql(pSql: String; const pParams: array of variant): LongInt;
var
  FQry: TFDQuery;
begin
  FQry:= CriaFDQuery(pSql);
  try
    Result:= FQry.ExecSQL(pSql, pParams);
  finally
    FQry.Free;
  end;
end;

function TDmConnection.ExecutaComando(pSql: String): LongInt;
begin
  Result:= ExecSql(pSql, []);
end;

function TDmConnection.RetornaFDQuery(AOwner: TComponent; Sql: String; pAbrirDataSet: Boolean = True): TFDQuery;
var
  fQry: TFDQuery;
begin
  fQry:= TFDQuery.Create(AOwner);
  try
    fQry.Connection:= FDConnection;

    fQry.SQL.Text:= Sql;

    if pAbrirDataSet then
      fQry.Open;
  except
    fQry.Free;
    raise;
  end;

  Result:= fQry;
end;

function TDmConnection.RetornaInteiro(Sql: String; pDefault: Integer): Integer;
begin
  Result:=  VarToIntDef(RetornaValor(Sql), pDefault);
end;

function TDmConnection.RetornaDouble(const pSQL: String; pValorDef: Double = 0): Double;
begin
  Result:= VarToFloatDef(RetornaValor(pSQL), pValorDef);
end;

procedure TDmConnection.FDConnectionAfterCommit(Sender: TObject);
begin
  if ModoDesconectado then
    FDConnection.Offline;
end;

procedure TDmConnection.LerConnectionParams(pConParams: TConnectionParams; pOpen: Boolean=True);
begin
  FDConnection.Close;
  FDConnection.Params.Values['DriverID'] := pConParams.DriverID;
  FDConnection.Params.Values['Server'] := pConParams.Server;
  FDConnection.Params.Values['Port'] := IntToStr(pConParams.Port);
  FDConnection.Params.Values['Database'] := pConParams.Database;
  FDConnection.Params.Values['Protocol'] := pConParams.Protocol;
  FDConnection.Params.Values['User_Name'] := pConParams.User;
  FDConnection.Params.Values['Password'] := pConParams.Password;

  if pOpen then
    FDConnection.Open;
end;

procedure TDmConnection.CarregaConnectionInfo(pFile, pSection: String);
var
  ArqIni: TIniFile;
begin
  FDConnection.Close;
  if FileExists(pFile) then
    begin
      ArqIni:= TIniFile.Create(pFile);
      try
        FDConnection.Params.Values['Server'] :=
            ArqIni.ReadString(pSection, 'Server', FDConnection.Params.Values['Server']);
        FDConnection.Params.Values['Database'] :=
            ArqIni.ReadString(pSection, 'Database', FDConnection.Params.Values['Database']);
        FDConnection.Params.Values['Port'] :=
            ArqIni.ReadString(pSection, 'Port', FDConnection.Params.Values['Port']);
        FDConnection.Params.Values['Protocol'] :=
            ArqIni.ReadString(pSection, 'Protocol', FDConnection.Params.Values['Protocol']);
      finally
        ArqIni.Free;
      end;
    end;

  FDConnection.Open;
end;

procedure TDmConnection.TransformaEmLookup(pField: TField; pSql: String);
var
  fQry: TFDQuery;
begin
  if pField.FieldKind <> fkCalculated then
    raise Exception.Create('Erro TDmCon.TransformaLookup: Field deve ter a propriedade FieldKind = fkCalculated!');

  fQry:= RetornaFDQuery(pField, pSql, True);
  if fQry.Fields.Count < 2 then
  begin
    fQry.Free;
    raise Exception.Create('Erro TDmCon.TransformaLookup: Query deve retornar dois campos! Qry: '+pSql);
  end;

  pField.FieldKind:= fkLookup;
  pField.Lookup:= True;
  pField.LookupDataSet:= fQry;
  pField.LookupKeyFields:= fQry.Fields[0].FieldName;
  pField.KeyFields:= fQry.Fields[0].FieldName;
  pField.LookupResultField:= fQry.Fields[1].FieldName;
end;

function TDmConnection.OrdenaClientDataSet(parCds: TClientDataSet;
      const FieldName: String; PIndexOptions: TIndexOptions = []): Boolean;
const
  cIdx = 'idxx';
var
  I: Integer;
  Field: TField;
begin
  Result := False;
  Field := parCds.Fields.FindField(FieldName);
 //If invalid field name, exit.
  if Field = nil then Exit;
  if (Field is TObjectField) or (Field is TBlobField) or
    (Field is TAggregateField) or (Field is TVariantField)
     or (Field is TBinaryField) then Exit;
  //Get IndexDefs and IndexName using RTTI
  //Ensure IndexDefs is up-to-date
  parCds.IndexDefs.Update;
  for i := 0 to parCds.IndexDefs.Count - 1 do
  begin
    if parCds.IndexDefs[i].Name = cIdx then
      parCds.DeleteIndex(cIdx);
  end;

  parCds.AddIndex(cIdx, FieldName, pIndexOptions);

  //Set the index
  parCds.IndexName := cIdx;
  Result:= True;
  parCds.IndexDefs.Update;
end;

procedure TDmConnection.PopulaClientDataSet(pCds: TClientDataSet; pSql: String;
  pEmptyDataSet: Boolean = True);
var
  FQry: TDataSet;
begin
  if not pCds.Active then
    pCds.CreateDataSet;

  if pEmptyDataSet then
    pCds.EmptyDataSet;

  FQry:= RetornaDataSet(pSql);
  try
    CopiaDadosDataSet(FQry, pCds);
  finally
    FQry.Free;
  end;
end;

end.
