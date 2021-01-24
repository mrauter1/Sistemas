unit uFormCompraProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid, Vcl.Buttons, uConSqlServer, uFormConsultaDataSet;

type
  TFormCompraProduto = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    LabelNomeProduto: TLabel;
    Panel2: TPanel;
    cxGridCompras: TcxGrid;
    ViewCompras: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    QryComprasPrevistas: TFDQuery;
    QryComprasPrevistasCodGrupoSub: TStringField;
    QryComprasPrevistasQuant: TBCDField;
    DsComprasPrevistas: TDataSource;
    ViewComprasCodGrupoSub: TcxGridDBColumn;
    ViewComprasQuant: TcxGridDBColumn;
    QryComprasPrevistasPreco: TBCDField;
    ViewComprasPreco: TcxGridDBColumn;
    btnOK: TBitBtn;
    EditGrupo: TEdit;
    BtnSelGrupo: TBitBtn;
    QryComprasPrevistasRecebido: TBooleanField;
    ViewComprasRecebido: TcxGridDBColumn;
    QryGrupos: TFDQuery;
    DsGrupo: TDataSource;
    QryGruposCODGRUPOSUB: TStringField;
    QryGruposCODGRUPO: TStringField;
    QryGruposCODSUBGRUPO: TStringField;
    QryGruposNOMESUBGRUPO: TStringField;
    CbxMostrarRecebidos: TCheckBox;
    QryComprasPrevistasID: TFDAutoIncField;
    QryComprasPrevistasDataCompra: TDateField;
    QryComprasPrevistasDataRecebimento: TDateField;
    QryComprasPrevistasObs: TMemoField;
    ViewComprasDataCompra: TcxGridDBColumn;
    ViewComprasDataRecebimento: TcxGridDBColumn;
    ViewComprasObs: TcxGridDBColumn;
    procedure BtnSelGrupoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QryComprasPrevistasBeforePost(DataSet: TDataSet);
    procedure CbxMostrarRecebidosClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure QryComprasPrevistasAfterInsert(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    MostraRecebidosAtual: Boolean;
    FSqlComprasOriginal: String;
    procedure CarregaGrupo(ACodGrupoSub: String);
    { Private declarations }
  public
    { Public declarations }
    class procedure AbreComprasDoGrupo(ACodGrupoSub: String);
    class procedure AbreCompras;
  end;

var
  FormCompraProduto: TFormCompraProduto;

implementation

uses
  GerenciadorUtils;

{$R *.dfm}

{ TFormCompraProduto }

class procedure TFormCompraProduto.AbreCompras;
var
  FFrm: TFormCompraProduto;
begin
  FFrm:= TFormCompraProduto.Create(Application);
  try
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

class procedure TFormCompraProduto.AbreComprasDoGrupo(ACodGrupoSub: String);
var
  FFrm: TFormCompraProduto;
begin
  FFrm:= TFormCompraProduto.Create(Application);
  try
    FFrm.CarregaGrupo(ACodGrupoSub);
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormCompraProduto.btnOKClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCompraProduto.BtnSelGrupoClick(Sender: TObject);
begin
  if TFormConsultaDataSet.ConsultaDataSet('Consulta Grupo de Produto.', QryGrupos) then
    CarregaGrupo(QryGruposCODGRUPOSUB.AsString);

end;

procedure TFormCompraProduto.CarregaGrupo(ACodGrupoSub: String);
var
  DataSetGrupo: TDataset;

  function BoolToSql(AValue: Boolean): String;
  begin
    if AValue then
      Result:= '1'
    else
      Result:= '0';
  end;
begin
   MostraRecebidosAtual:= CbxMostrarRecebidos.Checked;
  DataSetGrupo:= ConSqlServer.RetornaDataSet(Format('SELECT CODGRUPOSUB, NOMESUBGRUPO FROM GRUPOSUB WHERE CODGRUPOSUB = ''%s'' ', [ACodGrupoSub]));
  try
    if DataSetGrupo.IsEmpty then
      raise Exception.Create(Format('Grupo cod.: %s não encontrado!', [ACodGrupoSub]));

    EditGrupo.Text:= DatasetGrupo.FieldByName('CodGrupoSub').AsString;
    LabelNomeProduto.Caption:= DataSetGrupo.FieldByName('NomeSubGrupo').AsString;
  finally
    DatasetGrupo.Free;
  end;

  QryComprasPrevistas.Close;
  QryComprasPrevistas.SQL.Text:= FSqlComprasOriginal;
  if not CbxMostrarRecebidos.Checked then
    QryComprasPrevistas.SQL.Text:= StringReplace(QryComprasPrevistas.SQL.Text, '/*Recebidos*/', ' and Recebido=0', [rfIgnoreCase, rfReplaceAll]);

  QryComprasPrevistas.ParamByName('CodGrupoSub').AsString:= ACodGrupoSub;
  QryComprasPrevistas.Open;
end;

procedure TFormCompraProduto.CbxMostrarRecebidosClick(Sender: TObject);
begin
  if MostraRecebidosAtual = CbxMostrarRecebidos.Checked then
    Exit;

  if EditGrupo.Text = '' then
    Exit;

  CarregaGrupo(EditGrupo.Text);
end;

procedure TFormCompraProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if QryComprasPrevistas.State in ([dsInsert, dsEdit]) then
    QryComprasPrevistas.Post;

end;

procedure TFormCompraProduto.FormCreate(Sender: TObject);
begin
  MostraRecebidosAtual:= CbxMostrarRecebidos.Checked;
  FSqlComprasOriginal:= QryComprasPrevistas.SQL.Text;
  LabelNomeProduto.Caption:= '';

  QryGrupos.Open;
end;

procedure TFormCompraProduto.QryComprasPrevistasAfterInsert(DataSet: TDataSet);
begin
  QryComprasPrevistasDataCompra.AsDateTime:= Now;
  QryComprasPrevistasCodGrupoSub.AsString:= EditGrupo.Text;
  QryComprasPrevistasRecebido.AsBoolean:= False;
end;

procedure TFormCompraProduto.QryComprasPrevistasBeforePost(DataSet: TDataSet);
begin
  if EditGrupo.Text='' then
  begin
    QryComprasPrevistas.Cancel;
    Exit;
  end;

  if QryComprasPrevistasDataRecebimento.IsNull then
  begin
    ShowMessage('Data deve ser informada.');
    Abort;
  end;

  if QryComprasPrevistasQuant.IsNull then
  begin
    ShowMessage('Quantidade deve ser informada.');
    Abort;
  end;

end;

end.
