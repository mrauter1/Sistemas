unit uFormFila;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, uFormGlobal, uPedidos, cxTextEdit,
  Vcl.Buttons, Vcl.Menus, uDmEstoqProdutos, cxSpinEdit, System.Generics.Collections,
  uFrmShowMemo;

type
  TViewState = record
    TopRowIndex: Integer;
    KeyField: String;
    ExpandedRows: TArray<String>;
  end;

type
  TFormFilaProducao = class(TForm)
    DataSourceFila: TDataSource;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    Panel1: TPanel;
    BtnAtualiza: TButton;
    cxGridDBTableViewCODPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewNOMEPRODUTO: TcxGridDBColumn;
    cxGridDBTableViewFALTACONFIRMADA: TcxGridDBColumn;
    cxGridDBTableViewNUMPEDIDOS: TcxGridDBColumn;
    cxGridDBTableViewPRODUCAOSUGERIDA: TcxGridDBColumn;
    cxGridDBTableViewFALTAHOJE: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1: TcxGridDBTableView;
    DataSourcePedidos: TDataSource;
    cxGridDBTableView1CODPEDIDO: TcxGridDBColumn;
    cxGridDBTableView1QUANTIDADE: TcxGridDBColumn;
    cxGridDBTableView1DIASPARAENTREGA: TcxGridDBColumn;
    cxGridDBTableView1NOMECLIENTE: TcxGridDBColumn;
    cxGridDBTableView1NOMETRANSPORTE: TcxGridDBColumn;
    cxGridDBTableView1QUANTPENDENTE: TcxGridDBColumn;
    cxGridDBTableViewPROBFALTAHOJE: TcxGridDBColumn;
    cxGridDBTableViewESTOQUEATUAL: TcxGridDBColumn;
    cxGridDBTableViewEstoqMaxCalculado: TcxGridDBColumn;
    cxGridDBTableViewESPACOESTOQUE: TcxGridDBColumn;
    PopupMenuOpcoes: TPopupMenu;
    AbrirConfigPro: TMenuItem;
    AbrirDetalhePro: TMenuItem;
    BtnOpcoes: TBitBtn;
    VerSimilares1: TMenuItem;
    VerInsumos1: TMenuItem;
    cxGridDBTableViewDEMANDADIARIA: TcxGridDBColumn;
    cxGridDBTableViewDIASESTOQUE: TcxGridDBColumn;
    cxGridDBTableViewFaltaTotal: TcxGridDBColumn;
    cxGridDBTableView1DATAENTREGA: TcxGridDBColumn;
    cxGridDBTableView1SITUACAO: TcxGridDBColumn;
    cxGridDBTableViewNOMEAPLICACAO: TcxGridDBColumn;
    cxGridDBTableViewRank: TcxGridDBColumn;
    BtnExcelcxGridTarefa: TBitBtn;
    SaveDialog: TSaveDialog;
    Timer1: TTimer;
    procedure BtnAtualizaClick(Sender: TObject);
    procedure BtnOpcoesClick(Sender: TObject);
    procedure AbrirConfigProClick(Sender: TObject);
    procedure AbrirDetalheProClick(Sender: TObject);
    procedure VerSimilares1Click(Sender: TObject);
    procedure VerInsumos1Click(Sender: TObject);
    procedure cxGridDBTableViewDblClick(Sender: TObject);
    procedure cxGridDBTableView1SITUACAOGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure BtnExcelcxGridTarefaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

    FormShowMemo: TFormShowMemo;
    procedure AtualizaGrid;
    function GetCodProSelecionado: String;
    function SaveExpandedState(pView: TcxGridDBTableView;
      KeyField: String): TViewState;
    procedure LoadExpandedState(pView: TcxGridDBTableView; pViewState: TViewState);
    { Private declarations }
  public
    { Public declarations }
    procedure AtualizaFilaProducao;
  end;

implementation

uses
  uFormProInfo, uFormDetalheProdutos, uFormAdicionarSimilaridade, uFormInsumos,
  cxGridExportLink, WinApi.ShellApi;

{$R *.dfm}

procedure TFormFilaProducao.AtualizaFilaProducao;
begin
  if Self.Visible then
    FormShowMemo.Parent:= Self
  else
    FormShowMemo.Parent:= nil;

  FormShowMemo.Show;
  try
    FormShowMemo.SetText('Iniciando atualiza��o das informa��es dos produtos...');

    FormShowMemo.SetText('Atualizando fila de produ��o...');
    DmEstoqProdutos.AtualizaEstoqueNew;
  finally
    FormShowMemo.Hide;
  end;
end;

procedure TFormFilaProducao.AbrirDetalheProClick(Sender: TObject);
begin
  TFormDetalheProdutos.AbreEFocaProduto(VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], ''));
end;

procedure TFormFilaProducao.AtualizaGrid;
begin
  cxGridDBTableView.ClearItems;
  cxGridDBTableView.DataController.CreateAllItems;
end;

