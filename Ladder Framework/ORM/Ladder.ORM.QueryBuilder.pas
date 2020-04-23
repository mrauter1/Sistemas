unit Ladder.ORM.QueryBuilder;

interface

uses
  Ladder.ORM.ModeloBD, System.Classes, SysUtils, System.Rtti, Ladder.ORM.Functions,
  Ladder.Messages;

type
//  TMappingType = (mtInteiro, mtFloat,

  TQueryBuilderBase = class(TObject)
  private
    fModeloBD: TModeloBD;
  protected
  public
    constructor Create(ModeloBD: TModeloBD);
    property ModeloBD: TModeloBD read fModeloBD write fModeloBD;
    function MappedFieldList: TFieldMappingList;
    function SelectWhereChave(FValor: Integer): String; virtual; abstract;
    function SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String; virtual; abstract;

    function Insert(pObject: TObject; pOutputID: Boolean = False): String; virtual; abstract;
    function Update(pObject: TObject): String; virtual; abstract;
    function Delete(pKeyValue: Integer): String; virtual; abstract;

    function KeyExists(pValorChave: Integer): String; virtual; abstract;
    function SelectValorUltimaChave: String; virtual; abstract;
  end;

  TSqlServerQueryBuilder = class(TQueryBuilderBase)
  private
  public
    function SelectWhereChave(FValor: Integer): String; override;
    function SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String; override;

    function Insert(pObject: TObject; pOutputID: Boolean = False): String; override;
    function Update(pObject: TObject): String; override;
    function Delete(pValorChave: Integer): String; override;
    function KeyExists(pValorChave: Integer): String; override;

    function SelectValorUltimaChave: String; override;
  end;

implementation

{ TQueryBuilderBase }

constructor TQueryBuilderBase.Create(ModeloBD: TModeloBD);
begin
  FModeloBD:= ModeloBD;
end;

function TQueryBuilderBase.MappedFieldList: TFieldMappingList;
begin
  Result:= ModeloBD.MappedFieldList;
end;

{ TSqlServerQueryBuilder }

function PropToSqlValue(pProp: TRttiProperty; pObject: TObject): string;
const
  cMsgErro = 'Propriedade %s do tipo %s não foi possível ser mapeada!';
begin
  case pProp.PropertyType.TypeKind of
    tkString,tkLString,tkAnsiChar,tkWideString,tkUnicodeString:
      Result:= QuotedStr(pProp.GetValue(pObject).ToString);
    tkFloat:
      begin
        if SameText('TDateTime',pProp.PropertyType.Name) then
          Result:= Func_DateTime_SqlServer(pProp.GetValue(pObject).AsExtended)
        else
          Result:= FloatToSqlStr(pProp.GetValue(pObject).AsExtended);
      end;
    tkInteger, tkInt64: Result:= IntToStr(pProp.GetValue(pObject).AsInteger);
    tkEnumeration: Result:= IntToStr(pProp.GetValue(pObject).AsOrdinal);

    else
      TMensagem.Erro(Format(cMsgErro,[pProp.Name, pProp.PropertyType.Name]), 'Erro!', True);
  end;

end;

function TSqlServerQueryBuilder.SelectValorUltimaChave: String;
begin
  Result:= ' SELECT SCOPE_IDENTITY() ';
end;

function TSqlServerQueryBuilder.SelectWhere(const pWhere: String; pSelectOptions: TSelectOptions = []): String;
var
  fSql: TStringBuilder;
  fPrimeiroCampo: Boolean;
  fCallBack: TMapeamentoCallback;
begin
  fCallBack:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping)
    begin
      if not fPrimeiroCampo then
        fSql.Append(' , ');

      fSql.Append('  ').AppendLine(pFieldMapping.FieldName);

      if fPrimeiroCampo then
        fPrimeiroCampo:= False;
    end;

  fPrimeiroCampo:= True;

  fSql:= TStringBuilder.Create;
  try
    fSql.AppendLine('SELECT ');

    if Top0 in pSelectOptions then
      fSql.AppendLine(' TOP 0 ');

    ModeloBD.FazMapeamentoDaClasse(fCallBack);

    fSql.Append('FROM ').AppendLine(ModeloBD.NomeTabela);

    if pWhere <> '' then
      fSql.AppendLine('WHERE '+pWhere);

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

