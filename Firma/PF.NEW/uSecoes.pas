unit uSecoes;

interface

uses
  System.Classes, uDmDados, SysUtils;

type
  TTipoCampo = (tcAlfaNumerico, tcNumerico, tcData);

  TSecao = class(TObject)
  private
    procedure VerificaTexto(PosIni: Integer);
  public
    Texto: String;
    constructor Create;
    procedure CampoAlfa(Valor: String; PosIni, Tamanho: Integer);
    procedure CampoNumerico(Valor: Double; PosIni, Tamanho: Integer; Decimais: Integer);
    procedure CampoData(Valor: TDate; PosIni, Tamanho: Integer);
  end;

  TExecutor = class(TObject)
  private
    function DemonstrativoGeral: String;
    function MovimentacaoNacional: String;
    function UtilizacaoParaProducao: String;
    procedure UtilizadoParaConsumo;
    function GetTipoTransporte(pCodTransportadora: String): String;
  protected
  public
     Ano: Word;
     Mes: Word;
     Conteudo: TStringList;
     NomeArquivo: String;
     constructor Create(pDiretorio: String; pAno: Word; pMes: Word);
     destructor Destroy;
     function Empresa: String;
     function GetAnoStr: String;
     function GetMesStr: String;
     procedure Executar;
  end;

implementation

{ TSessao }

uses DateUtils, uFormIdentificacao;

procedure TSecao.CampoAlfa(Valor: String; PosIni, Tamanho: Integer);
var
  FResult: String;
begin
  VerificaTexto(PosIni);

  FResult:= Copy(Valor, 0, Tamanho);

  Texto:= Texto + FResult.PadRight(Tamanho);
end;

procedure TSecao.VerificaTexto(PosIni: Integer);
begin
  if Length(Texto)+1 <> PosIni then
    raise Exception.Create('Posição do texto inválida!');
end;

procedure TSecao.CampoData(Valor: TDate; PosIni, Tamanho: Integer);
var
  FDataStr: String;
begin
  VerificaTexto(PosIni);

  if Tamanho <> 10 then
    raise Exception.Create('TSecao.CampoData: Tamanho de campo data tem deve ser 10!');

  FDataStr:= FormatDateTime('dd/mm/yyyy', Valor);

  Texto:= Texto+FDataStr;
end;

procedure TSecao.CampoNumerico(Valor: Double; PosIni, Tamanho,
  Decimais: Integer);

  function RetornaMascara: String;
  const
    cMascara = '###,###,###,##0';
  var
    FMascara: String;
  begin
    if Decimais > 0 then
      FMascara:= cMascara+'.0'.PadRight(Decimais+1, '0')
    else
      FMascara:= cMascara;

    Result:= FMascara.Substring(Length(FMascara)-Tamanho);
  end;

begin
  VerificaTexto(PosIni);

  Texto:= Texto + FormatFloat(RetornaMascara, Valor).PadLeft(Tamanho, '0');

//  raise Exception.Create('Não implementado');
end;

constructor TSecao.Create;
begin
  inherited Create;
  Texto:= '';
end;

{ TExecutor }

 { 3.1.1 }
function TExecutor.Empresa: String;

  function BoolToInt(Bool: Boolean): Integer;
  begin
    if Bool then Result:= 1 else Result:= 0;
  end;

begin
  with TSecao.Create do
  try
    CampoAlfa('EM', 1, 2); {Tipo}
    CampoAlfa(DmDados.EmpresaNUMEROCGCMF.AsString, 3, 14); {CNPJ}
    CampoAlfa(GetMesStr, 17, 3); {Mês}
    CampoAlfa(GetAnoStr, 20, 4); {Ano}
    CampoNumerico(BoolToInt(FormIdentificacaoEmpresa.ComercializacaoNacional), 24, 1, 0); {Comercialização Nacional}
    CampoNumerico(BoolToInt(FormIdentificacaoEmpresa.ComercializacaoInternacional), 25, 1, 0); {Comercialização Internacional}
    CampoNumerico(BoolToInt(FormIdentificacaoEmpresa.Producao), 26, 1, 0); {Produção}
    CampoNumerico(BoolToInt(FormIdentificacaoEmpresa.Transformacao), 27, 1, 0); {Transformação}
    CampoNumerico(BoolToInt(FormIdentificacaoEmpresa.Consumo), 28, 1, 0); {Consumo}
    CampoNumerico(BoolToInt(FormIdentificacaoEmpresa.Fabricacao), 29, 1, 0); {Fabricação}
    CampoNumerico(BoolToInt(FormIdentificacaoEmpresa.Transporte), 30, 1, 0); {Transporte}
    CampoNumerico(BoolToInt(FormIdentificacaoEmpresa.Armazenamento), 31, 1, 0); {Armazenamento}
    Conteudo.Add(Texto);
  finally
    Free;
  end;
