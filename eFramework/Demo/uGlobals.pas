unit uGlobals;

interface

uses
  uDmConnection, UntFuncoes, UntDaoUtils;

procedure Inicializar(Conn: TDmConnection);

implementation

procedure Inicializar(Conn: TDmConnection);
begin
  Funcoes:= TFuncoes.Create(Conn);
  DaoUtils:= TDaoUtils.Create(Conn, Funcoes);
end;


end.
