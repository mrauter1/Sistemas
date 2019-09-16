program DNF;

uses
  Forms,
  uDNF in 'uDNF.pas' {fDNF},
  uDtm_DNF in 'uDtm_DNF.pas' {Dtm_DNF: TDataModule},
  uDir in 'uDir.pas' {fDir};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfDNF, fDNF);
  Application.CreateForm(TDtm_DNF, Dtm_DNF);
  Application.CreateForm(TfDir, fDir);
  Application.Run;
end.
