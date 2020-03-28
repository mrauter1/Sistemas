unit uFormEntregaPorProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxCalendar, Vcl.StdCtrls,
  Vcl.DBCtrls, System.Generics.Collections, cxCheckBox, Vcl.Buttons,
  Vcl.ComCtrls, cxGridExportLink, WinAPI.ShellAPI, uConFirebird;

type
  TFormEntregaPorProduto = class(TForm)
    PanelTop: TPanel;
    DsPedidos: TDataSource;
    Panel1: TPanel;
    cxGridPedidos: TcxGrid;
    ViewPedidos: TcxGridDBTableView;
    ViewPedidosCodGrupoSub: TcxGridDBColumn;
    cxGridPedidosLevel: TcxGridLevel;
    Panel3: TPanel;
    DsEstoquePrevisto: TDataSource;
    QryEstoquePrevisto: TFDQuery;
    QryEstoquePrevistoData: TDateField;
    QryEstoquePrevistoCodGrupoSub: TStringField;
    QryEstoquePrevistoNOMESUBGRUPO: TStringField;
    QryEstoquePrevistoEstoqueAtual: TFMTBCDField;
    QryEstoquePrevistoCompraPrevista2: TBCDField;
    QryEstoquePrevistoSomaCompras: TFMTBCDField;
    QryEstoquePrevistoPedidosDia: TFMTBCDField;
    QryEstoquePrevistoSomaPedidos: TFMTBCDField;
    QryEstoquePrevistoEstoquePrevisto: TFMTBCDField;
    PanelRight: TPanel;
    PanelTitulo: TPanel;
    PanelLeft: TPanel;
    Panel4: TPanel;
    cxGridDatas: TcxGrid;
    ViewEstoquePrevisto: TcxGridDBTableView;
    ViewEstoquePrevistoData: TcxGridDBColumn;
    ViewEstoquePrevistoCodGrupoSub: TcxGridDBColumn;
    ViewEstoquePrevistoNOMESUBGRUPO: TcxGridDBColumn;
    ViewEstoquePrevistoEstoqueAtual: TcxGridDBColumn;
    ViewEstoquePrevistoCompraPrevista: TcxGridDBColumn;
    ViewEstoquePrevistoSomaCompras: TcxGridDBColumn;
    ViewEstoquePrevistoPedidosDia: TcxGridDBColumn;
    ViewEstoquePrevistoSomaPedidos: TcxGridDBColumn;
    ViewEstoquePrevistoEstoquePrevisto: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridCompras: TcxGrid;
    ViewCompras: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    QryComprasPrevistas: TFDQuery;
    DateField1: TDateField;
    DsComprasPrevistas: TDataSource;
    QryComprasPrevistasCodGrupoSub: TStringField;
    QryComprasPrevistasCompraPrevista: TBCDField;
    ViewComprasData: TcxGridDBColumn;
    ViewComprasCodGrupoSub: TcxGridDBColumn;
    ViewComprasCompraPrevista: TcxGridDBColumn;
    PanelHeader: TPanel;
    DBTextGrupo: TDBText;
    PanelComandos: TPanel;
    Splitter1: TSplitter;
    QryPedidos: TFDQuery;
    QryPedidosCheck: TBooleanField;
    QryPedidosCodGrupoSub: TStringField;
    QryPedidosNOMESUBGRUPO: TStringField;
    QryPedidosCodPedido: TStringField;
    QryPedidosNOMECLIENTE: TStringField;
    QryPedidosCODTRANSPORTE: TStringField;
    QryPedidosNOMETRANSPORTE: TStringField;
    QryPedidosCODPRODUTO: TStringField;
    QryPedidosNOMEPRODUTO: TStringField;
    QryPedidosLitros: TFMTBCDField;
    QryPedidosPeso: TFMTBCDField;
    QryPedidosDataPedido: TDateField;
    QryPedidosSomaPedidos: TFMTBCDField;
    ViewPedidosNOMESUBGRUPO: TcxGridDBColumn;
    ViewPedidosCodPedido: TcxGridDBColumn;
    ViewPedidosNOMECLIENTE: TcxGridDBColumn;
    ViewPedidosCODTRANSPORTE: TcxGridDBColumn;
    ViewPedidosNOMETRANSPORTE: TcxGridDBColumn;
    ViewPedidosCODPRODUTO: TcxGridDBColumn;
    ViewPedidosNOMEPRODUTO: TcxGridDBColumn;
    ViewPedidosLitros: TcxGridDBColumn;
    ViewPedidosPeso: TcxGridDBColumn;
    ViewPedidosDataPedido: TcxGridDBColumn;
    ViewPedidosSomaPedidos: TcxGridDBColumn;
    ViewPedidosCheck: TcxGridDBColumn;
    DatePicker: TDateTimePicker;
    Label1: TLabel;
    BtnAlterarData: TBitBtn;
    DsPedidosProgramados: TDataSource;
    QryPedidosProgramados: TFDQuery;
    QryPedidosProgramadosCodPedido: TStringField;
    QryPedidosProgramadosCodProduto: TStringField;
    QryPedidosProgramadosQuantidade: TBCDField;
    QryPedidosProgramadosDataProgramada: TDateField;
    QryPedidosProgramadosQuantidadeProgramada: TBCDField;
    QryPedidosProgramadosTranspProgramada: TStringField;
    QryPedidosProgramadosOrdem: TIntegerField;
    QryPedidosDataProgramada: TDateField;
    ViewPedidosDataProgramada: TcxGridDBColumn;
    BtnExcelcxGridTarefa: TBitBtn;
    SaveDialog: TSaveDialog;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    Label2: TLabel;
    LblLitros: TLabel;
    QryEstoquePrevistoQuantPedidos: TIntegerField;
    ViewEstoquePrevistoQuantPedidos: TcxGridDBColumn;
    QryPedidosSituacao: TStringField;
    ViewPedidosSituacao: TcxGridDBColumn;
    BtnAtualizaDatasSidicom: TBitBtn;
    Timer1: TTimer;
    procedure QryComprasPrevistasAfterPost(DataSet: TDataSet);
    procedure QryComprasPrevistasAfterDelete(DataSet: TDataSet);
    procedure QryComprasPrevistasBeforePost(DataSet: TDataSet);
    procedure QryPedidosCalcFields(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure QryPedidosCheckChange(Sender: TField);
    procedure ViewPedidosCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure ViewPedidosCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure ViewPedidosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAlterarDataClick(Sender: TObject);
    procedure BtnExcelcxGridTarefaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAtualizaDatasSidicomClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FGrupo: String;
    FChecked: TDictionary<String, Boolean>;
    FClonePedidos: TFDMemTable;
    procedure RefreshQryParam(PQry: TFDQuery; pNomeParam: String; pValor: String);
    function GetChecked(pKey: String): Boolean;
    function GetPedidoKey: String; overload;
    function GetPedidoKey(pDataSet: TDataSet): String; overload;
    procedure SetChecked(pKey: String; pCheck: Boolean);
    procedure SelecionaPedido;
    procedure NovaDataProgramada(pCodPedido, pCodProduto: String; pData: TDate);
    function LitrosSelecionados: Double;
    procedure AtualizaDataEntregaSidicom(pCodPedido: String; pNovaData: TDateTime);
    procedure RefreshQueries;
    procedure RefreshQuery(pQuery: TFDQuery);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent);
    procedure SetGrupo(pCodGrupo: String);
    class procedure AbreGrupo(pCodGrupo: String);
  end;

