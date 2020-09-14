unit uFormAdicionarImagemEmailEmbalagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, jpeg, PngImage, Vcl.ExtDlgs, Vcl.StdCtrls;

type
  TFormAdicionarImagemEmailEmbalagem = class(TForm)
    PanelBot: TPanel;
    PanelLeft: TPanel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DsImagemEmail: TDataSource;
    QryImagemEmail: TFDQuery;
    QryImagemEmailidentificador: TStringField;
    QryImagemEmailIdImagem: TStringField;
    QryImagemEmailImagem: TBlobField;
    QryImagemEmailext: TStringField;
    OpenPictureDialog1: TOpenPictureDialog;
    Image1: TImage;
    BtnOK: TButton;
    procedure QryImagemEmailAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure QryImagemEmailAfterScroll(DataSet: TDataSet);
    procedure QryImagemEmailAfterOpen(DataSet: TDataSet);
  private
    procedure LoadImageFromDB;
    { Private declarations }
  public
    { Public declarations }
    class procedure Gerenciar;
  end;

var
  FormAdicionarImagemEmailEmbalagem: TFormAdicionarImagemEmailEmbalagem;

implementation

{$R *.dfm}

procedure TFormAdicionarImagemEmailEmbalagem.BtnOKClick(Sender: TObject);
begin
  if QryImagemEmail.State in ([dsEdit, dsInsert]) then
    QryImagemEmail.Post;

  Close;
end;

procedure TFormAdicionarImagemEmailEmbalagem.FormCreate(Sender: TObject);
begin
  QryImagemEmail.Open;
end;

class procedure TFormAdicionarImagemEmailEmbalagem.Gerenciar;
var
  FFrm: TFormAdicionarImagemEmailEmbalagem;
begin
  FFrm:= TFormAdicionarImagemEmailEmbalagem.Create(Application);
  try
    FFrm.ShowModal;
  finally
    FFrm.Free;
  end;
end;

procedure TFormAdicionarImagemEmailEmbalagem.LoadImageFromDB;
var
  FPng: TPngImage;
  FJPg: TJPEGImage;
  FStream: TMemoryStream;
begin
  Image1.Picture:= nil;
  if QryImagemEmailImagem.IsNull then
    Exit;

  FStream:= TMemoryStream.Create;
  try
    QryImagemEmailImagem.SaveToStream(FStream);
    FStream.Position:= 0;
    if UpperCase(QryImagemEmailext.AsString) = '.PNG' then
    begin
      FPng:= TPNgImage.Create;
      try
        FPng.LoadFromStream(FStream);
        Image1.Picture.Assign(FPng);
      finally
        FPng.Free;
      end;
    end
   else if QryImagemEmailImagem.AsString <> '' then
    begin
      FJpg:= TJPEGImage.Create;
      try
        FJpg.LoadFromStream(FStream);
        Image1.Picture.Assign(FJpg);
      finally
        FJpg.Free;
      end;
    end;

  finally
    FStream.Free;
  end;
end;

procedure TFormAdicionarImagemEmailEmbalagem.QryImagemEmailAfterInsert(DataSet: TDataSet);
var
  FStream: TMemoryStream;
begin
  if OpenPictureDialog1.Execute then
  try
    QryImagemEmailImagem.LoadFromFile(OpenPictureDialog1.FileName);
{    FStream:= TMemoryStream.Create;
    try
      Image1.Picture.Graphic.SaveToStream(FStream);
      FStream.Position:= 0;
      QryImagemEmailImagem.LoadFromStream(FStream);
    finally
      FStream.Free;
    end;         }

    QryImagemEmailImagem.LoadFromFile(OpenPictureDialog1.FileName);
    QryImagemEmailext.AsString:= ExtractFileExt(OpenPictureDialog1.FileName);

    QryImagemEmailidentificador.AsString:= 'EMBALAGEM';
    QryImagemEmailIdImagem.AsString:= ExtractFileName(OpenPictureDialog1.FileName);
    LoadImageFromDB;
    QryImagemEmail.Post;
  except
    QryImagemEmail.Cancel;
    raise;
  end
 else
   QryImagemEmail.Cancel;
end;

procedure TFormAdicionarImagemEmailEmbalagem.QryImagemEmailAfterOpen(
  DataSet: TDataSet);
begin
  LoadImageFromDB;
end;

procedure TFormAdicionarImagemEmailEmbalagem.QryImagemEmailAfterScroll(
  DataSet: TDataSet);
begin
  LoadImageFromDB;
end;

end.
