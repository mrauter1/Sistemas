unit uFormSubGrupoExtras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConSqlServer, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCalendar,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, uConFirebird;

type
  TFormSubGrupoExtras = class(TForm)
    cxGridDadosGrupo: TcxGrid;
    cxGridDadosGrupoDBTableView: TcxGridDBTableView;
    cxGridDadosGrupoLevel: TcxGridLevel;
    DsGrupoSubExtras: TDataSource;
    QryGrupoSubExtras: TFDQuery;
    QryGrupoSubExtrasCODGRUPOSUB: TStringField;
    QryGrupoSubExtrasONU: TIntegerField;
    QryGrupoSubExtrasRISCO: TIntegerField;
    QryGrupoSubExtrasFABRICACAO: TDateField;
    QryGrupoSubExtrasMESESVALIDADE: TIntegerField;
    cxGridDadosGrupoDBTableViewCODGRUPOSUB: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewONU: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewRISCO: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewFABRICACAO: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewMESESVALIDADE: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewDATAVALIDADE: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewDESCRICAOETIQUETA: TcxGridDBColumn;
    DBNavigator1: TDBNavigator;
    QryGrupoSubExtrasDescricaoEtiqueta: TStringField;
    QryGrupoSubExtrasDATAVALIDADE: TDateField;
    QryGrupoSubExtrasDiasParaEntrega: TIntegerField;
    cxGridDadosGrupoDBTableViewDiasParaEntrega: TcxGridDBColumn;
    QryGrupoSubExtrasSubclasseRisco: TMemoField;
    QryGrupoSubExtrasDescricaoRisco: TMemoField;
    cxGridDadosGrupoDBTableViewSubclasserisco: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewDescricaoRisco: TcxGridDBColumn;
    QryGrupoSubExtrasDensidade: TBCDField;
    QryGrupoSubExtrasDescricaoOnu: TMemoField;
    cxGridDadosGrupoDBTableViewDensidade: TcxGridDBColumn;
    cxGridDadosGrupoDBTableViewDescricaoOnu: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    AtualizarDescriodosProdutosnoSidicom1: TMenuItem;
    procedure QryGrupoSubExtrasMESESVALIDADEChange(Sender: TField);
    procedure FormCreate(Sender: TObject);
    procedure QryGrupoSubExtrasDATAVALIDADEChange(Sender: TField);
    procedure QryGrupoSubExtrasFABRICACAOChange(Sender: TField);
    procedure AtualizarDescriodosProdutosnoSidicom1Click(Sender: TObject);
  private
    FEditandoValidade: Boolean;
    procedure AtualizarDescricaoProdutos;
  public
    { Public declarations }
  end;

{var
  FormSubGrupoExtras: TFormSubGrupoExtras;}

implementation

uses
  Utils;

{$R *.dfm}