implementation

{$R *.dfm}

{ TFormEntregaPorProduto }

class procedure TFormEntregaPorProduto.AbreGrupo(pCodGrupo: String);
var
  FormEntregaPorProduto: TFormEntregaPorProduto;
begin
  FormEntregaPorProduto:= TFormEntregaPorProduto.Create(nil);
  try
    FormEntregaPorProduto.SetGrupo(pCodGrupo);
    FormEntregaPorProduto.ShowModal;
  finally
    FormEntregaPorProduto.Free;
  end;
end;

procedure TFormEntregaPorProduto.QryComprasPrevistasAfterDelete(
  DataSet: TDataSet);
begin
  RefreshQuery(QryEstoquePrevisto);
end;

procedure TFormEntregaPorProduto.RefreshQuery(pQuery: TFDQuery);
begin
  pQuery.DisableControls;
  try
    pQuery.Refresh;
  finally
    pQuery.EnableControls;
  end;
end;

procedure TFormEntregaPorProduto.RefreshQueries;
begin
  RefreshQuery(QryEstoquePrevisto);
  RefreshQuery(QryEstoquePrevisto);
  RefreshQuery(QryComprasPrevistas);
  RefreshQuery(QryPedidosProgramados);
end;

procedure TFormEntregaPorProduto.QryComprasPrevistasAfterPost(
  DataSet: TDataSet);
