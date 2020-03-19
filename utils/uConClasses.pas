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
  public
    FCodigo: Integer;
    FNome: String;
    FValor: Variant;
    FTipo: TTipoParametro;
    FDescricao: String;
    FSql: String;
    constructor Create(pNome: String; pValor: Variant; pTipo: TTipoParametro; pDescricao: String=''; pSql: String=''); overload;
  published
    property Codigo: integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Valor: Variant read FValor write FValor;
    property Tipo: TTipoParametro read FTipo write FTipo;
    property Descricao: String read FDescricao write FDescricao;
    property Sql: String read FSql write FSql;
  end;

  TParametros = class(TDictionary<String, TParametroCon>)
  public
    constructor Create;
    function ParamValueByName(pNome: String; pDefault: Variant): variant;
    procedure Add(pParam: TParametroCon); overload;
    procedure Remove(PParam: TParametroCon); overload;
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

procedure TParametros.Add(pParam: TParametroCon);
begin
  Add(pParam.Nome, pParam);
end;

constructor TParametros.Create;
begin
  inherited Create(TOrdinalIStringComparer.Create); // case insensitive
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

procedure TParametros.Remove(PParam: TParametroCon);
begin
  Remove(pParam.Nome);
end;

end.
