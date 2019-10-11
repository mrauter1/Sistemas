unit uInterfaceRecurso;

interface

uses
  System.Generics.Collections;

type
  IRecurso = Interface(IInterface)
    procedure Executar;
    procedure SubstituiParametros(ParamList: TObjectList<TParametroCon>);
  end;

implementation

end.
