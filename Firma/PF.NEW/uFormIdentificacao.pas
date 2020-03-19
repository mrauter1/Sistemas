unit uFormIdentificacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Buttons, IniFiles;

type
  TFormIdentificacaoEmpresa = class(TForm)
    CheckListBox: TCheckListBox;
    BtnOk: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure SetaVariaveis;
    { Private declarations }
  public
    { Public declarations }
    ComercializacaoNacional: Boolean;
    ComercializacaoInternacional: Boolean;
    Producao: Boolean;
    Transformacao: Boolean;
    Consumo: Boolean;
    Fabricacao: Boolean;
    Transporte: Boolean;
    Armazenamento: Boolean;
  end;

var
  FormIdentificacaoEmpresa: TFormIdentificacaoEmpresa;

implementation

{$R *.dfm}

procedure TFormIdentificacaoEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  ArqIni: TIniFile;
  I: Integer;

  function ItemToStr(pIndex: Integer): String;
  begin
    if CheckListBox.Checked[pIndex] then
      Result:= '1'
    else
      Result:= '0';
  end;
begin
  ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Config.Ini');

  for I := 0 to CheckListBox.Items.Count-1 do
    ArqIni.WriteString('IDENTIFICACAO', CheckListBox.Items[I], ItemToStr(I));

  ArqIni.Free;

  SetaVariaveis;
end;

procedure TFormIdentificacaoEmpresa.SetaVariaveis;

  function IsChecked(pNome: String): Boolean;
  begin
    Result:= CheckListBox.Checked[CheckListBox.Items.IndexOf(pNome)];
  end;

begin
  ComercializacaoNacional:= IsChecked('Comercialização Nacional');
  ComercializacaoInternacional:= IsChecked('Comercialização Internacional');
  Producao:= IsChecked('Produção');
  Transformacao:= IsChecked('Transformação');
  Consumo:= IsChecked('Consumo');
  Fabricacao:= IsChecked('Fabricação');
  Transporte:= IsChecked('Transporte');
  Armazenamento:= IsChecked('Armazenamento');
end;

procedure TFormIdentificacaoEmpresa.FormCreate(Sender: TObject);
var
  ArqIni: TIniFile;
  I: Integer;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + 'Config.Ini') then
    begin
      ArqIni:= TIniFile.Create(ExtractFilePath(Application.ExeName) +  'Config.Ini');
      for I := 0 to CheckListBox.Items.Count-1 do
        CheckListBox.Checked[I]:= ArqIni.ReadString('IDENTIFICACAO', CheckListBox.Items[I], '0')='1';

      ArqIni.Free;
    end
end;

end.
