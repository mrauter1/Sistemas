unit uPedidos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  cxLookAndFeelPainters, cxGraphics, dxSkinsCore, cxClasses, dxAlertWindow,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uConSqlServer, uGerenciadorConfig;

type
  TPedidos = class(TDataModule)
    dxAlert: TdxAlertWindowManager;
    dxAlertFalta: TdxAlertWindowManager;
    QryPedidos: TFDQuery;
    QryPedidosCODPEDIDO: TStringField;
    QryPedidosCODPRODUTO: TStringField;
    QryPedidosNOMEPRODUTO: TStringField;
    QryPedidosDIASPARAENTREGA: TIntegerField;
    QryPedidosSIT: TStringField;
    QryPedidosCODCLIENTE: TStringField;
    QryPedidosNOMECLIENTE: TStringField;
    QryPedidosCODTRANSPORTE: TStringField;
    QryPedidosNOMETRANSPORTE: TStringField;
    QryPedidosEMFALTA: TBooleanField;
    QryPedidosFALTAAMANHA: TFMTBCDField;
    QryPedidosQUANTIDADE: TBCDField;
    QryPedidosFALTAHOJE: TFMTBCDField;
    QryPedidosEstoqueAtual: TBCDField;
    QryPedidosQUANTPENDENTE: TBCDField;
    QryPedidosSITUACAO: TStringField;
    TblPedidosCache: TFDMemTable;
    TblPedidosCacheCODPEDIDO: TStringField;
    TblPedidosCacheCODPRODUTO: TStringField;
    TblPedidosCacheEMFALTA: TBooleanField;
    QryPedidosDataEntrega: TDateField;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure VerificaNovosPedidos;
    procedure ShowAlertPedidoEmFalta;
    function GetTextoPedidoAlert: String;
    procedure ShowAlertNovoPedido;
    function GetStringDia: String;
//    function GetSql(pDataInicial, pDataFinal: TDateTime): String;
//    function ProdutoEmFalta(pCodProduto: String): Boolean;

    { Private declarations }
  public
//    procedure LoadPedidos(pDataInicial, pDataFinal: TDateTime);
//    procedure Filtra(const pFiltro: String);
    procedure LoadPedidosNew;
    procedure Refresh;
  end;

var
  Pedidos: TPedidos;

implementation

uses
  uConFirebird, Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TPedidos }

procedure TPedidos.DataModuleCreate(Sender: TObject);
begin
//  Self.LoadPedidos(Now - 30, Now + 1);
  TblPedidosCache.CreateDataSet;

  Self.LoadPedidosNew;
end;

function TPedidos.GetTextoPedidoAlert: String;
begin
  Result:=  'Pedido: '+ QryPedidos.FieldByName('CODPEDIDO').AsString
            + ' - ' + QryPedidos.FieldByName('NOMECLIENTE').AsString
            + sLineBreak
            +'Produto: '+QryPedidos.FieldByName('CODPRODUTO').AsString
            +' - '+QryPedidos.FieldByName('NOMEPRODUTO').AsString
            + sLineBreak
            +'Quantidade: '+QryPedidosQUANTIDADE.DisplayText
            + sLineBreak
            +'Estoque atual: '+QryPedidosEstoqueAtual.DisplayText
            +sLineBreak
            +'Transportadora: '+ QryPedidos.FieldByName('NOMETRANSPORTE').AsString;

end;

function TPedidos.GetStringDia: String;
begin
  if QryPedidosDIASPARAENTREGA.AsInteger <= 0 then
    Result:= 'hoje!'
  else if QryPedidosDIASPARAENTREGA.AsInteger = 1 then
    Result:= 'Amanhã'
  else
    Result:= FormatDateTime('dd/mm', QryPedidosDataEntrega.AsDateTime);
end;

procedure TPedidos.ShowAlertPedidoEmFalta;
begin
  dxAlertFalta.Show('Falta '+GetStringDia+'!',
                GetTextoPedidoAlert);
end;

procedure TPedidos.ShowAlertNovoPedido;
begin
  dxAlert.Show('Novo Ped. '+GetStringDia,
                GetTextoPedidoAlert);
end;

procedure TPedidos.VerificaNovosPedidos;
begin
  if not (puGerenteProducao in GerenciadorConfig.GruposUsuario) then
    Exit;

  QryPedidos.DisableControls;
  try
    QryPedidos.First;

    while not QryPedidos.Eof do
    begin
      if TblPedidosCache.Locate('CODPEDIDO;CODPRODUTO',
                                VarArrayOf([QryPedidosCODPEDIDO.AsString,QryPedidosCODPRODUTO.AsString]),
                                []) then
      begin
        if (QryPedidosEMFALTA.AsBoolean) and (TblPedidosCacheEMFALTA.AsBoolean = False) then
           ShowAlertPedidoEmFalta;

      end
     else
      begin
        if (QryPedidosEMFALTA.AsBoolean) then
          ShowAlertPedidoEmFalta
        else
          ShowAlertNovoPedido;
      end;

      QryPedidos.Next;
    end;

    TblPedidosCache.EmptyDataSet;
    TblPedidosCache.CopyDataSet(QryPedidos, [coRestart, coAppend]);
  finally
    QryPedidos.EnableControls;
  end;
end;

procedure TPedidos.LoadPedidosNew;
begin
  QryPedidos.DisableControls;
  try
    if QryPedidos.Active then
      QryPedidos.Close;

    QryPedidos.Open;

    VerificaNovosPedidos;
  finally
    QryPedidos.EnableControls;
  end;
end;

procedure TPedidos.Refresh;
begin
//  LoadPedidos(Now-30, Now+1);
  Self.LoadPedidosNew;
end;

end.
