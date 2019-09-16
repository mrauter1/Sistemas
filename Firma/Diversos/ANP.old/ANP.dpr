program ANP;

uses
  Forms,
  uAnp in 'uAnp.pas' {fAnp},
  uDtm_Anp in 'uDtm_Anp.pas' {Dtm_Anp: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfAnp, fAnp);
  Application.CreateForm(TDtm_Anp, Dtm_Anp);
  Application.Run;
end.
