program PF;

uses
  MidasLib,
  Forms,
  uPF in 'uPF.pas' {fPF},
  uDtm_PF in 'uDtm_PF.pas' {Dtm_PF: TDataModule},
  uDir in 'uDir.pas' {fDir},
  uFormConfGrupo in 'uFormConfGrupo.pas' {FormConfGrupo},
  Utils in '..\..\utils\Utils.pas',
  uFormLista in 'uFormLista.pas' {FormLista};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfPF, fPF);
  Application.CreateForm(TDtm_PF, Dtm_PF);
  Application.CreateForm(TfDir, fDir);
  Application.Run;
end.
