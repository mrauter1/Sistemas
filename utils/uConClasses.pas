unit uConClasses;

interface

uses
  Generics.Defaults, Generics.Collections;

type
  TTipoParametro = (ptNada, ptComboBox, ptTexto, ptDateTime, ptCheckListBox);
  TTipoConsulta = (tcNormal, tcEvolutivo, tcParametros);
  TTipoVisualizacao = (tvTabela, tvTabelaDinamica, tvGrafico);
  TFormatacaoCampo = (fcTexto, fcMoeda, fcPorcentagem);

  RConsulta = record
    ID: Integer;
    Nome: String;
    Descricao: String;
    Sql: String;
    Tipo: TTipoConsulta;
    ConfigPadrao: Integer;
    VisualizacaoPadrao: Integer;
    IDPai: Integer;
    FonteDados: Integer;
  end;

  TParametroCon = class(TObject)
  private
    FCodigo: Integer;
    FNome: String;
    FValor: Variant;
    FTipo: TTipoParametro;
    FDescricao: String;
    FSql: String;
    FValorPadrao: String;
    procedure SetValor(const Value: Variant);
  public
    constructor Create(pNome: String; pValor: Variant; pTipo: TTipoParametro; pDescricao: String=''; pSql: String=''); overload;

    function TipoFromInt(Valor: Integer): Boolean;

    property Valor: Variant read FValor write SetValor;
  published
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Tipo: TTipoParametro read FTipo write FTipo;
    property Descricao: String read FDescricao write FDescricao;
    property Sql: String read FSql write FSql;
    property ValorPadrao: String read FValorPadrao write FValorPadrao;
  end;

  TParametros = class(TObjectDictionary<String, TParametroCon>)
  public
    constructor Create;
    function ParamValueByName(pNome: String; pDefault: Variant): variant;
    procedure Add(pParametro: TParametroCon); overload;
    procedure Remove(pParametro: TParametroCon); overload;
  end;

  TFonteDados = (fdSqlServer=1, fdFirebird=2);

implementation

uses
  Ladder.Utils, Variants;

{ TParametroCon }

constructor TParametroCon.Create(pNome: String; pValor: Variant; pTipo: TTipoParametro; pDescricao: String=''; pSql: String='');
begin
  inherited Create;

  Self.Nome:= pNome;
  Self.Valor:= pValor;
  Self.Tipo:= pTipo;
  Self.Descricao:= pDescricao;
  Self.Sql:= pSql;
end;

procedure TParametroCon.SetValor(const Value: Variant);
begin
  if VarIsNull(Value) then
  begin
    FValor:= null;
    Exit;
  end;

  if Self.Tipo = TTipoParametro.ptDateTime then
    FValor:= LadderVarToDateTime(Value)
  else
    FValor:= Value;

end;

function TParametroCon.TipoFromInt(Valor: Integer): Boolean;
begin
  Result:= True;

  if (Valor >= Ord(Low(Tipo))) and (Valor <= Ord(High(Tipo))) then
    Tipo:= TTipoParametro(Valor)
  else
    Result:= False;
end;

{ TParametros }
constructor TParametros.Create;
begin
  inherited Create([doOwnsValues], TOrdinalIStringComparer.Create); // case insensitive
end;

function TParametros.ParamValueByName(pNome: String; pDefault: Variant): variant;
var
  FParam: TParametroCon;
begin
  if TryGetValue(pNome, FParam) then
    Result:= FParam.Valor
  else
    Result:= pDefault;
end;

procedure TParametros.Add(pParametro: TParametroCon);
begin
  Add(pParametro.Nome, pParametro);
end;

procedure TParametros.Remove(pParametro: TParametroCon);
begin
  Remove(pParametro.Nome);
end;

end.
