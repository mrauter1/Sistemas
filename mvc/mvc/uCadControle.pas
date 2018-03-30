unit uCadControle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDadosControleBase, uCadModelo, DB, uMVCInterfaces, uDadosModeloBase,
  uConBase, uFormViewBase, uConexaoBase, uModeloBase;

type
  TCadControle = class;

  TModeloClass = class of TCadModelo;
  TViewClass = class of TFormViewBase;
  TConsultaClass = class of TfConBase;
//  TRelatorioClass = class of TFormRelBase;

  TConfiguraControle = procedure (Controle: TCadControle) of object;
  TConfiguraConsultaEvent = procedure (Consulta: TfConBase) of object;
  TConfiguraModeloEvent = procedure (Modelo: TCadModelo) of object;
  TConfiguraViewEvent = procedure (View: TFormViewBase) of object;
//  TConfiguraRelatorioEvent = procedure (Relatorio: TFormRelBase) of object;

  TCadControle = class(TDadosControleBase, ICadControle)
    procedure DataModuleCreate(Sender: TObject);
  private
    FOnConfiguraConsulta: TConfiguraConsultaEvent;
    FOnConfiguraModelo: TConfiguraModeloEvent;
    FOnConfiguraView: TConfiguraViewEvent;
//    FOnConfiguraRelatorio: TConfiguraRelatorioEvent;
    FModeloClass: TModeloClass;
    FViewClass: TViewClass;
    FConsultaClass: TConsultaClass;
//    FRelatorioClass: TRelatorioClass;
    FParametroAtual: Variant;
  protected
    procedure ConfiguraConsulta(FormConsulta: TfConBase); virtual;
    procedure ConfiguraModelo(Modelo: TCadModelo); virtual;
    procedure ConfiguraView(View: TFormViewBase); virtual;
//    procedure ConfiguraRelatorio(Relatorio: TFormRelBase); virtual;
    function Consulta: Variant; virtual;
    function Cadastro: variant; virtual;
    function AbreConsulta: Variant; virtual;
    procedure AbreView; virtual;
//    procedure AbreRelatorio; virtual;
    procedure CriaModelo(Conexao: TConexaoBase); virtual;

    function GetCadModelo: TCadModelo; virtual;
    property CadModelo: TCadModelo read GetCadModelo;
    property ModeloClass: TModeloClass read FModeloClass write FModeloClass;
    property ViewClass: TViewClass read FViewClass write FViewClass;
    property ConsultaClass: TConsultaClass read FConsultaClass write FConsultaClass;
//    property RelatorioClass: TRelatorioClass read FRelatorioClass write FRelatorioClass;

    //Parametro guarda o ultimo parametro passado para as funções carregarCad e AdicionarCad.
    property ParametroAtual: Variant read FParametroAtual write FParametroAtual;
  public
//    class function CriaRelatorio(Conexao: TConexaoBase; ConfiguraControle: TConfiguraControle = nil): variant;
    class function CriaConsulta(Conexao: TConexaoBase; ConfiguraControle: TConfiguraControle = nil): variant;
    class function CriaView(Conexao: TConexaoBase; ConfiguraControle: TConfiguraControle = nil): variant;
    procedure ConfiguraMVC(Conexao: TConexaoBase; ConfiguraControle: TConfiguraControle = nil);    
    function GetCadView: ICadView; virtual;
    function GetConView: IConView; virtual;
//    procedure SetCadView(Value: ICadView); virtual;
    property CadView: ICadView read GetCadView;
    property ConView: IConView read GetConView;
    function CarregarCad(ParamPK: variant): Boolean;
    function Localiza(KeyFields, KeyValues: Variant): Boolean;    
    function AdicionarCad(ParamPK: variant): Boolean;
    procedure SetFiltro(Filtro: String);

    property OnConfiguraConsulta: TConfiguraConsultaEvent read FOnConfiguraConsulta write FOnConfiguraConsulta;
    property OnConfiguraModelo: TConfiguraModeloEvent read FOnConfiguraModelo write FOnConfiguraModelo;
    property OnConfiguraView: TConfiguraViewEvent read FOnConfiguraView write FOnConfiguraView;
//    property OnConfiguraRelatorio: TConfiguraRelatorioEvent read FOnConfiguraRelatorio write FOnConfiguraRelatorio;
  end;

implementation

{$R *.dfm}

{ TCadControle }

procedure TCadControle.ConfiguraMVC(Conexao: TConexaoBase; ConfiguraControle: TConfiguraControle);
begin
  if Assigned(ConfiguraControle) then
    ConfiguraControle(Self);

  if Self.DadosModelo = nil then
    Self.CriaModelo(Conexao);
end;

class function TCadControle.CriaConsulta(Conexao: TConexaoBase; ConfiguraControle: TConfiguraControle = nil): variant;
var
  Controle: TCadControle;
begin
  Result:= Null;
  Controle:= Self.Create(nil);
  try
    Controle.ConfiguraMVC(Conexao, ConfiguraControle);

    Result:= Controle.AbreConsulta;
  finally
    Controle.Free;
  end;
end;

class function TCadControle.CriaView(Conexao: TConexaoBase; ConfiguraControle: TConfiguraControle = nil): variant;
var
  Controle: TCadControle;
begin
  Result:= Null;
  Controle:= Self.Create(nil);
  try
    Controle.ConfiguraMVC(Conexao, ConfiguraControle);

    Controle.AbreView;
  finally
    Controle.Free;
  end;
