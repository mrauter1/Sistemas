unit uFramework;

interface

procedure EnviaRelPorEmail(Relatorio: TRelatorio; Destino: String; Texto: String);

type TVerificador = class(TObject)
  Periodo: Integer;
  Script: TScript;
  Email: TEmail;
  Relatorio: TRelatorio;

end;



implementation

end.
