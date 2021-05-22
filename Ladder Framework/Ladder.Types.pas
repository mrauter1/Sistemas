unit Ladder.Types;

interface

type
  TConnectionParams = record
    DriverID: String;
    Server: String;
    Protocol: String;
    Port: Integer;
    Database: String;
    User: String;
    Password: String;
  end;

implementation

end.
