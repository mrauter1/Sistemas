unit MVCUtils;

interface

const
  sBancoArquivo = 'C:\Users\Carolina\Desktop\Marcelo\bancoteste.fdb';

function CompareMethods(const a, b): Boolean;

implementation

function CompareMethods(const a, b): Boolean;
begin
  Result:= ((TMethod(a).Code = TMethod(b).Code)
  and (TMethod(a).Data = TMethod(b).Data));
end;

end.