end;

procedure TExecutor.Executar;
begin
  DmDados.RecarregarDataSets;

  Conteudo.Clear;
  Empresa;
  DemonstrativoGeral;
  MovimentacaoNacional;
  Conteudo.SaveToFile(NomeArquivo);
//  UtilizacaoParaProducao;
  
end;

function TExecutor.GetAnoStr: String;
begin
  Result:= IntToStr(Ano);
end;

function TExecutor.GetMesStr: String;
begin
  case Mes of
    1: Result:= 'JAN';
    2: Result:= 'FEV';
    3: Result:= 'MAR';
    4: Result:= 'ABR';
    5: Result:= 'MAI';
    6: Result:= 'JUN';
    7: Result:= 'JUL';
    8: Result:= 'AGO';
    9: Result:= 'SET';
    10: Result:= 'OUT';
    11: Result:= 'NOV';
    12: Result:= 'DEZ';
  else
    raise Exception.Create('Mês inválido');  
  end;
end;

 { 3.1.2 }
function TExecutor.DemonstrativoGeral: String;

  procedure ProdutoControlado;
  begin
    DmDados.ProdutoControlado.First;
    while not DmDados.ProdutoControlado.Eof do
    begin
      with TSecao.Create do
      try
        CampoAlfa('PR', 1, 2); {Tipo}
        CampoAlfa(DmDados.GetCodPF(DmDados.ProdutoControladoCodGrupoSub.AsString), 3, 11); {NCM}
        CampoAlfa(DmDados.ProdutoControladoNOMESUBGRUPO.AsString, 14, 70); {Nome Comercial}
        CampoNumerico(DmDados.GetConc(DmDados.ProdutoControladoCodGrupoSub.AsString), 84, 3, 0); {Concentração}
        CampoNumerico(DmDados.ProdutoControladoDensidade.AsFloat, 87, 5, 2); {Densidade}
        Conteudo.Add(Texto);
        DmDados.ProdutoControlado.Next;
      finally
        Free;
      end;
    end;
  end;
(*
  procedure ProdutoComposto;

    procedure SubstanciaControlada;
    begin
      with TSecao.Create do
      try
        Campo('SC', 1, 2, tcAlfaNumerico); {Tipo}
        Campo(DmDados.SubstanciaControladaCODMERCOSULNCM.AsString, 2, 11, tcAlfaNumerico); {NCM}
        Campo(GetConcentracao(DmDados.SubstanciaControladaCODPRODUTO.AsString), 14, 2, tcNumerico); {Concentração}
        Conteudo.Add(Texto);
      finally
        Free;
      end;
    end;

  begin
    with TSecao.Create do
    try
      Campo('PC', 1, 2, tcAlfaNumerico); {Tipo}
      Campo(DmDados.ProdutoCompostoCODMERCOSULNCM.AsString, 3, 10, tcAlfaNumerico); {NCM}
      Campo(DmDados.ProdutoCompostoNOMESUBGRUPO.AsString, 13, 70, tcAlfaNumerico); {Nome Comercial do Produto}
      Campo(GetDensidade(DmDados.ProdutoCompostoCODPRODUTO.AsString), 83, 5, tcNumerico); {Densidade}
      Conteudo.Add(Texto);
    finally
      Free;
    end;
  end;   *)

begin
  with TSecao.Create do
  try
    CampoAlfa('DG', 1, 2); {Tipo}
    Conteudo.Add(Texto);

    ProdutoControlado;
  finally
    Free;
  end;
end;

function TExecutor.GetTipoTransporte(pCodTransportadora: String): String;
begin
  if DmDados.ListaTransp.IndexOf(pCodTransportadora) >= 0 then
    Result:= 'F' // Fornecedor
  else if pCodTransportadora = '000001' then
    Result:= 'A' // Adquirente
  else
    Result:= 'T';

