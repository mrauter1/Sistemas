unit uDtm_Anp;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, FMTBcd, DBClient, Provider, Dialogs;

type
  TDtm_Anp = class(TDataModule)
    Connnection: TSQLConnection;
    SQL_MovCli: TSQLQuery;
    DS_MovCli: TDataSource;
    Dts_MovCli: TDataSetProvider;
    Cds_MovCli: TClientDataSet;
    SQL_MovFor: TSQLQuery;
    DS_MovFor: TDataSource;
    Dts_MovFor: TDataSetProvider;
    CDS_MovFor: TClientDataSet;
    CDS_MovForCHAVENF: TStringField;
    SQL: TSQLQuery;
    CDS_MovForNUMERO: TStringField;
    CDS_MovForSERIE: TStringField;
    Cds_MovCliCHAVENF: TStringField;
    Cds_MovCliNUMERO: TStringField;
    Cds_MovCliSERIE: TStringField;
    Cds_MovCliCODCLIENTE: TStringField;
    CDS_MovForCODFORNECEDOR: TStringField;
    Cds_MovCliCODCOMPROVANTE: TStringField;
    Aux: TSQLQuery;
    Cds_MovCliDATADOCUMENTO: TDateField;
    CDS_MovForDATAENTRADA: TDateField;
    Mov: TSQLQuery;
    CDS_MovForCODPRODUTO: TStringField;
    CDS_MovForQUANT: TFMTBCDField;
    Cds_MovCliCODPRODUTO: TStringField;
    Cds_MovCliQUANTATENDIDA: TFMTBCDField;
    procedure DataModuleCreate(Sender: TObject);
    procedure Filtra(DataIni, DataFim: TDateTime);    
    function GetProVol(Codigo: String; Quant: Real): Double;
    function GetProPeso(Codigo: String; Quant: Real): Double;
    function GetProGrupo(Codigo: String): String;    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dtm_Anp: TDtm_Anp;

implementation

{$R *.dfm}

function TDTM_ANP.GetProVol(Codigo: String; Quant: Real): Double;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select cubagem, unidadeEstoque from Produto');
  Aux.Sql.Add('where CodProduto =:Cod');

  Aux.parambyname('Cod').AsString := Codigo;

  Aux.Open;

  Result:= (Quant/Aux.FieldByName('UnidadeEstoque').AsInteger)*Aux.FieldByName('cubagem').AsFloat*1000;
end;

function TDTM_ANP.GetProGrupo(Codigo: String): String;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select CodGrupoSub from Produto');
  Aux.Sql.Add('where CodProduto =:Cod');

  Aux.parambyname('Cod').AsString := Codigo;

  Aux.Open;

  Result:= Aux.FieldByName('CodGrupoSub').AsString;
end;

function TDTM_ANP.GetProPeso(Codigo: String; Quant: Real): Double;
begin
  Aux.Close;

  Aux.Sql.Clear;

  Aux.Sql.Add('Select Peso, unidadeEstoque from Produto');
  Aux.Sql.Add('where CodProduto =:Cod');

  Aux.parambyname('Cod').AsString := Codigo;

  Aux.Open;

  Result:= (Quant/Aux.FieldByName('UnidadeEstoque').AsInteger)*Aux.FieldByName('peso').AsFloat;
end;

procedure TDtm_Anp.Filtra(DataIni, DataFim: TDateTime);
begin
  CDS_MovCli.Close;

  Sql_MovCli.SQL.Clear;


