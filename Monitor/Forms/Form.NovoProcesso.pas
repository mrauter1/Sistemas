unit Form.NovoProcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Ladder.Activity.Classes,
  Ladder.Activity.Manager, Ladder.ServiceLocator, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uConSqlServer, uConClasses,
  Ladder.Executor.ConsultaPersonalizada, Ladder.Executor.Email;

type
  TFormNovoProcesso = class(TForm)
    CbxExecutors: TComboBox;
    BtnOK: TBitBtn;
    QryConsulta: TFDQuery;
    QryConsultaID: TFDAutoIncField;
    QryConsultaNome: TStringField;
    QryConsultaDescricao: TStringField;
    QryConsultaSql: TMemoField;
    QryConsultaInfoExtendida: TMemoField;
    QryConsultaTipo: TIntegerField;
    QryConsultaConfigPadrao: TIntegerField;
    QryConsultaVisualizacaoPadrao: TIntegerField;
    QryConsultaIDPai: TIntegerField;
    QryConsultaFonteDados: TIntegerField;
    QryParametros: TFDQuery;
    QryParametrosID: TFDAutoIncField;
    QryParametrosConsulta: TIntegerField;
    QryParametrosNome: TStringField;
    QryParametrosDescricao: TStringField;
    QryParametrosTipo: TIntegerField;
    QryParametrosSql: TMemoField;
    QryParametrosOrdem: TIntegerField;
    QryParametrosTamanho: TIntegerField;
    QryParametrosObrigatorio: TBooleanField;
    QryParametrosValorPadrao: TMemoField;
    procedure FormCreate(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
  private
    { Private declarations }
    FActivityManager: TActivityManager;
    FParametros: TParametros;
    procedure SetParametrosConsulta(pConsultaID: Integer);
  public
    ResultClass: String;
    { Public declarations }
    class function SelecionaProcesso(out pParametros: TParametros): String; overload;
    class function SelecionaProcesso: String; overload;
  end;

implementation

{$R *.dfm}

uses
  Form.SelecionaConsulta;

procedure TFormNovoProcesso.SetParametrosConsulta(pConsultaID: Integer);
var
  FParametro: TParametroCon;
begin
  if pConsultaID = 0 then
    Exit;

  QryConsulta.Close;
  QryConsulta.ParamByName('ID').AsInteger:= pConsultaID;
  QryConsulta.Open;

  QryParametros.Close;
  QryParametros.ParamByName('IDConsulta').AsInteger:= pConsultaID;
  QryParametros.Open;

  while not QryParametros.Eof do
  begin
    FParametro:= TParametroCon.Create(QryParametrosNome.AsString, null, TTipoParametro(QryParametrosTipo.AsInteger),
                                      QryParametrosDescricao.AsString, QryParametrosSql.AsString);
    FParametro.ValorPadrao:= QryParametrosValorPadrao.AsString;

    if not Assigned(FParametros) then
      FParametros:= TParametros.Create;

    FParametros.Add(FParametro);

    QryParametros.Next;
  end;
end;

procedure TFormNovoProcesso.BtnOKClick(Sender: TObject);
var
  FExecutorClass: string;
  FConsultaID: Integer;
begin
  if CbxExecutors.Text = '' then
  begin
    ShowMessage('Selecione um tipo de processo.');
    Exit;
  end;

  for FExecutorClass in FActivityManager.ExecutorDictionary.Keys do
     if CbxExecutors.Text = FExecutorClass then
     begin
       ResultClass:= FExecutorClass;
       Break;
     end;

  if ResultClass = 'TExecutorConsultaPersonalizada' then
  begin
    FConsultaID:= TFormSelecionaConsulta.SelecionaConsulta;
    SetParametrosConsulta(FConsultaID);
  end;

  Close;
end;

procedure TFormNovoProcesso.FormCreate(Sender: TObject);
var
  FClass: String;
begin
  ResultClass:= '';

  FActivityManager:= TFrwServiceLocator.Context.ActivityManager;

  for FClass in FActivityManager.ExecutorDictionary.Keys do
     CbxExecutors.Items.Add(FClass);
end;

class function TFormNovoProcesso.SelecionaProcesso(
  out pParametros: TParametros): String;
var
  FForm: TFormNovoProcesso;
begin
  FForm:= TFormNovoProcesso.Create(nil);
  try
    FForm.ShowModal;
    pParametros:= FForm.FParametros;
    Result:= FForm.ResultClass;
  finally
    FForm.Free;
  end;
end;

class function TFormNovoProcesso.SelecionaProcesso: String;
var
  FParametros: TParametros;
begin
  Result:= SelecionaProcesso(FParametros);
  if Assigned(FParametros) then
    FParametros.Free;
end;

end.
