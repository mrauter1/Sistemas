program PF;

uses
  Forms,
  uPF in 'uPF.pas' {fPF},
  uDtm_PF in 'uDtm_PF.pas' {Dtm_PF: TDataModule},
  uDir in 'uDir.pas' {fDir};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfPF, fPF);
  Application.CreateForm(TDtm_PF, Dtm_PF);
  Application.CreateForm(TfDir, fDir);
  Application.Run;
end.