procedure TFormSubGrupoExtras.AtualizarDescricaoProdutos;
const
  cSqlMateriaPrima = ' select p.CODPRODUTO, ge.DescricaoOnu+'', ''+p.APRESENTACAO AS NovaApresentacao '+
                      ' from PRODUTO P inner join GRUPOSUBEXTRAS ge on ge.CODGRUPOSUB = p.CODGRUPOSUB '+
                      ' where IsNull(ge.DescricaoOnu,'''') <> '''' ' +
                      ' AND CODAPLICACAO NOT BETWEEN 1001 AND 1026 ';

  cSqlIndustrializado = 'select p.CODPRODUTO, ''ONU 1263, MATERIAL RELACIONADO COM TINTAS (Incluindo diluentes ou redutores para tintas), CLASSE DE RISCO 3, GE II, ''+p.APRESENTACAO AS NovaApresentacao '+
                        ' from PRODUTO P ' +
                        'inner join GRUPOSUB ge on ge.CODGRUPOSUB = p.CODGRUPOSUB '+
                        ' where CODAPLICACAO NOT BETWEEN 1001 AND 1026 '+
                        ' and ge.CODGRUPO = ''002'' ';

  cSqlUpdate = 'update produto set NomeGenerico = Apresentacao, Apresentacao = ''%s'' where codproduto = ''%s'' ';

  procedure AtualizaApresentacaoProdutos(const Sql: String);
  var
    FQry: TDataSet;
    FComando: String;
    FApresentacao: String;
  begin
    FQry:= ConSqlServer.RetornaDataSet(Sql, True);
    try
      FQry.First;
      while not FQry.Eof do
      begin
        if FQry.FieldByName('NovaApresentacao').AsString <> '' then
        begin
          FComando:= Format(cSqlUpdate, [FQry.FieldByName('NovaApresentacao').AsString, FQry.FieldByName('CodProduto').AsString]);
          WriteLog('AtualizaDescricao.txt', FComando);
          ConFirebird.ExecutaComando(FComando);
          FApresentacao:= ConFirebird.RetornaValor(Format('SELECT APRESENTACAO WHERE CODPRODUTO = ''%s'' ', [FQry.FieldByName('CodProduto').AsString]));
          ShowMessage(Format('Produto código %s. Nova apresentação: %s', [FQry.FieldByName('CodProduto').AsString, FApresentacao]));
        end;

        FQry.Next;
      end;
    finally
      FQry.Free;
    end;
  end;


begin
  AtualizaApresentacaoProdutos(cSqlMateriaPrima);

  AtualizaApresentacaoProdutos(cSqlIndustrializado);
end;

procedure TFormSubGrupoExtras.AtualizarDescriodosProdutosnoSidicom1Click(
  Sender: TObject);
begin
  if InputBox('Atenção, este procedimento irá alterar o nome dos produtos no Sidicom', 'Digite a senha', '') = '80819293' then
    AtualizarDescricaoProdutos;
end;

procedure TFormSubGrupoExtras.FormCreate(Sender: TObject);
begin
  FEditandoValidade:= False;

  if not QryGrupoSubExtras.Active then
    QryGrupoSubExtras.open;
end;

procedure TFormSubGrupoExtras.QryGrupoSubExtrasDATAVALIDADEChange(
  Sender: TField);
begin
  if FEditandoValidade then
    Exit;

  if QryGrupoSubExtras.State <> dsEdit then
    Exit;

  FEditandoValidade:= True;
  try
    QryGrupoSubExtrasMESESVALIDADE.Clear;
  finally
    FEditandoValidade:= False;
  end;
end;

procedure TFormSubGrupoExtras.QryGrupoSubExtrasFABRICACAOChange(Sender: TField);
begin
  if FEditandoValidade then
    Exit;

  if QryGrupoSubExtras.State <> dsEdit then
    Exit;

  if (not (QryGrupoSubExtrasMESESVALIDADE.IsNull)) and (not (QryGrupoSubExtrasFABRICACAO.IsNull)) then
  begin
    FEditandoValidade:= True;
    try
      QryGrupoSubExtrasDATAVALIDADE.AsDateTime:= IncMonth(QryGrupoSubExtrasFABRICACAO.AsDateTime, QryGrupoSubExtrasMESESVALIDADE.AsInteger)-1;
    finally
      FEditandoValidade:= False;
    end;
  end;

end;

procedure TFormSubGrupoExtras.QryGrupoSubExtrasMESESVALIDADEChange(
  Sender: TField);
begin
  if FEditandoValidade then
    Exit;

  if QryGrupoSubExtras.State <> dsEdit then
    Exit;

  if not (QryGrupoSubExtrasFABRICACAO.IsNull) then
  begin
    FEditandoValidade:= True;
    try
      QryGrupoSubExtrasDATAVALIDADE.AsDateTime:= IncMonth(QryGrupoSubExtrasFABRICACAO.AsDateTime, QryGrupoSubExtrasMESESVALIDADE.AsInteger)-1;
    finally
      FEditandoValidade:= False;
    end;
  end;
end;

end.
