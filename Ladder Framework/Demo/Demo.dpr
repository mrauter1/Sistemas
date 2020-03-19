program Demo;

uses
  Vcl.Forms,
  UntDaoUtils,
  uDmConnection in '..\..\utils\uDmConnection.pas' {DmConnection: TDataModule},
  uAppConfig in '..\..\utils\uAppConfig.pas',
  Utils in '..\..\utils\Utils.pas',
  FrmInterfaces in '..\..\utils\FrmInterfaces.pas',
  UntDemo in 'UntDemo.pas' {FormDemo},
  uGlobals in 'uGlobals.pas',
  uConSqlServer in '..\..\utils\uConSqlServer.pas' {ConSqlServer: TDataModule};

{$R *.res}

begin

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormDemo, FormDemo);
  Application.CreateForm(TConSqlServer, ConSqlServer);
  //  TDaoUtils.Connection:= DataModule1.DB_SF;
  Inicializar(ConSqlServer);

  Application.Run;
end.
