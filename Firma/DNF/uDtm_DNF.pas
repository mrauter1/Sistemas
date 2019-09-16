unit uDtm_DNF;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DBClient, Provider, DB, SqlExpr, IniFiles, Forms;

type
  TDtm_DNF = class(TDataModule)
    Connnection: TSQLConnection;
    SQL_Filtro: TSQLQuery;
    Con_Filtro: TDataSource;
    DTS_Filtro: TDataSetProvider;
    CDS_Filtro: TClientDataSet;
    Dts_MCliPro: TDataSetProvider;
    CDS_MCliPro: TClientDataSet;
    SQL_MCliPro: TSQLQuery;
    Aux: TSQLQuery;
    procedure Filtra(OrderBy: String = '');
    procedure DataModuleCreate(Sender: TObject);
    procedure CDS_FiltroAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dtm_DNF: TDtm_DNF;
  Ini, Fim: TDateTime;

implementation

{$R *.dfm}

procedure TDtm_DNF.Filtra(OrderBy: String = '');
begin
  CDS_Filtro.Close;
  SQL_Filtro.SQL.Clear;
  SQL_Filtro.SQL.Add('Select Distinct(M.ChaveNF), M.Numero, M.Serie, M.DataDocumento, C.NomeCliente,');
  SQL_Filtro.SQL.Add('M.DataComprovante, C.CodCliente, C.NumeroCGCMF, C.NumeroCPF, M.CodPedido');
  SQL_Filtro.SQL.Add('from MCli M, MCliPro MP, Cliente C, Comprv');
  SQL_Filtro.SQL.Add('where (Comprv.CodComprovante =:Vendas or Comprv.CodComprovante =:Transf');
  SQL_Filtro.SQL.Add('or Comprv.CodComprovante =:VendaManual or Comprv.CodComprovante =:SimpRem or');
  SQL_Filtro.SQL.Add('Comprv.CodComprovante =:Amostra or Comprv.CodComprovante =:Comp or Comprv.CodComprovante =:Comp2) and');
  SQL_Filtro.SQL.Add('M.CodComprovante = Comprv.CodComprovante ');
  SQL_Filtro.SQL.Add('and M.ChaveNF = MP.ChaveNF');
  SQL_Filtro.SQL.Add('and M.DataDocumento between :Dataini and :DataFim and C.CodCliente = M.CodCliente');
  if OrderBy <> '' then
  SQL_Filtro.SQL.Add('order by ' +  OrderBy);

  SQL_Filtro.ParamByName('Vendas').AsString:= '001';
  SQL_Filtro.ParamByName('Comp2').AsString:= '002';
  SQL_Filtro.ParamByName('Comp').AsString:= '003';
  SQL_Filtro.ParamByName('VendaManual').AsString:= '005';
  SQL_Filtro.ParamByName('SimpRem').AsString:= '040';
  SQL_Filtro.ParamByName('Transf').AsString:= '042';
  SQL_Filtro.ParamByName('Amostra').AsString:= '045';
  SQL_Filtro.ParamByName('DataIni').AsDate:= Ini;
  SQL_Filtro.ParamByName('DataFim').AsDate:= Fim;
  CDS_Filtro.Open;
end;

procedure TDtm_DNF.DataModuleCreate(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      Connnection.Params.Values['Database'] :=
          ArqIni.ReadString('Banco', 'Dir', 'C:\Sidicom.new\Dados\Banco.gdb');
      ArqIni.Free;
    end
  else
    Connnection.Params.Values['Database']:= 'C:\Sidicom.new\Dados\Banco.gdb';

  Connnection.Open;
{  CDS_Filtro.Open;
  CDS_MCliPro.Open;}
end;

procedure TDtm_DNF.CDS_FiltroAfterScroll(DataSet: TDataSet);
begin
  CDS_MCliPro.Close;
  Sql_McliPro.ParamByName('CHAVENF').AsString:= Cds_Filtro.FieldByName('CHAVENF').AsString;
  CDS_MCliPro.Open;
end;

end.
