unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uDadosControleBase, uMVCInterfaces, uConexaoDBX,
  {uConexaoIBO,} uDadosModeloBase, DBCtrls, ExtCtrls, Grids, DBGrids, uConexaoBase, DadosView;

type
  TfMain = class(TForm)
    BtnPedidos: TButton;
    CbxConexao: TComboBox;
    Label1: TLabel;
    BtnClientes: TButton;
    BrnProduto: TButton;
    BtnRelPed: TButton;
    procedure BtnPedidosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnClientesClick(Sender: TObject);
    procedure CbxConexaoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BrnProdutoClick(Sender: TObject);
    procedure BtnRelPedClick(Sender: TObject);
  private
  //  procedure SetTipoConexao(Modelo: TDadosModeloBase);
  public
    function GetConexao: TConexaoBase;
//    EditList: TEditListBox;
  end;

var
  fMain: TfMain;

implementation

uses
  uPedidoControle, uPedidoModelo, uCadPedido, uClienteModelo,
  uClienteControle, uClienteView, uFuncoesSQL, uProdutoControle, uFormRelBase;

{$R *.dfm}

procedure TfMain.FormCreate(Sender: TObject);
begin
  FuncoesSQL:= TFuncoesSQL.Create(Self);
//  EditList:= TEditListBox.Create(self);
//  EditList.Edit:= Edit1;
end;

function TfMain.GetConexao: TConexaoBase;
begin
  case cbxConexao.ItemIndex of
//    0: Result:= ConexaoIBO;
    1: Result:= ConexaoDBX;
//    2: Modelo.IsDBConnection:= False;
  else
    Result:= ConexaoDBX;
  end;

//  Result:= ConexaoDBX;
end;

procedure TfMain.BtnClientesClick(Sender: TObject);
begin
  TClienteControle.CriaView(GetConexao);
end;

procedure TfMain.BtnPedidosClick(Sender: TObject);
begin
  TPedidoCtrl.CriaView(GetConexao);
end;

procedure TfMain.BtnRelPedClick(Sender: TObject);
begin
  TPedidoCtrl.CriaRelatorio(GetConexao);
end;

procedure TfMain.BrnProdutoClick(Sender: TObject);
begin
  TProdutoControle.CriaView(GetConexao);
end;

procedure TfMain.CbxConexaoChange(Sender: TObject);
begin
  FuncoesSql.Conexao:= GetConexao;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  FuncoesSql.Conexao:= GetConexao;
end;

end.
