program pTester;

uses
  Vcl.Forms,
  uThreads in 'uThreads.pas',
  unit1 in 'unit1.pas' {Form1},
  UntProxy in 'UntProxy.pas',
  uTestProxy in 'uTestProxy.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
