unit UntDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UntClasses, UntDaoFactory, FrwRepository, UntQueryBuilder,
  Vcl.StdCtrls, SynCommons;

type
  TFormDemo = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Demonstracao;
  end;

var
  FormDemo: TFormDemo;

implementation

{$R *.dfm}

procedure TFormDemo.Demonstracao;
var
  FCampos: TFrwRepository<TCampo>;
  FCampo: TCampo;
begin
  Memo1.Lines.Clear;
  FCampos:= TFrwRepository<TCampo>.Create(TDaoGeneric<TCampo>.Create('cons.Campos', 'ID'));
  FCampos.LoadAll;
  for FCampo in FCampos do
    Memo1.Lines.Add(ObjectToJSon(FCampo, [woHumanReadable]));

end;

procedure TFormDemo.FormShow(Sender: TObject);
begin
  Demonstracao;
end;

end.