end;
              {
class function TCadControle.CriaRelatorio(Conexao: TConexaoBase; ConfiguraControle: TConfiguraControle = nil): variant;
var
  Controle: TCadControle;
begin
  Result:= Null;
  Controle:= Self.Create(nil);
  try
    Controle.ConfiguraMVC(Conexao, ConfiguraControle);

    Controle.AbreRelatorio;
  finally
    Controle.Free;
  end;
end;         }

procedure TCadControle.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FParametroAtual:= null;
end;

function TCadControle.Consulta: Variant;
begin
  if (CDS.State in ([dsEdit, dsInsert])) then Exit;
  Result:= Self.CriaConsulta(DadosModelo.Conexao);
end;

function TCadControle.Cadastro: variant;
begin
  if (CDS.State in ([dsEdit, dsInsert])) then Exit;
  Result:= Self.CriaView(DadosModelo.Conexao);
end;

function TCadControle.AbreConsulta: Variant;
var
  Consulta: TfConBase;
  Classe: TConsultaClass;
  tempAutoAddPK: Boolean;
begin
  if not VerificaPermissao(Consultar) then Exit;
  TempAutoAddPK:= CadModelo.AutoAddPKParam;
  CadModelo.AutoAddPKParam:= False;

  //Verifica se tem uma classe de consulta definida,
  //Se não houver cria consulta padrão!
  if Assigned(ConsultaClass) then
    Classe:= ConsultaClass
  else Classe:= tfConBase;

  Consulta:= Classe.Create(Self);
  try
    View:= Consulta;
    ConfiguraConsulta(Consulta);
    View.ShowModal;
    Result:= ConView.GetResultado;
  finally
    Consulta.Free;
    CadModelo.AutoAddPKParam:= TempAutoAddPK;
  end;
end;
{
procedure TCadControle.AbreRelatorio;
var
  Relatorio: TFormRelBase;
  Classe: TConsultaClass;
  tempAutoAddPK: Boolean;
begin
  if not VerificaPermissao(Consultar) then Exit;
  TempAutoAddPK:= CadModelo.AutoAddPKParam;
  CadModelo.AutoAddPKParam:= False;

  Relatorio:= RelatorioClass.Create(Self);
  try
    View:= Relatorio;
    ConfiguraRelatorio(Relatorio);
    View.ShowModal;
  finally
    Relatorio.Free;
    CadModelo.AutoAddPKParam:= TempAutoAddPK;
  end;
end;
 }
procedure TCadControle.ConfiguraConsulta(FormConsulta: TfConBase);
begin
  if Assigned(FOnConfiguraConsulta) then
    FOnConfiguraConsulta(FormConsulta);
end;

procedure TCadControle.ConfiguraModelo(Modelo: TCadModelo);
begin
  if Assigned(FOnConfiguraModelo) then
    FOnConfiguraModelo(Modelo);
end;

procedure TCadControle.ConfiguraView(View: TFormViewBase);
begin
  if Assigned(FOnConfiguraView) then
    FOnConfiguraView(View);
end;
                                          {
procedure TCadControle.ConfiguraRelatorio(Relatorio: TFormRelBase);
begin
  if Assigned(FOnConfiguraRelatorio) then
    FOnConfiguraRelatorio(Relatorio);
end;

                                           }
procedure TCadControle.AbreView;
var
  Classe: TViewClass;
  Cadastro: TFormViewBase;
begin
  if not VerificaPermissao(Consultar) then Exit;

  //Verifica se tem uma classe de consulta definida,
  //Se não houver cria exceção!
  if Assigned(ViewClass) then
    Classe:= ViewClass
  else raise Exception.Create('Não há classe de view definida: '+Self.ClassName);//Classe:= tViewBase;

  Cadastro:= Classe.Create(Self);
  try
    View:= Cadastro;
    ConfiguraView(Cadastro);
    CadView.ShowModal;
  finally
    FreeView;
  end;
end;

procedure TCadControle.CriaModelo(Conexao: TConexaoBase);
var
  Classe: TModeloClass;
begin
  if Assigned(ModeloClass) then
    Classe:= ModeloClass
  else raise Exception.Create('Não há classe de modelo definida!: '+Self.ClassName);
  
  DadosModelo:= Classe.Create(Self);
  DadosModelo.Conexao:= Conexao;
  ConfiguraModelo(CadModelo);
  CadModelo.CarregaVazio;
end;

function TCadControle.GetCadModelo: TCadModelo;
begin
  Result:= (Modelo as TCadModelo);
end;

function TCadControle.GetCadView: ICadView;
begin
  Result:= (View as ICadView);
end;

function TCadControle.GetConView: IConView;
begin
  Result:= (View as IConView);
end;

function TCadControle.AdicionarCad(ParamPK: variant): Boolean;
var
  Cancela: Boolean;
begin
  ParametroAtual:= ParamPK;
  DoBeforeInsere(Cancela);
  Result:= not Cancela;
  if Cancela then Exit;
  Result:= CadModelo.AdicionarCad(ParamPK);
end;

function TCadControle.CarregarCad(ParamPK: variant): Boolean;
var
  Cancela: Boolean;
begin
  ParametroAtual:= ParamPK;
  DoBeforeCarrega(Cancela);
  Result:= not Cancela;
  if Cancela then Exit;
  DesabilitaUpdatesView:= True;
  try
    Result:= CadModelo.CarregarCad(ParamPK);
  finally
    DesabilitaUpdatesView:= False;
  end;
end;

function TCadControle.Localiza(KeyFields, KeyValues: Variant): Boolean;
begin
  if CDS.Active then
    Result:= CDS.Locate(KeyFields, KeyValues, [])
  else Result:= False;  
end;


procedure TCadControle.SetFiltro(Filtro: String);
begin
  ChecaModelo;
  CadModelo.FiltroAdicional:= Filtro;
end;

end.
