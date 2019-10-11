unit uPython;

interface

uses
  WinApi.Windows, WinApi.ShellAPI, SysUtils;

type
  TPythonExec = class(TObject)
     procedure Executar;
  end;

const
  cPython = 'C:\ProgramData\Anaconda3\python.exe';

implementation

{ TPythonExec }

procedure TPythonExec.Executar;
begin
   ShellExecute(0, 'open', cPython, 'Quickstart.py', 'F:\Sistemas.new\ListaPrecos', SW_SHOW);
end;

end.