begin
  RefreshQueries;
end;

procedure TFormEntregaPorProduto.QryComprasPrevistasBeforePost(
  DataSet: TDataSet);
begin
  QryComprasPrevistasCodGrupoSub.AsString:= FGrupo;
end;

procedure TFormEntregaPorProduto.NovaDataProgramada(pCodPedido, pCodProduto: String; pData: TDate);
begin
  if not QryPedidosProgramados.Locate('CODPEDIDO;CODPRODUTO', VarArrayOf([pCodPedido, pCodProduto]), []) then
    QryPedidosProgramados.Insert
  else
    QryPedidosProgramados.Edit;

  QryPedidosProgramadosCodPedido.AsString:= pCodPedido;
  QryPedidosProgramadosCodProduto.AsString:= pCodProduto;
  QryPedidosProgramadosDataProgramada.AsDateTime:= pData;
  QryPedidosProgramados.Post;
//  if not QryPedidosProgramados.Locate( then
end;

procedure TFormEntregaPorProduto.BtnAlterarDataClick(Sender: TObject);
begin
  QryPedidos.First;
  while not QryPedidos.Eof do
  begin
    if QryPedidosCheck.AsBoolean then
      NovaDataProgramada(QryPedidosCodPedido.AsString, QryPedidosCODPRODUTO.AsString, DatePicker.Date);

    QryPedidos.Next;
  end;

  FChecked.Clear;
  QryPedidos.Refresh;
  QryEstoquePrevisto.Refresh;
  QryPedidos.First;

  LblLitros.Caption:= FormatFloat('#0', LitrosSelecionados);
end;

procedure TFormEntregaPorProduto.AtualizaDataEntregaSidicom(pCodPedido: String; pNovaData: TDateTime);
begin
  ConFirebird.ExecSql('UPDATE PEDIDO SET DATAENTREGA =:Data WHERE CODPEDIDO =:pCodPedido', [Variant(pNovaData), pCodPedido]); // Data precisa ser convertida para Variant
end;

procedure TFormEntregaPorProduto.BtnAtualizaDatasSidicomClick(Sender: TObject);
begin
  if Application.MessageBox('As datas de entrega de todos os pedidos deste grupo serão atualizadas no Sidicom para ficarem iguais a data programada para o pedido!'+sLineBreak
                            +'Confirma a atualização das datas no Sidicom?', 'Atenção!', MB_YESNO) = ID_YES then
  begin
    FClonePedidos.CloneCursor(QryPedidos);
    try
      FClonePedidos.First;
      while not FClonePedidos.Eof do
      begin
        AtualizaDataEntregaSidicom(FClonePedidos.FieldByName('CODPEDIDO').AsString, Trunc(FClonePedidos.FieldByName('DataProgramada').AsDateTime));

        FClonePedidos.Next;
      end;
    finally
      FClonePedidos.Close;
    end;
    ShowMessage('Data de entrega dos pedidos atualizada.');
  end;
end;

procedure TFormEntregaPorProduto.BtnExcelcxGridTarefaClick(Sender: TObject);
begin
  SaveDialog.DefaultExt:= '.xls';
  SaveDialog.FileName:= 'Programação Pedidos.xls';
  if SaveDialog.Execute then
  begin
    if ViewPedidos.DataController.FilteredRecordCount > 65000 then
    begin
      ShowMessage('Não é possível exportar mais de 65000 linhas para o excel! Faça um filtro e tente novamente.');
      Exit;
    end;

    ExportGridToExcel(SaveDialog.FileName, cxGridPedidos, True, True, True, 'xls');

    begin
      showmessage('Arquivo Exportado com Sucesso.');
      ShellExecute(Handle, 'open', pchar(SaveDialog.FileName), nil, nil, SW_SHOW);
    end;
  end;
end;

