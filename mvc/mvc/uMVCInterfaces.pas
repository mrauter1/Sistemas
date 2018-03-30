unit uMVCInterfaces;

interface

uses DB, DBClient, SysUtils;

//OBS: Interfaces precisa de GUID para utilizar o operador as
// ctrl + Shift + G para gerar uma GUID

type
  EInformaErro = class (Exception);

  TViewEstado = (vAtivo, vInativo, vInserindo, vEditando);
  TPermissao = (Inserir, Editar, Excluir, Consultar);
  TPermissoes = set of TPermissao;

  TTipoConexao = (IBO, DBX, ArqXML);

  IConexaoBase = interface (IInterface)
  ['{C19BFBF1-0F56-4431-A7C4-01BC68FF1772}']
    function Salvar: Boolean;
    function Carregar: Boolean;
  end;

  //Interface para a gravação do CDS do modelo para arquivo (xml ou binario)
  IConexaoArquivo = interface (IConexaoBase)
  ['{34617C4F-81AF-48AF-8E78-FBDDFAF2A404}']
    procedure SetArquivo(Value: String);
    function GetArquivo: String;
    procedure SetFormato(Value: TDataPacketFormat);
    function GetFormato: TDataPacketFormat;
    property Arquivo: String read GetArquivo write SetArquivo;
    property Formato: TDataPacketFormat read GetFormato write SetFormato;
  end;

  //Interface base para a classe de controle
  IControleBase = interface (IInterface)
  ['{BB1166B2-AA3F-46F6-8E4B-2A5392A40725}']
  end;

  //Interface para o controle de um formulario com registros
  //A view faz chamadas para cada
  //ação que interfere no modelo (TDadosModeloBase)
  IDadosControleBase = interface (IControleBase)
  ['{A4714E9D-EB84-41A9-B3D8-204CDD84DDA2}']
    function GetDataSource: TDataSource;
    function GetPermissoes: TPermissoes;
    function PodeNavegar: Boolean;
    function IsEmpty: Boolean;
    function Salvar: Boolean;
    function Carregar: Boolean;
    function BtnAddClick: Boolean;
    function BtnEditClick: Boolean;
    function BtnDeletClick: Boolean;
    function BtnCancelClick: Boolean;
    function BtnConfirmClick: Boolean;
    function BtnNovoClick: Boolean;
  end;

  ICadControle = interface (IDadosControleBase)
  ['{19FB65AB-8916-4A0D-9AE9-8D89B174D70E}']
    function Localiza(KeyFields, KeyValues: Variant): Boolean;      
    function CarregarCad(ParamPK: variant): Boolean;
    function AdicionarCad(ParamPK: variant): Boolean;
    procedure SetFiltro(Filtro: String);
    function Consulta: Variant;
  end;

  //Interface para a view
  //A view é obrigada a implementar esta interface para receber updates de TControleBase
  IView = interface (IInterface)
  ['{47879815-F5D2-4560-9E04-D742B93C7A2E}']
    function ShowModal: Integer;
    procedure MostraMensagem(Mensagem: String);
    procedure SetControle(Value: IControleBase);
    function GetControle: IControleBase;
    property Controle: IControleBase read GetControle write SetControle;
    procedure vFree(var InterfaceRef);
  end;

  //Interface para conectar com o controle que tem registros
  IDadosView = interface (IView)
  ['{D63997F8-69DA-438D-B9A4-F675CB35502F}']
    function GetEstado: TViewEstado;
    procedure SetEstado(Value: TViewEstado);
    property Estado: TViewEstado read GetEstado write SetEstado;
    procedure DataChange;
  end;

  ICadView = interface (IDadosView)
  ['{09350A70-B4C5-4173-AD43-60738CC8B856}']

  end;

  IConView = interface (IView)
  ['{D12F7A2B-3703-445D-99A3-FA0FFA560A5B}']
    function GetResultado: Variant;
  end;

implementation

end.
