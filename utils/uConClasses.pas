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
    FID: Integer;
    FNome: String;
    FValor: Variant;
    FTipo: TTipoParametro;
    FDescricao: String;
    FSql: String;
    FValorPadrao: String;
    FTamanho: Integer;
    FObrigatorio: Boolean;
    procedure SetValor(const Value: Variant);
  public
    constructor Create(pNome: String; pValor: Variant; pTipo: TTipoParametro; pDescricao: String=''; pSql: String=''); overload;
    constructor CreateCopy(ASource: TParametroCon; pCopyID: Boolean = False);

    function TipoFromInt(Valor: Integer): Boolean;

    property Valor: Variant read FValor write SetValor;
  published
    property ID: integer read FID write FID;
    property Nome: String read FNome write FNome;
    property Tipo: TTipoParametro read FTipo write FTipo;
    property Descricao: String read FDescricao write FDescricao;
    property Sql: String read FSql write FSql;
    property ValorPadrao: String read FValorPadrao write FValorPadrao;
    property Tamanho: Integer read FTamanho write FTamanho;
    property Obrigatorio: Boolean read FObrigatorio write FObrigatorio;
  end;

  TParametros = class(TObjectDictionary<String, TParametroCon>)
  public
    constructor Create;
    function ParamValueByName(pNome: String; pDefault: Variant): variant;
    procedure Add(pParametro: TParametroCon); overload;
    procedure Remove(pParametro: TParametroCon); overload;
  end;

  TConsulta = class
  private
    FParametros: TObjectList<TParametroCon>;
    FVisualizacaoPadrao: Integer;
    FDescricao: String;
    FID: Integer;
    FIDPai: Integer;
    FSql: String;
    FNome: String;
    FTipo: TTipoConsulta;
    FFonteDados: Integer;
    FConfigPadrao: Integer;
  protected
    procedure AfterConstruction; override;
  public
  published
    destructor Destroy;
    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
    property Descricao: String read FDescricao write FDescricao;
    property Sql: String read FSql write FSql;
    property Tipo: TTipoConsulta read FTipo write FTipo;
    property ConfigPadrao: Integer read FConfigPadrao write FConfigPadrao;
    property VisualizacaoPadrao: Integer read FVisualizacaoPadrao write FVIsualizacaoPadrao;
    property IDPai: Integer read FIDPai write FIDPai;
    property FonteDados: Integer read FFonteDados write FFonteDados;
    property Parametros: TObjectList<TParametroCon> read FParametros write FParametros;
  end;

  TFonteDados = (fdSqlServer=1, fdFirebird=2);

implementation

uses
  Ladder.Utils, SysUtils, Variants, Ladder.ServiceLocator;

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

constructor TParametroCon.CreateCopy(ASource: TParametroCon; pCopyID: Boolean);
begin
  Create(ASource.Nome, ASource.Valor, ASource.Tipo, ASource.Descricao, ASource.Sql);
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

{ TConsulta }

procedure TConsulta.AfterConstruction;
begin
  inherited;
  FParametros:= TObjectList<TParametroCon>.Create;
end;

destructor TConsulta.Destroy;
begin
  FParametros.Free;
end;

end.
