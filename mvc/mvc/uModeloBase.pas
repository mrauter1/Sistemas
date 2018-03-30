unit uModeloBase;

interface

uses
  SysUtils, Classes;

type
  EInformaErro = class (Exception);

  TModeloBase = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
