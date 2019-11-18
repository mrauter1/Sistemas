program PF;

uses
  MidasLib,
  Forms,
  uPF in 'uPF.pas' {fPF},
  uDir in 'uDir.pas' {fDir},
  Utils in '..\..\utils\Utils.pas',
  uFormLista in 'uFormLista.pas' {FormLista},
  uSecoes in 'uSecoes.pas',
  uDmConnection in '..\..\utils\uDmConnection.pas' {DmConnection: TDataModule},
  uFormConfGrupo in 'uFormConfGrupo.pas' {FormConfGrupo},
  uDtm_PF in 'uDtm_PF.pas' {Dtm_PF: TDataModule},
  uDmDados in 'uDmDados.pas' {DmDados: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDmDados, DmDados);
  Application.CreateForm(TDtm_PF, Dtm_PF);
  Application.CreateForm(TfPF, fPF);
  Application.CreateForm(TfDir, fDir);
  Application.Run;
end.
