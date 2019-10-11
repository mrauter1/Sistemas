unit uFormCiclosVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls, uConSqlServer, Utils;

type
  TFormCiclosVenda = class(TForm)
    Panel1: TPanel;
    BtnAtualiza: TButton;
    BtnOpcoes: TBitBtn;
    BtnExcelcxGridTarefa: TBitBtn;
    SaveDialog: TSaveDialog;
    PopupMenuOpcoes: TPopupMenu;
    QryCiclos: TFDQuery;
    QryCiclosNOMECLIENTE: TStringField;
    QryCiclosProduto: TStringField;
    QryCiclosCODVENDEDOR2: TStringField;
    QryCiclosVendedor: TStringField;
    QryCiclosCodCliente: TStringField;
    QryCiclosCodProduto: TStringField;
    QryCiclosTicketMedio: TFMTBCDField;
    QryCiclosDataUltimaCompra: TDateField;
    QryCiclosCidade: TStringField;
    QryCiclosEstado: TStringField;
    DsCiclos: TDataSource;
    QryCiclosNroCompras: TIntegerField;
    QryCiclosDiasUteisEntreCompras: TFloatField;
    QryCiclosDiasUteisSemComprar: TIntegerField;
    QryCiclosCiclosSemCompra: TBCDField;
    PageControl1: TPageControl;
    TabParaComprar: TTabSheet;
    TabRecuperar: TTabSheet;
    cxGridParaComprar: TcxGrid;
    cxGridParaComprarDBTableView: TcxGridDBTableView;
    cxGridParaComprarDBTableViewCodCliente: TcxGridDBColumn;
    cxGridParaComprarDBTableViewNOMECLIENTE: TcxGridDBColumn;
    cxGridParaComprarDBTableViewProduto: TcxGridDBColumn;
    cxGridParaComprarDBTableViewCODVENDEDOR2: TcxGridDBColumn;
    cxGridParaComprarDBTableViewVendedor: TcxGridDBColumn;
    cxGridParaComprarDBTableViewCodProduto: TcxGridDBColumn;
    cxGridParaComprarDBTableViewTicketMedio: TcxGridDBColumn;
    cxGridParaComprarDBTableViewDiasUteisEntreCompras: TcxGridDBColumn;
    cxGridParaComprarDBTableViewCiclosSemCompra: TcxGridDBColumn;
    cxGridParaComprarDBTableViewDiasUteisSemComprar: TcxGridDBColumn;
    cxGridParaComprarDBTableViewDataUltimaCompra: TcxGridDBColumn;
    cxGridParaComprarDBTableViewCidade: TcxGridDBColumn;
    cxGridParaComprarDBTableViewEstado: TcxGridDBColumn;
    cxGridParaComprarDBTableView1: TcxGridDBTableView;
    cxGridParaComprarLevel: TcxGridLevel;
    QryRecuperar: TFDQuery;
    QryRecuperarCodCliente: TStringField;
    StringField2: TStringField;
    QryRecuperarProduto: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    QryRecuperarCodProduto: TStringField;
    IntegerField1: TIntegerField;
    FMTBCDField1: TFMTBCDField;
    DateField1: TDateField;
    StringField7: TStringField;
    StringField8: TStringField;
    FloatField1: TFloatField;
    IntegerField2: TIntegerField;
    BCDField1: TBCDField;
    DsRecuperar: TDataSource;
    cxGridParaRecuperar: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridDBColumn11: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridDBColumn14: TcxGridDBColumn;
    cxGridDBTableView3: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    Relembrarem3dias1: TMenuItem;
    Relembrarem10dias1: TMenuItem;
    Relembrarem30dias1: TMenuItem;
    TabIgnorados: TTabSheet;
    QryIgnorados: TFDQuery;
    DsIgnorados: TDataSource;
    QryIgnoradosDataRelembrar: TDateField;
    QryIgnoradosMotivo: TStringField;
    QryIgnoradosCodCliente: TStringField;
    QryIgnoradosNOMECLIENTE: TStringField;
    QryIgnoradosProduto: TStringField;
    QryIgnoradosCODVENDEDOR2: TStringField;
    QryIgnoradosVendedor: TStringField;
    QryIgnoradosCodProduto: TStringField;
    QryIgnoradosNroCompras: TIntegerField;
    QryIgnoradosTicketMedio: TFMTBCDField;
    QryIgnoradosDataUltimaCompra: TDateField;
    QryIgnoradosCidade: TStringField;
    QryIgnoradosEstado: TStringField;
    QryIgnoradosDiasUteisEntreCompras: TFloatField;
    QryIgnoradosDiasUteisSemComprar: TIntegerField;
    QryIgnoradosCiclosSemCompra: TBCDField;
    cxGridClientesIgnorados: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView4: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    cxGridDBTableView1CodCliente: TcxGridDBColumn;
    cxGridDBTableView1NOMECLIENTE: TcxGridDBColumn;
    cxGridDBTableView1Produto: TcxGridDBColumn;
    cxGridDBTableView1CODVENDEDOR2: TcxGridDBColumn;
    cxGridDBTableView1Vendedor: TcxGridDBColumn;
    cxGridDBTableView1CodProduto: TcxGridDBColumn;
    cxGridDBTableView1TicketMedio: TcxGridDBColumn;
    cxGridDBTableView1DataUltimaCompra: TcxGridDBColumn;
    cxGridDBTableView1Cidade: TcxGridDBColumn;
    cxGridDBTableView1Estado: TcxGridDBColumn;
    cxGridDBTableView1DiasUteisEntreCompras: TcxGridDBColumn;
    cxGridDBTableView1DiasUteisSemComprar: TcxGridDBColumn;
    cxGridDBTableView1CiclosSemCompra: TcxGridDBColumn;
    cxGridDBTableView1DataRelembrar: TcxGridDBColumn;
    cxGridDBTableView1Motivo: TcxGridDBColumn;
    PopupMenuIgnorados: TPopupMenu;
    Deixardeignorar1: TMenuItem;
    QryIgnoradosObs: TMemoField;
    cxGridDBTableView1Obs: TcxGridDBColumn;
    TabSheet1: TTabSheet;
    QryTodosClientes: TFDQuery;
    DsTodosClientes: TDataSource;
    cxGridTodosClientes: TcxGrid;
    cxGridDBTableView5: TcxGridDBTableView;
    cxGridDBTableView6: TcxGridDBTableView;
    cxGridLevel3: TcxGridLevel;
    QryTodosClientesCodCliente: TStringField;
    QryTodosClientesNOMECLIENTE: TStringField;
    QryTodosClientesProduto: TStringField;
    QryTodosClientesCODVENDEDOR2: TStringField;
    QryTodosClientesVendedor: TStringField;
    QryTodosClientesCodProduto: TStringField;
    QryTodosClientesNroCompras: TIntegerField;
    QryTodosClientesTicketMedio: TFMTBCDField;
    QryTodosClientesDataUltimaCompra: TDateField;
    QryTodosClientesCidade: TStringField;
    QryTodosClientesEstado: TStringField;
    QryTodosClientesDiasUteisEntreCompras: TFloatField;
    QryTodosClientesDiasUteisSemComprar: TIntegerField;
    QryTodosClientesCiclosSemCompra: TBCDField;
    cxGridDBTableView5CodCliente: TcxGridDBColumn;
    cxGridDBTableView5NOMECLIENTE: TcxGridDBColumn;
    cxGridDBTableView5Produto: TcxGridDBColumn;
    cxGridDBTableView5CODVENDEDOR2: TcxGridDBColumn;
    cxGridDBTableView5Vendedor: TcxGridDBColumn;
    cxGridDBTableView5CodProduto: TcxGridDBColumn;
    cxGridDBTableView5NroCompras: TcxGridDBColumn;
    cxGridDBTableView5TicketMedio: TcxGridDBColumn;
    cxGridDBTableView5DataUltimaCompra: TcxGridDBColumn;
    cxGridDBTableView5Cidade: TcxGridDBColumn;
    cxGridDBTableView5Estado: TcxGridDBColumn;
    cxGridDBTableView5DiasUteisEntreCompras: TcxGridDBColumn;
    cxGridDBTableView5DiasUteisSemComprar: TcxGridDBColumn;
    cxGridDBTableView5CiclosSemCompra: TcxGridDBColumn;
    procedure BtnOpcoesClick(Sender: TObject);
    procedure BtnAtualizaClick(Sender: TObject);
    procedure BtnExcelcxGridTarefaClick(Sender: TObject);
    procedure Relembrarem3dias1Click(Sender: TObject);
    procedure Relembrarem10dias1Click(Sender: TObject);
    procedure Relembrarem30dias1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Deixardeignorar1Click(Sender: TObject);
  private
    procedure SaveParaComprar(pCxGrid: TcxGrid; pNomeArquivo: String);
    procedure GravaLembreteCiclo(pCodCliente, pCodProduto: String; pData: TDate; pCodMotivo: Integer; pObs: String);
    procedure IgnorarCiclo(pData: TDate);
    procedure RefreshCiclos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCiclosVenda: TFormCiclosVenda;

