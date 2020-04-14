unit uConClasses;

interface

uses
  Generics.Defaults, Generics.Collections;

type
  TTipoParametro = (ptNada, ptComboBox, ptTexto, ptDateTime, ptCheckListBox);
  TTipoConsulta = (tcNormal, tcEvolutivo, tcParametros);
  TTipoVisualizacao = (tvTabela, tvTabelaDinamica, tvGrafico);
  TFormatacaoCampo = (fcTexto, fcMoeda, fcPorcentagem);

  TParametroCon = class(TObject)
  private
    FCodigo: Integer;
    FNome: String;
    FValor: Variant;
    FTipo: TTipoParametro;
    FDescricao: String;
    FSql: String;
    FValorPadrao: String;
  public
    constructor Create(pNome: String; pValor: Variant; pTipo: TTipoParametro; pDescricao: String=''; pSql: String=''); overload;
    property Valor: Variant read FValor write FValor;
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
