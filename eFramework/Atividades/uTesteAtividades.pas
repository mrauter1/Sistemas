unit uTesteAtividades;

interface

uses
  UntClasses, uConClasses;

type
  TTesteAtividades = class
  private
    FAtividade: TAtividade;
  public
    procedure Setup;
    procedure TearDown;

    procedure TestaAtividadeEmail;
  end;

procedure ExecutaTestes;

implementation

{ TTesteAtividades }

procedure ExecutaTestes;
var
  FTesteAtividades: TTesteAtividades;
begin
  FTesteAtividades:= TTesteAtividades.Create;
  try
    FTesteAtividades.Setup;
    FTesteAtividades.TestaAtividadeEmail;
    FTesteAtividades.TearDown;
  finally
    FTesteAtividades.Free;
  end;
end;

procedure TTesteAtividades.Setup;
var
  FProcesso: TProcessoBase;
  FInput: TParametroCon;
  FOutput: TOutputBase;
begin
  FAtividade:= TAtividade.Create;
  FAtividade.ID:= 1;
  FAtividade.Descricao:= 'Teste envio de email';
  FAtividade.Inputs.Add(
    TParametroCon.Create('Titulo', 'email de teste', ptTexto, 'Título do email', ''));

  FAtividade.Inputs.Add(
    TParametroCon.Create('Body', 'Este é um email para testar a classe atividade, será enviada uma lista com as vendas com margem baixa de ontem.', ptTexto, 'Corpo do email', ''));

  FProcesso:= TProcessoBase.Create;
  FProcesso.Tipo:= tpConsultaPersonalizada;
  FInput:= TParametroCon.Create('NomeConsulta', 'MetaVendedores', ptTexto, 'Meta Vendedores', '');
  FProcesso.Inputs.Add(FInput);

  FOutput:= TOutputBase.Create;
  FOutput.Tipo:= toGrafico;
  FOutput.Parametros.Add(TParametroCon.Create('Visualizacao', 'Realizado e Meta da Venda e Margem', ptTexto, 'Visualização', ''));
  FOutput.Parametros.Add(TParametroCon.Create('NomeArquivo', 'MetaVendedores.png', ptTexto, 'Nome Arquivo', ''));
  FProcesso.Outputs.Add(FOutput);
  FOutput:= TOutputBase.Create;
  FOutput.Tipo:= toTabela;
  FOutput.Parametros.Add(TParametroCon.Create('Visualizacao', 'Realizado e Meta da Venda e Margem', ptTexto, 'Visualização', ''));
  FOutput.Parametros.Add(TParametroCon.Create('NomeArquivo', 'MetaVendedores.xls', ptTexto, 'Nome Arquivo', ''));
  FProcesso.Outputs.Add(FOutput);

  FAtividade.Processos.Add(FProcesso);

  FAtividade.Inputs.Add(
    TParametroCon.Create('Anexos', 'F:\Sistemas\Monitor\Test.txt', ptCheckListBox, 'Lista de anexos', ''));
end;

procedure TTesteAtividades.TearDown;
begin
  FAtividade.Free;
end;

procedure TTesteAtividades.TestaAtividadeEmail;
begin
  FAtividade.Executar;
end;

end.
