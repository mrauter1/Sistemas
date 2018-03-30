unit UntConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, XMLIntf, XmlDoc;

type
  ProxyType = (Https, Socks5, Socks4, SSH, Http);

  TProxy = record
    Nome: String[255];
    IP: String[255];
    Porta: Integer;
    Tipo: ProxyType;
  end;


  TForm1 = class(TForm)
    BtnLer: TButton;
    Memo1: TMemo;
    BtnSalvar: TButton;
    MemoProxys: TMemo;
    procedure BtnLerClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FBytesBefore, FBytesAfter: TBytes;
    ProxyArray: array of TProxy;
    function ReadString: String;
    function ReadInteger: Integer;
    function ReadProxyConfig: TProxy;
    function getProxyTypeAsStr(pType: ProxyType): String;
    procedure ParseConfig;
    procedure WriteProxyConfig(FPrx: TProxy);
    procedure WriteStr(pStr: String);
    procedure WriteInt(pInt: Integer);
    procedure SalvarConfig;
    procedure AddProxyToArray(pPrx: TProxy);
    function ReadBytes(pSize: Integer): TBytes;
    procedure WriteBytes(pBytes: TBytes);
    procedure GetProxysFromMemo;
    procedure ProxysToXml;
    { Private declarations }
  public
      FileStream: TFileStream;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;

function TForm1.ReadInteger: Integer;
begin
  FileStream.ReadBuffer(Result, SizeOf(Integer));
end;

function TForm1.ReadString: String;
var
  S: Integer;
  Bytes: TBytes;
begin
  S:= ReadInteger*2;

  SetLength(Bytes, S);
  FileStream.Read(Bytes[0], S);
  Result:= TEncoding.Unicode.GetString(Bytes);

//  FileStream.Read(Pointer(Result)^, S);
end;

procedure TForm1.WriteBytes(pBytes: TBytes);
begin
  FileStream.WriteBuffer(pBytes[0], Length(pBytes));
end;

procedure TForm1.WriteInt(pInt: Integer);
begin
  FileStream.WriteBuffer(pInt, SizeOf(Integer));
end;

procedure TForm1.WriteStr(pStr: String);
var
  S: Integer;
  Bytes: TBytes;
begin
  WriteInt(Length(pStr));
  FileStream.Write(PChar(pStr)^, SizeOf(Char) * Length(pStr));
end;

function TForm1.ReadBytes(pSize: Integer): TBytes;
begin
  SetLength(Result, pSize);
  FileStream.Read(Result[0], pSize);
end;

procedure TForm1.WriteProxyConfig(FPrx: TProxy);
var
  I: Integer;
begin
  WriteStr(FPrx.Nome);
  WriteInt(Integer(FPrx.Tipo));
  WriteStr(FPrx.IP);
  WriteInt(FPrx.Porta);
  // Informações não necessárias;
  for I := 1 to 13 do
    WriteInt(0);
end;

function TForm1.ReadProxyConfig: TProxy;
begin
  Result.Nome:= ReadString;
  Result.Tipo:= ProxyType(ReadInteger);
  Result.IP:= ReadString;
  Result.Porta:= ReadInteger;
  // Informações não necessárias;
  FileStream.Position:= FileStream.Position+52;
end;

procedure TForm1.ProxysToXml;
const
  cPrxPerChain = 8;
Var
  XML : IXMLDOCUMENT;
  RootNode, ProxyNode, ProxysServers : IXMLNODE;
  I, cCount, TotalChains: Integer;

  procedure CreateProxyChains;
  var
    ProxyChains, ProxyChain, Prxs: IXMLNODE;
    I, F, CurProxy: Integer;
    TemHttp: Boolean;

  begin
    TemHttp:= False;
    cCount:= 0;
    ProxyChains := RootNode.AddChild('proxy_chains');
    TotalChains:=  ((Length(ProxyArray)-1) div cPrxPerChain)+1;
    for I := 0 to TotalChains-1 do
    begin
      ProxyChain:= ProxyChains.AddChild('proxy_chain');
      ProxyChain.Attributes['name']:= 'Chain '+IntToStr(I+1);
      for F := 0 to cPrxPerChain-1 do
      begin
        CurProxy:= F+(cPrxPerChain*I);

        if CurProxy > Length(ProxyArray)-1 then
          Break;

        if ProxyArray[CurProxy].Tipo <> Http then
        begin
          Prxs:= ProxyChain.AddChild('proxy_server');
          Prxs.Attributes['name']:= ProxyArray[CurProxy].Nome;
        end;
      end;

      // Proxys HTTP tem que ficar por último e só pode haver um
      for F := 0 to cPrxPerChain-1 do
        if ProxyArray[CurProxy].Tipo = Http then
        begin
          Prxs:= ProxyChain.AddChild('proxy_server');
          Prxs.Attributes['name']:= ProxyArray[CurProxy].Nome;
          Break;
        end;

    end;
  end;

  procedure CreateProxyRules;
  var
    RoutingRules, RoutingRule, FProgram, Prxs: IXMLNODE;
    I, F: Integer;

  begin
    cCount:= 0;
    RoutingRules := RootNode.AddChild('routing_rules');
    TotalChains:=  ((Length(ProxyArray)-1) div cPrxPerChain)+1;
    for I := 0 to TotalChains-1 do
    begin
      RoutingRule:= RoutingRules.AddChild('routing_rule');
      RoutingRule.Attributes['disabled']:= 'true';
      RoutingRule.Attributes['name']:= 'Rule '+IntToStr(I+1);
      RoutingRule.Attributes['transports']:= 'tcp';
      RoutingRule.Attributes['action']:= 'proxy';
      RoutingRule.Attributes['remote_dns']:= 'false';
      for F := 0 to cPrxPerChain-1 do
      begin
        if F+(cPrxPerChain*I) > Length(ProxyArray)-1 then
          Break;

        Prxs:= RoutingRule.AddChild('proxy_or_chain');
        Prxs.Attributes['name']:= ProxyArray[F+(cPrxPerChain*I)].Nome;
      end;

      FProgram:= RoutingRule.AddChild('programs').AddChild('program');
      FProgram.Attributes['path']:= 'C:\none.exe';
      FProgram.Attributes['dir_included']:= 'true';
    end;
  end;

