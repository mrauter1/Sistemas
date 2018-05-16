unit uFormSelecionaModelos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, DB;

type
  TFormSelecionaModelo = class(TForm)
    CbxModelos: TComboBox;
    BtnOK: TBitBtn;
    procedure BtnOKClick(Sender: TObject);
  private
    function CarregaModelos(pCodProduto: String): Integer;
    { Private declarations }
  public
    class function SelecionaModelo(pCodProduto: String): Integer;
    { Public declarations }
  end;

implementation

uses
  uDmSqlUtils;

{$R *.dfm}

class function TFormSelecionaModelo.SelecionaModelo(
  pCodProduto: String): Integer;
var
  FFrm: TFormSelecionaModelo;
begin
  FFrm:= TFormSelecionaModelo.Create(Application);
  try
    FFrm.CarregaModelos(pCodProduto);
    if FFrm.CbxModelos.Items.Count = 1 then
      Result:= Integer(FFrm.CbxModelos.Items.Objects[0])
    else if FFrm.CbxModelos.Items.Count = 0 then
      Result:= 0
    else
    begin
      FFrm.CbxModelos.ItemIndex:= 0;
      FFrm.ShowModal;
      Result:= Integer(FFrm.CbxModelos.Items.Objects[FFrm.CbxModelos.ItemIndex]);
    end;
  finally
    FFrm.Free;
  end;
end;

procedure TFormSelecionaModelo.BtnOKClick(Sender: TObject);
begin
  Close;
end;

function TFormSelecionaModelo.CarregaModelos(pCodProduto: String): Integer;
const
  cSql = 'SELECT M.CODMODELO, M.DESCRICAOMODELO FROM INSUMOS_MODELO M INNER JOIN INSUMOS_ACABADO A ON A.CODMODELO = M.CODMODELO AND A.CODPRODUTO = ''%s'' ';
var
  FDataSet: TDataSet;
  FCnt: Integer;
begin
  FCnt:= 0;
  FDataSet:= DmSqlUtils.RetornaDataSet(Format(cSql, [pCodProduto]));
  try
    FDataSet.First;

    while not FDataSet.Eof do
    begin
      CbxModelos.AddItem(FDataSet.FieldByName('CODMODELO').AsString+' - '+FDataSet.FieldByName('DESCRICAOMODELO').AsString,
                         TObject(FDataSet.FieldByName('CODMODELO').AsInteger));
      FDataSet.Next;
    end;
  finally
    FDataSet.Free;
  end;
end;

end.
