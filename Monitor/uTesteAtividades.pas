unit uTesteAtividades;

interface

uses
  Ladder.Activity.Classes;

type
  TTesteAtividades = class
  private
    FAtividade: TAtividade;
  public
    procedure Setup;
    procedure TearDown;

    procedure TestaAtividade;
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
    FTesteAtividades.TestaAtividade;
//    FTesteAtividades.TestaAtividadeEmail;

    FTesteAtividades.TearDown;
  finally
    FTesteAtividades.Free;
  end;
end;

procedure TTesteAtividades.Setup;
var
  FProcesso: TProcessoBase;
  FOutput: TOutputBase;
begin
  FAtividade:= TAtividade.Create;
  FAtividade.ID:= 1;
  FAtividade.Descricao:= 'Teste envio de email';
  FAtividade.Inputs.Add(TInputBase.Create('Titulo', tbString, 'email de teste'));

  FAtividade.Inputs.Add(TInputBase.Create('Body', tbString, 'Este é um email para testar a classe atividade, '+
                        'será enviada uma lista com as vendas com margem baixa de ontem.'));

  FProcesso:= TProcessoBase.Create;
  FProcesso.Nome:= 'Meta';
  FProcesso.Tipo:= tpConsultaPersonalizada;
  FProcesso.Inputs.Add(TInputBase.Create('NomeConsulta', tbString, 'MetaVendedores'));

  FOutput:= TOutputBase.Create;
  FOutput.Nome:= 'Grafico';
  FOutput.Parametros.Add(TInputBase.Create('Visualizacao', tbString, 'Realizado e Meta da Venda e Margem'));
  FOutput.Parametros.Add(TInputBase.Create('NomeArquivo', tbString, 'MetaVendedores.png'));
  FOutput.Parametros.Add(TInputBase.Create('TipoVisualizacao', tbString, 'GRAFICO'));
  FProcesso.Outputs.Add(FOutput);
  FOutput:= TOutputBase.Create;
  FOutput.Nome:= 'Tabela';
  FOutput.Parametros.Add(TInputBase.Create('Visualizacao', tbString, 'Realizado e Meta da Venda e Margem'));
  FOutput.Parametros.Add(TInputBase.Create('NomeArquivo', tbString, 'MetaVendedores.xls'));
  FOutput.Parametros.Add(TInputBase.Create('TipoVisualizacao', tbString, 'TABELA'));
  FProcesso.Outputs.Add(FOutput);

  FAtividade.Processos.Add(FProcesso);

  FAtividade.Inputs.Add(TInputBase.Create('Anexos', tbString, 'F:\Sistemas\Monitor\Test.txt'));
end;

procedure TTesteAtividades.TearDown;
begin
  FAtividade.Free;
end;

procedure TTesteAtividades.TestaAtividade;
begin
  FAtividade.Executar;
end;

procedure TTesteAtividades.TestaAtividadeEmail;
var
  FProcessoEmail: TProcessoBase;
begin
  FProcessoEmail:= TProcessoBase.Create;
  FProcessoEmail.Tipo:= tpEnvioEmail;
  FProcessoEmail.Nome:= 'ProcEnviaEmail';
  FProcessoEmail.Inputs.Add(TInputBase.Create('Destinatarios', tbString, '@Vendedores.Destinarios'));
  FProcessoEmail.Inputs.Add(TInputBase.Create('Assunto', tbString, 'Email de teste'));
  FProcessoEmail.Inputs.Add(TInputBase.Create('Corpo', tbString, 'Corpo do email'));
  FProcessoEmail.Inputs.Add(TInputBase.Create('Anexos', tbLista, '[@Meta.Grafico, @Meta.Tabela]'));
  FAtividade.Processos.Add(FProcessoEmail);
end;

end.
