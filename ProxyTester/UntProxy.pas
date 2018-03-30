unit UntProxy;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, SHDocVw, WinInet, MSHtml;

type
  INTERNET_PER_CONN_OPTION = record
    dwOption: DWORD;
    Value: record
              case Integer of
                 1: (dwValue: DWORD);
                 2: (pszValue: {$IFDEF DELPHI2009_UP}PWideChar{$ELSE}PAnsiChar{$ENDIF});
                 3: (ftValue: TFileTime);
          end;
  end;

  LPINTERNET_PER_CONN_OPTION = ^INTERNET_PER_CONN_OPTION;
  INTERNET_PER_CONN_OPTION_LIST = record
    dwSize: DWORD;
    pszConnection: LPTSTR;
    dwOptionCount: DWORD;
    dwOptionError: DWORD;
    pOptions: LPINTERNET_PER_CONN_OPTION;
  end;
  LPINTERNET_PER_CONN_OPTION_LIST = ^INTERNET_PER_CONN_OPTION_LIST;

procedure DeleteIECache;
function SetInternalProxy(Server: String): Boolean;

implementation


procedure DeleteIECache;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin
   dwEntrySize := 0;

   FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);

   GetMem(lpEntryInfo, dwEntrySize);

   if dwEntrySize>0 then
     lpEntryInfo^.dwStructSize := dwEntrySize;

   hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);

   if hCacheDir<>0 then
   begin
     repeat
       DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
       FreeMem(lpEntryInfo, dwEntrySize);
       dwEntrySize := 0;
       FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
       GetMem(lpEntryInfo, dwEntrySize);
       if dwEntrySize>0 then
         lpEntryInfo^.dwStructSize := dwEntrySize;
     until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize)
   end;
   FreeMem(lpEntryInfo, dwEntrySize);

   FindCloseUrlCache(hCacheDir)
end;


{$DEFINE DELPHI2009_UP}
function SetInternalProxy(Server: String): Boolean;
// Server z.B. '127.0.0.1:8080' oder ''
const
  cAgent_Str = 'Mozilla/4.0 (compatible; MSIE 7.0b; Windows NT 6.0)';
  INTERNET_PER_CONN_FLAGS = 1;
  INTERNET_PER_CONN_PROXY_SERVER = 2;
  INTERNET_PER_CONN_PROXY_BYPASS = 3;
  INTERNET_PER_CONN_AUTOCONFIG_URL = 4;
  INTERNET_PER_CONN_AUTODISCOVERY_FLAGS = 5;
  PROXY_TYPE_DIRECT = $00000001;
  PROXY_TYPE_PROXY = $00000002;
  PROXY_TYPE_AUTO_PROXY_URL = $00000004;
  PROXY_TYPE_AUTO_DETECT = $00000008;
  INTERNET_OPTION_REFRESH = 37;
  INTERNET_OPTION_PER_CONNECTION_OPTION = 75;
  INTERNET_OPTION_SETTINGS_CHANGED = 39;

var
  OptionsList: INTERNET_PER_CONN_OPTION_LIST;
  BufSize: DWORD;
  HInternet: Pointer;
  Agent: String;

begin
  Result := False;
  BufSize := SizeOf(OptionsList);
  OptionsList.dwSize := BufSize;
  OptionsList.pszConnection := nil; // nil -> LAN, caso contrario especifique
  OptionsList.dwOptionCount := 3; // 3 Opções de Proxy, caso um não funcionar utiliza outro;
  OptionsList.pOptions := AllocMem(3 * SizeOf(INTERNET_PER_CONN_OPTION));
  try
    if not Assigned(OptionsList.pOptions) then
      EXIT;
    OptionsList.pOptions^.dwOption := INTERNET_PER_CONN_FLAGS;
    OptionsList.pOptions^.Value.dwValue := PROXY_TYPE_DIRECT or
      PROXY_TYPE_PROXY;
    inc(OptionsList.pOptions);
    OptionsList.pOptions^.dwOption := INTERNET_PER_CONN_PROXY_SERVER;
    OptionsList.pOptions^.Value.pszValue := PAnsiChar(Server);
    inc(OptionsList.pOptions);
    OptionsList.pOptions^.dwOption := INTERNET_PER_CONN_PROXY_BYPASS;
    OptionsList.pOptions^.Value.pszValue := 'local';
    dec(OptionsList.pOptions, 2);
    Agent := cAgent_Str;
    HInternet := InternetOpen
      ({$IFDEF DELPHI2009_UP}PWideChar{$ELSE}PAnsiChar{$ENDIF}
      (Agent), INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
    try // Setar Opções
      Result := InternetSetOption(HInternet,
        INTERNET_OPTION_PER_CONNECTION_OPTION, @OptionsList, BufSize);
      InternetSetOption(HInternet, INTERNET_OPTION_REFRESH, nil, 0);
    finally
      InternetCloseHandle(HInternet);
    end;
  finally
    FreeMem(OptionsList.pOptions); // Libera memória
  end;
end;


end.
