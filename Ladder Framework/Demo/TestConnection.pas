unit TestConnection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SynOLEDB, Vcl.StdCtrls, Vcl.ExtCtrls, SynCommons, SynDB;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Props: TOleDBMSSQLConnectionProperties;
    procedure Iniciar;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.DateUtils;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Iniciar;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  MFor: variant;
  FText: String;
  FStart, FEnd: TDateTime;
  FRows: Variant;
  Count: Integer;
  FJSon: String;
begin
  Count:= 0;
//  FForm:= TForm1.Create(nil);
  FStart:= now;
  try
    FRows:= _Json(Props.Execute('select * from MFOR', []).FetchAllAsJSON(true));
//    Memo1.Lines.Add(FJSon);
  finally
    FEnd:= now;
    Memo2.Lines.Add('Time: '+IntToStr(MilliSecondsBetween(FStart, FEnd)));
    Memo1.Lines.Add('Count: '+IntToStr(FRows._Count));
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  MFor: variant;
  FText: String;
  FStart, FEnd: TDateTime;
begin
//  FForm:= TForm1.Create(nil);
  FStart:= now;
  try
    with Props.Execute('select * from MFOR', [],@MFOR) do
      while Step do
        FText:= Column['ChaveNF'];
  finally
    FEnd:= now;
    Memo2.Lines.Add('Time: '+IntToStr(MilliSecondsBetween(FStart, FEnd)));
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Props:= TOleDBMSSQL2012ConnectionProperties.Create('177.159.99.114,1433', 'logistec', 'user', '28021990');
end;

procedure TForm1.Iniciar;
var
  FForm: TForm1;
  MFor: variant;
  FStart, FEnd: TDateTime;
begin
//  FForm:= TForm1.Create(nil);
  FStart:= now;
  try
    with Props.Execute('select * from MFOR', [],@MFOR) do
      while Step do
        Memo1.Lines.Add(MFor.ChaveNF);
  finally
    FEnd:= now;
    Memo2.Lines.Add('Time: '+IntToStr(MilliSecondsBetween(FStart, FEnd)));
  end;
end;

end.