end;

{ 3.1.3 }
function TExecutor.MovimentacaoNacional: String;

  { 3.1.3.1 }
  procedure SubsecaoMovimento;
  var
    FChaveNF, FCodPro: String;
    FDensidade: Double;
    FDadosMovPro: TDadosMovPro;
  begin
    FChaveNF:= DmDados.MovimentacaoCHAVENF.AsString;

    while (FChaveNF = DmDados.MovimentacaoChaveNF.AsString) and
          (DmDados.Movimentacao.Eof = False) do
    begin
      FDadosMovPro:= DmDados.ObterDadosMovPro;

      with TSecao.Create do
      try
        CampoAlfa('MM', 1, 2); {Tipo}
        CampoAlfa('PR'+FDadosMovPro.CodPF, 3, 13); {NCM}
        CampoNumerico(FDadosMovPro.Concentracao, 16, 3, 0); {Concentração}
        CampoNumerico(FDadosMovPro.Densidade, 19, 5, 2); {Densidade}
        CampoNumerico(FDadosMovPro.Quantidade, 24, 15, 3); {Quantidade}
        CampoAlfa(FDadosMovPro.UnidadeMedida, 39, 1); {Unidade de Medida}
        Conteudo.Add(Texto);
      finally
        Free;
      end;
      DmDados.Movimentacao.Next;
    end;
    if DmDados.Movimentacao.Eof = False then
      DmDados.Movimentacao.Prior; // Volta para os dados do mesmo movimento
  end;

  { 3.1.3.2 }
  procedure SubsecaoTransporte;
  var
    FDadosTransporte: TDadosTransporte;
  begin
    FDadosTransporte:= DmDados.ObterDadosTransporte(DmDados.MovimentacaoCODTRANSPORTADORA.AsString);
    with TSecao.Create do
    try
      CampoAlfa('MT', 1, 2); {Tipo}
      CampoAlfa(FDadosTransporte.CNPJ, 3, 14); {CNPJ da Transporteadora}
      CampoAlfa(FDadosTransporte.RazaoSocial, 17, 70); {Razão Social transportadora}
      Conteudo.Add(Texto);
    finally
      Free;
    end;
  end;


  { 3.1.3.3 }
  procedure SubsecaoArmazenagem;
  var
    FDadosArmazenadora: TDadosArmazenadora;
  begin
//    FDadosArmazenadora:= DmDados.ObterDadosArmazenadora(DmDados.MovimentacaoCodCliFor.AsString);
    FDadosArmazenadora:= DmDados.ObterDadosArmazenadora;
    with TSecao.Create do
    try
      CampoAlfa('MA', 1, 2); {Tipo}
      CampoAlfa(FDadosArmazenadora.CNPJ, 3, 14); {CNPJ da Armazenadora}
      CampoAlfa(FDadosArmazenadora.RazaoSocial, 17, 70); {Razão Social Armazenadora}
      CampoAlfa(FDadosArmazenadora.Endereco, 87, 70); {Endereço Armazenadora}
      CampoAlfa(FDadosArmazenadora.CEP, 157, 10); {CEP Armazenadora}
      CampoAlfa(FDadosArmazenadora.Numero, 167, 5); {Número da Armazenadora}
      CampoAlfa(FDadosArmazenadora.Complemento, 172, 20); {Complemento do Endereço}
      CampoAlfa(FDadosArmazenadora.Bairro, 192, 30); {Bairro da Armazenadora}
      CampoAlfa(FDadosArmazenadora.UF, 222, 2); {UF da Armazenadora}
      CampoAlfa(FDadosArmazenadora.CodMunicipio, 224, 7); {Município da Armazenadora}
      Conteudo.Add(Texto);
    finally
      Free;
    end;
  end;

var
  FOperacao, FArmazenagem, FEntradaSaida, FTipoTransporte: String;