function TFormFilaProducao.SaveExpandedState(pView: TcxGridDBTableView; KeyField: String): TViewState;
var
  I: Integer;
  FChave: Variant;
  View: TcxGridDBTableView;
begin
  Result.KeyField:= KeyField;
  SetLength(Result.ExpandedRows, 0);
  Result.TopRowIndex:= pView.Controller.TopRowIndex;

  for I := 0 to pView.DataController.RecordCount-1 do
  begin
    FChave:= pView.DataController.Values[I, pView.GetColumnByFieldName(KeyField).Index];

    if pView.ViewData.Records[I].Expanded then
    begin
      SetLength(Result.ExpandedRows, length(Result.ExpandedRows)+1);
      Result.ExpandedRows[High(Result.ExpandedRows)]:= FChave;
    end;
  end;
end;

procedure TFormFilaProducao.Timer1Timer(Sender: TObject);
begin
  AtualizaFilaProducao;
end;

procedure TFormFilaProducao.LoadExpandedState(pView: TcxGridDBTableView; pViewState: TViewState);
var
  FChave: String;
  I: Integer;

  function KeyInArray(pKey: string; pArray: TArray<String>): Boolean;
  var
    I: Integer;
  begin
    Result:= False;
    for I := 0 to Length(pArray) -1 do
      if pKey = pArray[I] then
      begin
        Result:= True;
        Exit;
      end;
  end;

begin
  for I := 0 to pView.DataController.RecordCount-1 do
  begin
    FChave:= pView.DataController.Values[I, pView.GetColumnByFieldName(pViewState.KeyField).Index];
    pView.ViewData.Records[I].Expanded:= KeyInArray(FChave, pViewState.ExpandedRows);
  end;

  pView.Controller.TopRowIndex:= pViewState.TopRowIndex;
end;

procedure TFormFilaProducao.BtnAtualizaClick(Sender: TObject);
var
  FState: TViewState;
begin
  FState:= SaveExpandedState(cxGridDBTableView, 'CODPRODUTO');

  AtualizaFilaProducao;

  LoadExpandedState(cxGridDBTableView, fState);
end;

procedure TFormFilaProducao.BtnExcelcxGridTarefaClick(Sender: TObject);
begin
  SaveDialog.DefaultExt:= '.xls';
  SaveDialog.FileName:= 'Fila de produ��o.xls';
  if SaveDialog.Execute then
  begin
    if cxGridDBTableView.DataController.FilteredRecordCount > 65000 then
    begin
      ShowMessage('N�o � poss�vel exportar mais de 65000 linhas para o excel! Fa�a um filtro e tente novamente.');
      Exit;
    end;

    ExportGridToExcel(SaveDialog.FileName, cxGrid, True, True, True, 'xls');

    begin
      showmessage('Arquivo Exportado com Sucesso.');
      ShellExecute(Handle, 'open', pchar(SaveDialog.FileName), nil, nil, SW_SHOW);
    end;
  end;
end;

procedure TFormFilaProducao.BtnOpcoesClick(Sender: TObject);
begin
  if BtnOpcoes.Caption = '+' then
  begin
    cxGridDBTableView.ViewData.Expand(True);
    BtnOpcoes.Caption:= '-';
  end
 else
  begin
    cxGridDBTableView.ViewData.Collapse(True);
    BtnOpcoes.Caption:= '+';
  end;

end;

procedure TFormFilaProducao.cxGridDBTableView1SITUACAOGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if AText = '0' then
    AText:= 'Pendente'
  else if AText = '1' then
    AText:= 'Reserva'
  else if AText = '2' then
    AText:= 'Separa��o';
end;

procedure TFormFilaProducao.cxGridDBTableViewDblClick(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, DmEstoqProdutos.QryEstoqAPRESENTACAO.AsString);
end;

procedure TFormFilaProducao.FormCreate(Sender: TObject);
begin
  FormShowMemo:= TFormShowMemo.Create(Self);
  AtualizaFilaProducao;
end;

procedure TFormFilaProducao.VerInsumos1Click(Sender: TObject);
begin
  TFormInsumos.AbrirInsumos(GetCodProSelecionado, DmEstoqProdutos.QryEstoqAPRESENTACAO.AsString);
end;

procedure TFormFilaProducao.VerSimilares1Click(Sender: TObject);
begin
  TFormAdicionarSimilaridade.AbrirSimilares(GetCodProSelecionado, DmEstoqProdutos.QryEstoqAPRESENTACAO.AsString);
end;

function TFormFilaProducao.GetCodProSelecionado: String;
begin
  Result:= VarToStrDef(cxGridDBTableView.DataController.Values[cxGridDBTableView.DataController.FocusedRecordIndex,
                                                                cxGridDBTableViewCODPRODUTO.Index], '');
end;

procedure TFormFilaProducao.AbrirConfigProClick(Sender: TObject);
begin
  TFormProInfo.Abrir(GetCodProSelecionado);
end;

end.
