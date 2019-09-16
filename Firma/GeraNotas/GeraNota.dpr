program GeraNota;

uses
  Forms,
  uNota in 'uNota.pas' {fNota},
  uDtm_Notas in 'uDtm_Notas.pas' {Dtm_Notas: TDataModule},
  uDir in 'uDir.pas' {fDir};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfNota, fNota);
  Application.CreateForm(TDtm_Notas, Dtm_Notas);
  Application.CreateForm(TfDir, fDir);
  Application.Run;
end.