// Sql_MovCli.Sql.Add('select MC.ChaveNF, MC.DataDocumento, MC.Numero, MC.Serie, MCPro.ChaveNFPro, MCPro.CodProduto, MCPro.QuantAtendida from '+
//'MCli MC, MCliPro MCPro where MC.DataDocumento between :DataIni and :DataFim and (MC.CodComprovante=:Vendas or MC.CodCOmprovante=:VendaTerc) and MCPro.ChaveNF = MC.ChaveNF order by MC.DataDocumento');
  Sql_MovCli.Sql.Add('select MC.ChaveNF, MC.DataDocumento, MC.Numero, MC.Serie, MC.CodCliente, MC.CodComprovante, ' +
                   'MCPro.CodProduto, MCPro.QuantAtendida '  +
                   'from MCli MC, MCliPro MCPro, Produto Pro ' +
                   'where MC.DataDocumento between :DataIni and :DataFim '+
                   'and (MC.CodComprovante=:Vendas or MC.CodCOmprovante=:VendaTerc or MC.CodComprovante=:Transf) '+
                   'and MCPro.ChaveNF = MC.ChaveNF '+
                   'and (Pro.CodGrupoSub =:TOL or Pro.CodGrupoSub =:XIL or ' +
                   'Pro.CodGrupoSub =:QUER or Pro.CodGrupoSub =:AG or Pro.CodGrupoSub =:AB9 or Pro.CodGrupoSub =:SOLVC6 or '+
                   'Pro.CodGrupoSub =:RAF) and MCPro.CodProduto = Pro.CodProduto and MC.ChaveNF = MCPro.ChaveNF '+
                   'order by MC.DataDocumento, MC.ChaveNF, MCPro.CodProduto');

  SQL_MovCli.ParamByName('Vendas').AsString:= '001';
  SQL_MovCli.ParamByName('VendaTerc').AsString:= '035';
  SQL_MovCli.ParamByName('Transf').AsString:= '042';

  SQL_MovCli.ParamByName('Tol').AsString:= '0010026';
  SQL_MovCli.ParamByName('XIL').AsString:= '0010027';
  SQL_MovCli.ParamByName('QUER').AsString:= '0010023';
  SQL_MovCli.ParamByName('AG').AsString:= '0010015';
  SQL_MovCli.ParamByName('AB9').AsString:= '0010028';
  SQL_MovCli.ParamByName('RAF').AsString:= '0010024';
  SQL_MovCli.ParamByName('SolvC6').AsString:= '0010029';

  Sql_MovCli.ParamByName('DataIni').AsDate:= DataIni;
  Sql_MovCli.ParamByName('DataFim').AsDate:= DataFim;

  CDS_MovCli.Open;

//  showmessage(sql_MovCli.FieldByName('ChaveNF').AsString);

  CDS_MovFor.Close;

  Sql_MovFor.SQL.Clear;

  Sql_MovFor.Sql.Add('select MF.ChaveNF, MF.DataEntrada, MF.Numero, MF.Serie, MF.CodFornecedor, ' +
                   'MFPro.CodProduto, MFPro.Quant '  +
                   'from MFor MF, MForPro MFPro, Produto Pro ' +
                   'where MF.DataEntrada between :DataIni and :DataFim '+
                   'and MF.CodComprovante=:Compras '+
                   'and MFPro.ChaveNF = MF.ChaveNF ' +
                   'and (Pro.CodGrupoSub =:TOL or Pro.CodGrupoSub =:XIL or ' +
                   'Pro.CodGrupoSub =:QUER or Pro.CodGrupoSub =:AG or Pro.CodGrupoSub =:AB9 or Pro.CodGrupoSub =:SOLVC6 or '+
                   'Pro.CodGrupoSub =:RAF) and MFPro.CodProduto = Pro.CodProduto '+
                   'and MF.ChaveNF = MFPro.ChaveNF '+
                   'order by MF.DataEntrada, MF.ChaveNF, MFPro.CodProduto ');

  SQL_MovFor.ParamByName('Compras').AsString:= '010';

  SQL_MovfOR.ParamByName('Tol').AsString:= '0010026';
  SQL_MovFor.ParamByName('XIL').AsString:= '0010027';
  SQL_MovFor.ParamByName('QUER').AsString:= '0010023';
  SQL_MovFor.ParamByName('AG').AsString:= '0010015';
  SQL_MovFor.ParamByName('AB9').AsString:= '0010028';
  SQL_MovFor.ParamByName('RAF').AsString:= '0010024';
  SQL_MovFor.ParamByName('SolvC6').AsString:= '0010029';

  Sql_MovFor.ParamByName('DataIni').AsDate:= DataIni;
  Sql_MovFor.ParamByName('DataFim').AsDate:= DataFim;

  CDS_MovFor.Open;
end;

procedure TDtm_Anp.DataModuleCreate(Sender: TObject);
begin
  Connnection.Open;
  CDS_MovCli.Open;
  SQL_MovCli.Open;
  CDS_MovFor.Open;
end;

end.