implementation

{$R *.dfm}

uses
  cxGridExportLink, WinApi.ShellApi, uFormMotivoParaIgnorar;

procedure TFormCiclosVenda.BtnAtualizaClick(Sender: TObject);
begin
  if PageControl1.ActivePage = TabParaComprar then
  begin
    QryCiclos.Close;
    QryCiclos.Open;
  end
 else
  if PageControl1.ActivePage = TabRecuperar then
  begin
    QryRecuperar.Close;
    QryRecuperar.Open;
  end;
end;

procedure TFormCiclosVenda.SaveParaComprar(pCxGrid: TcxGrid; pNomeArquivo: String);
begin
  SaveDialog.DefaultExt:= '.xls';
  SaveDialog.FileName:= pNomeArquivo+'.xls';
  if SaveDialog.Execute then
  begin
    if TcxGridDBTableView(pCxGrid.Views[0]).DataController.FilteredRecordCount > 65000 then
    begin
      ShowMessage('Não é possível exportar mais de 65000 linhas para o excel! Faça um filtro e tente novamente.');
      Exit;
    end;

    ExportGridToExcel(SaveDialog.FileName, pCxGrid, True, True, True, 'xls');

    begin
      showmessage('Arquivo Exportado com Sucesso.');
      ShellExecute(Handle, 'open', pchar(SaveDialog.FileName), nil, nil, SW_SHOW);
    end;
  end;
