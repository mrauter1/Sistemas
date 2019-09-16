unit uFormLista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, IniFiles;

type
  TFormLista = class(TForm)
    ListComprov: TListBox;
    Panel1: TPanel;
    BtnOk: TBitBtn;
    BtnPadrao: TButton;
    Panel2: TPanel;
    EditComprov: TEdit;
    BtnAdd: TButton;
    BtnDel: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPadraoClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FValoresDefault: String;
    FNomeIdent: String;
    procedure RestauraPadrao;
    { Private declarations }
  public
    property ValoresDefault: String read FValoresDefault write FValoresDefault;
    property NomeIdent: String read FNomeIdent write FNomeIdent;
    { Public declarations }
  end;

var
  FormLista: TFormLista;

implementation

{$R *.dfm}

procedure TFormLista.BtnAddClick(Sender: TObject);
begin
  if Trim(EditComprov.Text) <> '' then
    ListComprov.Items.Add(EditComprov.Text);
end;

procedure TFormLista.BtnDelClick(Sender: TObject);
begin
  ListComprov.DeleteSelected;
end;

procedure TFormLista.BtnPadraoClick(Sender: TObject);
begin
  RestauraPadrao;
end;

procedure TFormLista.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      ArqIni.WriteString('Banco', NomeIdent, ListComprov.Items.CommaText);
      ArqIni.Free;
    end
end;

procedure TFormLista.FormShow(Sender: TObject);
var
  ArqIni: TIniFile;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Banco.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Banco.Ini');
      ListComprov.Items.CommaText :=
          ArqIni.ReadString('Banco', NomeIdent, ValoresDefault);
      ArqIni.Free;
    end
  else
    RestauraPadrao;

end;

procedure TFormLista.RestauraPadrao;
begin
  ListComprov.Items.CommaText:= ValoresDefault;

end;

end.
