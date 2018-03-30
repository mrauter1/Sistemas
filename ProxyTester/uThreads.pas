﻿unit uThreads;

interface

uses Classes, Sockets, StdCtrls, Forms, Windows, UntProxy;

type
  TPortScanner = class(TThread)
  private
    FPorta: string;
    FHost: string;
    FProxy: String;
    FMemo: TMemo;
    FSincronizado: Boolean;
    procedure Testar;
  protected
    procedure Execute; override;
  public
    constructor Create(
      host: string;
      porta: string;
      memo: TMemo;
      sincronizado: Boolean;
      Proxy: String);
  end;

procedure TestConnection(FHost, FPorta: String; FMemo: TMemo);

implementation

uses SysUtils, SyncObjs, Unit1;
var
  FLock: TRTLCriticalSection;
{ TPortScanner }
constructor TPortScanner.Create(
      host: string;
      porta: string;
      memo: TMemo;
      sincronizado: Boolean;
      Proxy: String);
begin
  inherited Create(True);
  FHost := host;   //ip onde vamos nos conectar
  FPorta := porta; //porta na qual vamos nos conectar
  FMemo := memo; //um instância de um memo para que seja adicionado o numero da porta
  FProxy:= Proxy;
  FSincronizado := sincronizado;   //define se o metodo "testar" será executado sincronizado
  FreeOnTerminate := True; // Libera o objeto após terminar.
  Priority := tpTimeCritical; { Configura sua prioridade na lista de processos do Sistema operacional. }
  Resume; // Inicia o Thread.
end;

procedure TPortScanner.Execute;
begin
  inherited;
    //Aqui podemos definir, conforme os parâmetros do constructor, se o método
    //testar vai ser executado sincronizado ou não
    if FSincronizado then
      Synchronize(Testar)
    else
      Testar;
end;

procedure TPortScanner.Testar;
var
  bCon: Boolean;
  vClient: TTcpClient;
begin
  bcon := false;
  //conexão por TidTcpClient
  {
    pode ser chato debugar a aplicação com o TidTcpClient porque ele
    dispara uma exception qando ocorre um timeout
    Outro motivo por eu não usar nesse programa o idTcpClient é que ele
    possui um memory leak no Delphi 7. O FastMM4 acusa uma critical section em aberto
  }
  {
  with TIdTCPClient.Create(nil) do
  try
      try
        Host := FHost;
        Port := StrToInt(FPorta);
        //primeiro eu executo Connect e depois verifico se está conectado
        Connect(1000);  //um timeout de 1000 ms ou 1 s
        bCon := Connected;
      except
      end;
  finally
      if  bCon then
      begin
        Disconnect;
        try
          EnterCriticalSection(FLock);
          FMemo.Lines.Add(FPorta);
        finally
          LeaveCriticalSection(FLock);
        end;
      end;
      Free;
  end;
  }
  //conexão por TTCPClient
    if FProxy <> '' then
      SetInternalProxy(FProxy);

    vClient:= TTcpClient.Create(nil);
    with vClient do
    try
      try
        RemoteHost := FHost;
        RemotePort := FPorta;

        Connect;
        bCon := Connected;
      except
        on E: Exception do
        try
          EnterCriticalSection(FLock);
          FMemo.Lines.Add(FPorta+' '+e.Message);
        finally
          LeaveCriticalSection(FLock);
        end;
      end;
    finally
      if  bCon then
      begin
        Disconnect;
        try
          EnterCriticalSection(FLock);
          FMemo.Lines.Add(FPorta);
        finally
          LeaveCriticalSection(FLock);
        end;
      end;
      Free;
    end;
end;

procedure TestConnection(FHost, FPorta: String; FMemo: TMemo);
var
  bCon: Boolean;
  vClient: TTcpClient;
begin
  vClient:= TTcpClient.Create(nil);
  with vClient do
  try
    try
      RemoteHost := FHost;
      RemotePort := FPorta;

      Connect;
      bCon := Connected;
    except
      on E: Exception do
      try
        EnterCriticalSection(FLock);
        FMemo.Lines.Add(FPorta+' '+e.Message);
      finally
        LeaveCriticalSection(FLock);
      end;
    end;
  finally
    if  bCon then
    begin
      Disconnect;
      try
        EnterCriticalSection(FLock);
        FMemo.Lines.Add(FPorta);
      finally
        LeaveCriticalSection(FLock);
      end;
    end;
    Free;
  end;
end;


initialization
  InitializeCriticalSection(FLock);
finalization
  DeleteCriticalSection(FLock);
end.