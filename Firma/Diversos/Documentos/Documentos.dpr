program Documentos;

uses
  Forms,
  uForm1 in 'uForm1.pas' {Form1},
  uDataModule1 in 'uDataModule1.pas' {DataModule1: TDataModule},
  uQOrcamento in 'uQOrcamento.pas' {qOrcamento};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TqOrcamento, qOrcamento);
  Application.Run;
end.