function TSqlServerQueryBuilder.SelectWhereChave(FValor: Integer): String;
begin
  Result:= SelectWhere(Format('%s = %d', [ModeloBD.NomeCampoChave, FValor]));
end;

function TSqlServerQueryBuilder.Delete(pValorChave: Integer): String;
begin
  Result:= Format('DELETE FROM %s WHERE %s = %d', [ModeloBD.NomeTabela, ModeloBD.NomeCampoChave, pValorChave]);
end;

function TSqlServerQueryBuilder.Insert(pObject: TObject; pOutputID: Boolean = False): String;
var
  fSql: TStringBuilder;
  fPrimeiroCampo: Boolean;
  fCallBack: TMapeamentoCallback;
  fMapeandoValores: Boolean;

  procedure MapeiaCampos;
  begin
    fPrimeiroCampo:= True;
    fMapeandoValores:= False;

    fSql.Append(' (');
    ModeloBD.FazMapeamentoDaClasse(fCallBack);
    fSql.AppendLine(')')
  end;

  procedure MapeiaValores;
  begin
    fPrimeiroCampo:= True;
    fMapeandoValores:= True;

    fSql.Append(' VALUES(');
    ModeloBD.FazMapeamentoDaClasse(fCallBack);
    fSql.Append(')');
  end;

begin
  fCallBack:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping)
    begin
      try
        if (fModeloBD.ChaveIncremental) and (pFieldMapping.Prop = fModeloBD.PropChave) then
          Exit;

        if not fPrimeiroCampo then
          fSql.Append(', ');

        if not fMapeandoValores then
          fSql.Append('  ').Append(pFieldMapping.FieldName)
        else
          fSql.Append('  ').Append(PropToSqlValue(pFieldMapping.Prop, pObject));

        if fPrimeiroCampo then
          fPrimeiroCampo:= False;
       except
         on E: Exception do
           raise Exception.Create('Erro ao mapear propriedade: '+pFieldMapping.PropName+'. Mensagem: '+E.Message);
       end;
    end;

  fSql:= TStringBuilder.Create;
  try
    fSql.Append('INSERT INTO ').AppendLine(ModeloBD.NomeTabela);

    MapeiaCampos;

    if pOutputID then
      fSql.AppendFormat('OUTPUT INSERTED.%s', [fModeloBD.NomeCampoChave]);

    MapeiaValores;

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

function TSqlServerQueryBuilder.Update(pObject: TObject): String;
var
  fSql: TStringBuilder;
  fPrimeiroCampo: Boolean;
  fCallBack: TMapeamentoCallback;
begin
  fCallBack:=
    procedure (pClass: TClass; pFieldMapping: TFieldMapping)
    begin
      if (fModeloBD.ChaveIncremental) and (pFieldMapping.Prop = fModeloBD.PropChave) then
        Exit;

      if not fPrimeiroCampo then
        fSql.Append(' , ');

      fSql.Append('  ').Append(pFieldMapping.FieldName);

      fSql.Append(' = ').AppendLine(PropToSqlValue(pFieldMapping.Prop, pObject));

      if fPrimeiroCampo then
        fPrimeiroCampo:= False;
    end;

  fSql:= TStringBuilder.Create;
  try
    fSql.Append('UPDATE ').AppendLine(ModeloBD.NomeTabela);

    fSql.Append(' SET ');

    fPrimeiroCampo:= True;
    ModeloBD.FazMapeamentoDaClasse(fCallBack);

    fSql.AppendFormat('WHERE %s = %d ', [ModeloBD.NomeCampoChave, ModeloBD.GetValorChave(pObject)]);

    Result:= fSql.ToString;

  finally
    fSql.Free;
  end;
end;

function TSqlServerQueryBuilder.KeyExists(pValorChave: Integer): String;
begin
  Result:= Format('SELECT COUNT(*) FROM %s WHERE %s = %d', [ModeloBD.NomeTabela, ModeloBD.NomeCampoChave, pValorChave]);
end;

end.