constructor TFormEntregaPorProduto.Create(AOwner: TComponent);
begin
  FChecked:= TDictionary<String, Boolean>.Create;
  inherited Create(AOwner);

  FClonePedidos:= TFDMemTable.Create(Self);
  FClonePedidos.FieldDefs.Assign(QryPedidos.FieldDefs);
  FClonePedidos.CreateDataSet;
end;

procedure TFormEntregaPorProduto.FormCreate(Sender: TObject);
begin
  LblLitros.Caption:= FormatFloat('#0', 0);
end;

procedure TFormEntregaPorProduto.FormDestroy(Sender: TObject);
begin
  FClonePedidos.Free;
  FChecked.Free;
end;

function TFormEntregaPorProduto.GetChecked(pKey: String): Boolean;
begin
  if not FChecked.TryGetValue(pKey, Result) then
    Result:= False;
end;

procedure TFormEntregaPorProduto.QryPedidosCalcFields(DataSet: TDataSet);
begin
  QryPedidosCheck.AsBoolean:= GetChecked(GetPedidoKey);
end;

function TFormEntregaPorProduto.GetPedidoKey: String;
begin
  Result:= GetPedidoKey(QryPedidos);
end;

function TFormEntregaPorProduto.GetPedidoKey(pDataSet: TDataSet): String;
begin
  Result:= pDataSet.FieldByName('CodPedido').AsString+pDataSet.FieldByName('CodProduto').AsString;
end;

procedure TFormEntregaPorProduto.SetChecked(pKey: String; pCheck: Boolean);
begin
  if pKey = '' then
    Exit;

  FChecked.AddOrSetValue(pKey, pCheck);
end;

function TFormEntregaPorProduto.LitrosSelecionados: Double;
begin
//  FClonePedidos.Open;
  FClonePedidos.CloneCursor(QryPedidos);
  try
    Result:= 0;
    FClonePedidos.First;
    while not FClonePedidos.Eof do
    begin
      if GetChecked(GetPedidoKey(FClonePedidos)) then
        Result:= Result+FClonePedidos.FieldByName('Litros').AsFloat;

      FClonePedidos.Next;
    end;
  finally
    FClonePedidos.Close;
  end;
end;

procedure TFormEntregaPorProduto.QryPedidosCheckChange(Sender: TField);
begin
  if QryPedidos.State in ([dsEdit, dsInsert]) then
    SetChecked(GetPedidoKey, QryPedidosCheck.AsBoolean);
end;

procedure TFormEntregaPorProduto.RefreshQryParam(PQry: TFDQuery; pNomeParam: String; pValor: String);
begin
  pQry.Close;
  pQry.ParamByName(pNomeParam).AsString:= pValor;
  pQry.Open;
end;

procedure TFormEntregaPorProduto.SetGrupo(pCodGrupo: String);
begin
  FGrupo:= pCodGrupo;
  RefreshQryParam(QryComprasPrevistas, 'CODGRUPOSUB', FGrupo);
  RefreshQryParam(QryEstoquePrevisto, 'CODGRUPOSUB', FGrupo);
  RefreshQryParam(QryPedidos, 'CODGRUPOSUB', FGrupo);
  RefreshQryParam(QryPedidosProgramados, 'CODGRUPOSUB', FGrupo)
end;

procedure TFormEntregaPorProduto.Timer1Timer(Sender: TObject);
begin
  RefreshQueries;
end;

procedure TFormEntregaPorProduto.SelecionaPedido;
begin
  SetChecked(GetPedidoKey, not GetChecked(GetPedidoKey));
  QryPedidos.Edit;
  QryPedidos.Cancel;

  LblLitros.Caption:= FormatFloat('#0', LitrosSelecionados);
end;

procedure TFormEntregaPorProduto.ViewPedidosCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
//var
//  FValorAtual: Boolean;
begin
//  FValorAtual:= Sender.DataController.Values[ACellViewInfo.RecordViewInfo.Index, ViewPedidosCheck.Index];
  if ACellViewInfo.Item.Index = ViewPedidosCheck.Index then
     SelecionaPedido;

end;

procedure TFormEntregaPorProduto.ViewPedidosCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  SelecionaPedido;
end;

procedure TFormEntregaPorProduto.ViewPedidosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_SPACE then
    SelecionaPedido;

end;

end.