end;

procedure TFormCiclosVenda.BtnExcelcxGridTarefaClick(Sender: TObject);
begin
  if PageControl1.ActivePage = TabParaComprar then
    SaveParaComprar(cxGridParaComprar, 'Clientes que estão para Comprar')
  else if PageControl1.ActivePage = TabRecuperar then
    SaveParaComprar(cxGridParaRecuperar, 'Clientes para Recuperar')
end;

procedure TFormCiclosVenda.BtnOpcoesClick(Sender: TObject);
begin
  if BtnOpcoes.Caption = '+' then
  begin
    cxGridParaComprarDBTableView.DataController.Groups.FullExpand;
    BtnOpcoes.Caption:= '-';
  end
 else
  begin
    cxGridDBTableView2.DataController.Groups.FullCollapse;
    BtnOpcoes.Caption:= '+';
  end;
end;

procedure TFormCiclosVenda.Deixardeignorar1Click(Sender: TObject);
const
  cSql = 'DELETE FROM LEMBRETECICLOS WHERE CODCLIENTE = ''%s'' AND CODPRODUTO = ''%s'' ';
begin
  ConSqlServer.ExecutaComando(Format(cSql, [QryIgnoradosCodCliente.AsString, QryIgnoradosCodProduto.AsString]));
  RefreshCiclos;
end;

procedure TFormCiclosVenda.FormCreate(Sender: TObject);
begin
  if not QryCiclos.Active then
    QryCiclos.Open;

  if not QryRecuperar.Active then
    QryRecuperar.Open;
end;

procedure TFormCiclosVenda.RefreshCiclos;
begin
  QryCiclos.Close;
  QryCiclos.Open;
  QryRecuperar.Close;
  QryRecuperar.Open;
  QryIgnorados.Close;
  QryIgnorados.Open;
end;

procedure TFormCiclosVenda.IgnorarCiclo(pData: TDate);
var
  fCodMotivo: Integer;
  fObs: String;
  fCodCliente, fCodProduto: String;
begin
  if not (TFormMotivoIgnorar.SelecionaMotivo(fCodMotivo, fObs)) then
    Exit;

  if PageControl1.ActivePage = TabParaComprar then
  begin
     fCodCliente:= QryCiclosCodCliente.AsString;
     fCodProduto:= QryCiclosCodProduto.AsString;
  end
 else
  if PageControl1.ActivePage = TabRecuperar then
  begin
     fCodCliente:= QryRecuperarCodCliente.AsString;
     fCodProduto:= QryRecuperarCodProduto.AsString;
  end;

  GravaLembreteCiclo(fCodCliente, fCodProduto, Trunc(Now)+10, fCodMotivo, fObs);
  RefreshCiclos;
end;

procedure TFormCiclosVenda.Relembrarem10dias1Click(Sender: TObject);
begin
  IgnorarCiclo(Trunc(Now)+10);
end;

procedure TFormCiclosVenda.Relembrarem30dias1Click(Sender: TObject);
begin
  IgnorarCiclo(Trunc(Now)+30);
end;

procedure TFormCiclosVenda.Relembrarem3dias1Click(Sender: TObject);
begin
  IgnorarCiclo(Trunc(Now)+3);
end;

procedure TFormCiclosVenda.GravaLembreteCiclo(pCodCliente, pCodProduto: String; pData: TDate; pCodMotivo: Integer; pObs: String);
const
  cSql = 'exec GravaLembreteCiclo @pCodCliente = ''%s'', @pCodProduto = ''%s'', @pDataLembrete = %s, @pCodMotivo = %d, @pObs = ''%s'' ';
begin
  ConSqlServer.ExecutaComando(Format(cSql, [pCodCliente, pCodProduto, Func_Date_SqlServer(pData), pCodMotivo, pObs]));
end;

end.
