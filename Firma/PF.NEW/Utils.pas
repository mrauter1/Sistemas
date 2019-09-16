unit Utils;

interface

procedure WriteLog(Par_Arquivo: String; Par_Texto: String);

implementation

uses
  SysUtils;

procedure WriteLog(Par_Arquivo: String; Par_Texto: String);
var
  F: TextFile;
begin
  AssignFile(F, Par_Arquivo);
  if FileExists(Par_Arquivo) then
   Append(F)
  else
    ReWrite(F);

  WriteLn(F, FormatDateTime('ddmmyyyy-hh:mm:ss', Now)+' -> '+Par_Texto);

  CloseFile(F);
end;

end.