begin
  XML := NewXMLDocument;
  XML.Encoding := 'utf-8';
  XML.Options := [doNodeAutoIndent]; // looks better in Editor ;)
  RootNode := XML.AddChild('proxycap_ruleset');
  RootNode.Attributes['version']:= '525';
  ProxysServers := RootNode.AddChild('proxy_servers');
  for I := 0 to Length(ProxyArray)-1 do
  begin
    ProxyNode := ProxysServers.AddChild('proxy_server');

    if I = 0 then
      ProxyNode.Attributes['is_default'] := 'true'
    else
      ProxyNode.Attributes['is_default'] := 'false';
    ProxyNode.Attributes['port'] := ProxyArray[I].Porta;
    ProxyNode.Attributes['auth_method'] := 'none';
    ProxyNode.Attributes['hostname'] := ProxyArray[I].IP;
    ProxyNode.Attributes['type'] := getProxyTypeAsStr(ProxyArray[i].Tipo);
    ProxyNode.Attributes['name'] := ProxyArray[I].Nome;
  end;

//  CreateProxyChains;
  CreateProxyRules;
  RootNode.AddChild('remote_dns_exceptions');
  XMl.SaveToFile(ExtractFilePath(Application.ExeName)+'\proxys.xml');
end;

procedure TForm1.GetProxysFromMemo;
var
  I: Integer;
  fProp: TStringList;
begin
  fProp:= TStringList.Create;
  try
    SetLength(ProxyArray, 0);
    for I := 0 to MemoProxys.Lines.Count-1 do
    begin
      Split(';', MemoProxys.Lines[I], fProp);
      SetLength(ProxyArray, I+1);
      ProxyArray[I].Ip:= fProp[0];
      ProxyArray[I].Porta:= StrToInt(fProp[1]);
      ProxyArray[I].Tipo:= ProxyType(StrToInt(fProp[2]));
      ProxyArray[I].Nome:= '('+IntToStr(I)+')'+fProp[0]+':'+fProp[1]+'-'+getProxyTypeAsStr(ProxyArray[I].Tipo);

    end;
  finally
    fProp.Free;
  end;
end;

procedure TForm1.BtnSalvarClick(Sender: TObject);
begin
{  if FileExists(ExtractFilePath(Application.ExeName)+'machine.prs') then
    ParseConfig
  else
    raise Exception.Create('Arquivo não encontrado!');}
//    FileStream:= TFileStream.Create(ExtractFilePath(Application.ExeName)+'machine.prs', fmCreate);

  GetProxysFromMemo;

{  FileStream:= TFileStream.Create(ExtractFilePath(Application.ExeName)+'machine.prs', fmOpenWrite);
  try
    SalvarConfig;
  finally
    FileStream.Free;
  end;         }

  ProxysToXml;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetLength(ProxyArray, 0);
end;

function TForm1.getProxyTypeAsStr(pType: ProxyType): String;
begin
  case pType of
    Https: Result:= 'https';
    Socks5: Result:= 'socks5';
    Socks4: Result:= 'socks4';
    SSH: Result:= 'ssh';
    Http: Result:= 'http';
  end;
end;

procedure TForm1.SalvarConfig;
var
  NumProxys: Integer;
  I: Integer;
  FProxy: TProxy;
begin
{  for I := 1 to 6 do
    WriteInt(0);}
  FileStream.Size:= 0;

  WriteBytes(FBytesBefore);

  WriteInt(Length(ProxyArray));
  for I := 0 to Length(ProxyArray)-1 do
  begin
    WriteProxyConfig(ProxyArray[I]);
  end;

  WriteBytes(FBytesAfter);
end;

procedure TForm1.AddProxyToArray(pPrx: TProxy);
begin
  SetLength(ProxyArray, Length(ProxyArray)+1);
  ProxyArray[Length(ProxyArray)-1]:= pPrx;
end;

procedure TForm1.ParseConfig;
var
  NumProxys: Integer;
  I: Integer;
  FProxy: TProxy;
begin
  SetLength(ProxyArray, 0);

  FileStream:= TFileStream.Create (ExtractFilePath(Application.ExeName)+'machine.prs', fmOpenRead);
  try
    Memo1.Lines.Clear;

    FileStream.Position:= 0;

    FBytesBefore:= ReadBytes(24);
  //  FileStream.Position:= 24;
    NumProxys:= ReadInteger;
    for I := 0 to NumProxys-1 do
    begin
      FProxy:= ReadProxyConfig;
      AddProxyToArray(FProxy);
      Memo1.Lines.Add(FProxy.Nome);
      Memo1.Lines.Add(FProxy.IP);
      Memo1.Lines.Add(IntToStr(FProxy.Porta));
      Memo1.Lines.Add(getProxyTypeAsStr(FProxy.Tipo));
    end;

    FBytesAfter:= ReadBytes(FileStream.Size - FileStream.Position);
  finally
    FileStream.Free;
  end;
end;

procedure TForm1.BtnLerClick(Sender: TObject);
begin

    ParseConfig;

end;

end.
