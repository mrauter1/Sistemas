unit uConClasses.Dao;

interface

uses
  Ladder.ORM.Dao, uConClasses, SysUtils;

type
  IConsultaDao<T: TConsulta> = interface(IDaoGeneric<T>)
    function SelectByNome(pName: String): T;
  end;

  TConsultaDao<T: TConsulta> = class(TDaoGeneric<T>, IConsultaDao<T>, IDaoGeneric<T>)
  private
  public
    constructor Create; overload;
    function SelectByNome(pName: String): T;
  end;

implementation

{ TConsultaDao<T> }

constructor TConsultaDao<T>.Create;
var
  FParametrosDao: IDaoGeneric<TParametroCon>;
begin
  inherited Create('cons.Consultas', 'ID', T);
  FParametrosDao:= TDaoGeneric<TParametroCon>.Create('cons.Parametros', 'ID');
  AddChildDao('Parametros', 'ID', 'Consulta', FParametrosDao);
end;

function TConsultaDao<T>.SelectByNome(pName: String): T;
begin
  Result:= SelectOne(Format('Nome = ''%s'' ', [pName]));
end;

end.