begin
  DmDados.Movimentacao.First;
  while not DmDados.Movimentacao.Eof do
  begin
    with TSecao.Create do
    try
      CampoAlfa('MVN', 1, 3); {Tipo}

      FEntradaSaida:= DmDados.MovimentacaoENTRADASAIDA.AsString;
      CampoAlfa(FEntradaSaida, 4, 1); {Entrada - Saída}

      if FEntradaSaida = 'E' then FOperacao:= 'EC' else FOperacao:= 'SV';
      CampoAlfa(FOperacao, 5, 2); {Operação}

      CampoAlfa(DmDados.MovimentacaoNumeroCGCMF.AsString, 7, 14); {CNPJ Adquirente/Fornecedor}
      CampoAlfa(DmDados.MovimentacaoRazaoSocial.AsString, 21, 69); {Razão Social}
      CampoAlfa(DmDados.MovimentacaoNumero.AsString, 90, 10); {Numero NF}
      CampoData(DmDados.MovimentacaoDataComprovante.AsDateTime, 100, 10); {Data Emissão NF}

      if FEntradaSaida = 'S' then FArmazenagem:= 'F' else FArmazenagem:= 'N';
      CampoAlfa(FArmazenagem, 110, 1); {Armazenagem}

      FTipoTransporte:= GetTipoTransporte(DmDados.MovimentacaoCODTRANSPORTADORA.AsString);
      if (FEntradaSaida = 'E') and (FTipoTransporte = 'F') then FTipoTransporte:= 'A';
      CampoAlfa(FTipoTransporte, 111, 1); {Transporte}

      Conteudo.Add(Texto);

      SubsecaoMovimento;

      if FEntradaSaida = 'S' then // Apenas para saídas
        SubsecaoArmazenagem;

      if FTipoTransporte = 'T' then
        SubsecaoTransporte;

    finally
      Free;
    end;
    DmDados.Movimentacao.Next;
  end;
end;

  { 3.1.5 }
function TExecutor.UtilizacaoParaProducao: String;

  { 3.1.5.1 }
  procedure ProdutoFinalProduzido;
  begin
    raise Exception.Create('ProdutoFinalProduzido: Não implementado');
    with TSecao.Create do
    try
      CampoAlfa('UF', 1, 2); {Tipo}
      CampoAlfa('', 3, 13); {NCM}
      CampoNumerico(0, 16, 3, 0); {Concentração}
      CampoNumerico(0, 19, 5, 2); {Densidade}
      CampoNumerico(0, 24, 15, 3); {Quantidade}
      CampoAlfa('', 39, 1); {Unidade de Medida}
      CampoAlfa('', 40, 200); {Descrição da Produção}
      CampoData(Now, 240, 10); {Data da produção}
      Conteudo.Add(Texto);
    finally
      Free;
    end;
  end;

begin
  raise Exception.Create('UtilizacaoParaProducao: Não implementado');
  with TSecao.Create do
  try
    CampoAlfa('', 1, 2); {Tipo}
    CampoAlfa('', 3, 13); {NCM}
    CampoNumerico(0, 16, 3, 0); {Concentração}
    CampoNumerico(0, 19, 5, 2); {Densidade}
    CampoNumerico(0, 24, 15, 3); {Quantidade}
    CampoAlfa('', 39, 1); {Unidade de Medida}
    Conteudo.Add(Texto);
  finally
    Free;
  end;
end;

{ 3.1.7 }
procedure TExecutor.UtilizadoParaConsumo;
begin
  raise Exception.Create('UtilizadoParaConsumo: Não Implementado!');
  with TSecao.Create do
  try
    CampoAlfa('', 1, 2); {Tipo}
    CampoAlfa('', 3, 13); {NCM}
    CampoNumerico(0, 16, 3, 0); {Concentração}
    CampoNumerico(0, 19, 5, 2); {Densidade}
    CampoNumerico(0, 24, 15, 3); {Quantidade}
    CampoAlfa('', 39, 1); {Unidade de Medida}
    CampoAlfa('', 40, 1); {Código do Consumo}
    CampoData(Now, 41, 62); {Observação do Consumo}
    CampoData(Now, 102, 10); {Data do Consumo}
    Conteudo.Add(Texto);
  finally
    Free;
  end;
end;

destructor TExecutor.Destroy;
begin
  Conteudo.Free;
  inherited;
end;

constructor TExecutor.Create(pDiretorio: String; pAno: Word; pMes: Word);
begin
  inherited Create;

  DmDados.Empresa.Open;

  Ano:= pAno;
  Mes:= pMes;
  NomeArquivo:= IncludeTrailingPathDelimiter(pDiretorio)+'M'+GetAnoStr+GetMesStr+DmDados.EmpresaNUMEROCGCMF.AsString+'.txt';

  Conteudo:= TStringList.Create;
end;

end.
