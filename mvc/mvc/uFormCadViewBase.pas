unit uFormCadViewBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DadosView, ViewBase, CadView, uMVCInterfaces, uFormViewBase;

type
  TFormCadViewBase = class(TFormViewBase)
    Panel1: TPanel;
    BtnAdd: TButton;
    BtnEdit: TButton;
    BtnDel: TButton;
    BtnCancel: TButton;
    BtnPost: TButton;

  private
    { Private declarations }
  public

  end;

implementation

{$R *.dfm}

end.
