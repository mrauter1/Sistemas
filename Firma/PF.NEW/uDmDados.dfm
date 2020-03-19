inherited DmDados: TDmDados
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 502
  Width = 510
  inherited FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=MSSQL'
      'Password=28021990'
      'Server=10.0.0.201,1433'
      'Protocol=TCPIP'
      'Port=3051'
      'User_Name=user'
      'Database=Logistec')
    Connected = True
    Left = 369
    Top = 40
  end
  object Empresa: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select *'
      'from Cliente where CodCliente = '#39'010000'#39)
    Left = 40
    Top = 40
    object EmpresaCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Required = True
      FixedChar = True
      Size = 6
    end
    object EmpresaCODVENDEDOR: TStringField
      FieldName = 'CODVENDEDOR'
      FixedChar = True
      Size = 6
    end
    object EmpresaCODVENDEDOR2: TStringField
      FieldName = 'CODVENDEDOR2'
      FixedChar = True
      Size = 6
    end
    object EmpresaCODVENDEDOR3: TStringField
      FieldName = 'CODVENDEDOR3'
      FixedChar = True
      Size = 6
    end
    object EmpresaCODREGIAO: TStringField
      FieldName = 'CODREGIAO'
      FixedChar = True
      Size = 4
    end
    object EmpresaCODSUBREGIAO: TStringField
      FieldName = 'CODSUBREGIAO'
      FixedChar = True
      Size = 4
    end
    object EmpresaCODROTEIRO: TStringField
      FieldName = 'CODROTEIRO'
      FixedChar = True
      Size = 4
    end
    object EmpresaCODROTEIROSUB: TStringField
      FieldName = 'CODROTEIROSUB'
      FixedChar = True
      Size = 6
    end
    object EmpresaCODTIPOCLI: TStringField
      FieldName = 'CODTIPOCLI'
      FixedChar = True
      Size = 2
    end
    object EmpresaFILIALCLIENTE: TStringField
      FieldName = 'FILIALCLIENTE'
      FixedChar = True
      Size = 1
    end
    object EmpresaSITUACAOCLI: TStringField
      FieldName = 'SITUACAOCLI'
      FixedChar = True
      Size = 1
    end
    object EmpresaCLASSECLI: TStringField
      FieldName = 'CLASSECLI'
      FixedChar = True
      Size = 1
    end
    object EmpresaNOMECLIENTE: TStringField
      FieldName = 'NOMECLIENTE'
      Size = 40
    end
    object EmpresaRAZAOSOCIAL: TStringField
      FieldName = 'RAZAOSOCIAL'
      Size = 80
    end
    object EmpresaBAIRRO: TStringField
      FieldName = 'BAIRRO'
      FixedChar = True
      Size = 25
    end
    object EmpresaCIDADE: TStringField
      FieldName = 'CIDADE'
      FixedChar = True
      Size = 35
    end
    object EmpresaESTADO: TStringField
      FieldName = 'ESTADO'
      FixedChar = True
      Size = 2
    end
    object EmpresaCODIGOPOSTAL: TStringField
      FieldName = 'CODIGOPOSTAL'
      FixedChar = True
      Size = 8
    end
    object EmpresaNUMEROCGCMF: TStringField
      FieldName = 'NUMEROCGCMF'
      FixedChar = True
      Size = 16
    end
    object EmpresaNUMEROINSC: TStringField
      FieldName = 'NUMEROINSC'
      FixedChar = True
      Size = 16
    end
    object EmpresaNUMEROISSQN: TStringField
      FieldName = 'NUMEROISSQN'
      FixedChar = True
      Size = 10
    end
    object EmpresaNUMEROCPF: TStringField
      FieldName = 'NUMEROCPF'
      FixedChar = True
      Size = 12
    end
    object EmpresaPESSOA: TStringField
      FieldName = 'PESSOA'
      FixedChar = True
      Size = 1
    end
    object EmpresaCODBANCO: TStringField
      FieldName = 'CODBANCO'
      FixedChar = True
      Size = 3
    end
    object EmpresaPRACACIDADE: TStringField
      FieldName = 'PRACACIDADE'
      FixedChar = True
      Size = 35
    end
    object EmpresaPRACAESTADO: TStringField
      FieldName = 'PRACAESTADO'
      FixedChar = True
      Size = 2
    end
    object EmpresaPRACACEP: TStringField
      FieldName = 'PRACACEP'
      FixedChar = True
      Size = 8
    end
    object EmpresaENTREGACIDADE: TStringField
      FieldName = 'ENTREGACIDADE'
      FixedChar = True
      Size = 35
    end
    object EmpresaENTREGAESTADO: TStringField
      FieldName = 'ENTREGAESTADO'
      FixedChar = True
      Size = 2
    end
    object EmpresaENTREGACEP: TStringField
      FieldName = 'ENTREGACEP'
      FixedChar = True
      Size = 8
    end
    object EmpresaCODTRANSPORTADORA: TStringField
      FieldName = 'CODTRANSPORTADORA'
      FixedChar = True
      Size = 6
    end
    object EmpresaLIMITECREDITO: TBCDField
      FieldName = 'LIMITECREDITO'
      Precision = 18
      Size = 2
    end
    object EmpresaCODCONDICAO: TStringField
      FieldName = 'CODCONDICAO'
      FixedChar = True
      Size = 3
    end
    object EmpresaDATAULTIMACOMPRA: TDateField
      FieldName = 'DATAULTIMACOMPRA'
    end
    object EmpresaDATAINCLUSAO: TDateField
      FieldName = 'DATAINCLUSAO'
    end
    object EmpresaCODLISTAPRECO: TStringField
      FieldName = 'CODLISTAPRECO'
      FixedChar = True
      Size = 4
    end
    object EmpresaTEMCONVENIO: TStringField
      FieldName = 'TEMCONVENIO'
      FixedChar = True
      Size = 1
    end
    object EmpresaOBSERVACAO: TMemoField
      FieldName = 'OBSERVACAO'
      BlobType = ftMemo
    end
    object EmpresaCLISENTOICM: TStringField
      FieldName = 'CLISENTOICM'
      FixedChar = True
      Size = 1
    end
    object EmpresaCLISENTOSUBST: TStringField
      FieldName = 'CLISENTOSUBST'
      FixedChar = True
      Size = 1
    end
    object EmpresaCLISENTOIPI: TStringField
      FieldName = 'CLISENTOIPI'
      FixedChar = True
      Size = 1
    end
    object EmpresaCONTRIBUINTE: TStringField
      FieldName = 'CONTRIBUINTE'
      FixedChar = True
      Size = 1
    end
    object EmpresaCONTRIBUINTEBOX: TStringField
      FieldName = 'CONTRIBUINTEBOX'
      FixedChar = True
      Size = 1
    end
    object EmpresaCLISENTOICM8702: TStringField
      FieldName = 'CLISENTOICM8702'
      FixedChar = True
      Size = 1
    end
    object EmpresaOBSDANOTA: TStringField
      FieldName = 'OBSDANOTA'
      Size = 100
    end
    object EmpresaCODDOMEDICO: TStringField
      FieldName = 'CODDOMEDICO'
      FixedChar = True
      Size = 6
    end
    object EmpresaDIAMAISVENCIMENTO: TIntegerField
      FieldName = 'DIAMAISVENCIMENTO'
    end
    object EmpresaCODIGOAUXILIAR: TStringField
      FieldName = 'CODIGOAUXILIAR'
      FixedChar = True
      Size = 11
    end
    object EmpresaPRACABAIRRO: TStringField
      FieldName = 'PRACABAIRRO'
      FixedChar = True
      Size = 25
    end
    object EmpresaENTREGABAIRRO: TStringField
      FieldName = 'ENTREGABAIRRO'
      FixedChar = True
      Size = 25
    end
    object EmpresaCOBRABLOQUETO: TStringField
      FieldName = 'COBRABLOQUETO'
      FixedChar = True
      Size = 1
    end
    object EmpresaDESCONTODECANAL: TBCDField
      FieldName = 'DESCONTODECANAL'
      Precision = 9
      Size = 2
    end
    object EmpresaMICROEMPRESA: TStringField
      FieldName = 'MICROEMPRESA'
      FixedChar = True
      Size = 1
    end
    object EmpresaSIMPLESESTADUAL: TStringField
      FieldName = 'SIMPLESESTADUAL'
      FixedChar = True
      Size = 1
    end
    object EmpresaTIPOFRETECLI: TStringField
      FieldName = 'TIPOFRETECLI'
      FixedChar = True
      Size = 1
    end
    object EmpresaNAOPROTESTAR: TStringField
      FieldName = 'NAOPROTESTAR'
      FixedChar = True
      Size = 1
    end
    object EmpresaINCLUIDOVIAPALM: TStringField
      FieldName = 'INCLUIDOVIAPALM'
      FixedChar = True
      Size = 1
    end
    object EmpresaDESATIVADIASCOMPRA: TIntegerField
      FieldName = 'DESATIVADIASCOMPRA'
    end
    object EmpresaLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Required = True
      Size = 60
    end
    object EmpresaLOGNUMERO: TStringField
      FieldName = 'LOGNUMERO'
      Required = True
      Size = 10
    end
    object EmpresaLOGCOMPL: TStringField
      FieldName = 'LOGCOMPL'
      Required = True
      Size = 30
    end
    object EmpresaPRACALOGRADOURO: TStringField
      FieldName = 'PRACALOGRADOURO'
      Required = True
      Size = 60
    end
    object EmpresaPRACALOGNUMERO: TStringField
      FieldName = 'PRACALOGNUMERO'
      Required = True
      Size = 10
    end
    object EmpresaPRACALOGCOMPL: TStringField
      FieldName = 'PRACALOGCOMPL'
      Required = True
      Size = 30
    end
    object EmpresaENTREGALOGRADOURO: TStringField
      FieldName = 'ENTREGALOGRADOURO'
      Required = True
      Size = 60
    end
    object EmpresaENTREGALOGNUMERO: TStringField
      FieldName = 'ENTREGALOGNUMERO'
      Required = True
      Size = 10
    end
    object EmpresaENTREGALOGCOMPL: TStringField
      FieldName = 'ENTREGALOGCOMPL'
      Required = True
      Size = 30
    end
    object EmpresaENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 102
    end
    object EmpresaPRACAENDERECO: TStringField
      FieldName = 'PRACAENDERECO'
      Size = 102
    end
    object EmpresaENTREGAENDERECO: TStringField
      FieldName = 'ENTREGAENDERECO'
      Size = 102
    end
    object EmpresaCODCLIENTEMATRIZ: TStringField
      FieldName = 'CODCLIENTEMATRIZ'
      Required = True
      FixedChar = True
      Size = 6
    end
    object EmpresaCLISENTOPISCOFINS: TStringField
      FieldName = 'CLISENTOPISCOFINS'
      FixedChar = True
      Size = 1
    end
    object EmpresaCODPAIS: TStringField
      FieldName = 'CODPAIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object EmpresaDATAVENCELIMITE: TDateField
      FieldName = 'DATAVENCELIMITE'
    end
    object EmpresaPEDIDOMINIMO: TBCDField
      FieldName = 'PEDIDOMINIMO'
      Precision = 18
      Size = 2
    end
    object EmpresaCODCOMPROVANTE: TStringField
      FieldName = 'CODCOMPROVANTE'
      FixedChar = True
      Size = 3
    end
    object EmpresaDATAALTERACAO: TSQLTimeStampField
      FieldName = 'DATAALTERACAO'
    end
    object EmpresaCODVENDEDOR4: TStringField
      FieldName = 'CODVENDEDOR4'
      FixedChar = True
      Size = 6
    end
    object EmpresaCODVENDEDOR5: TStringField
      FieldName = 'CODVENDEDOR5'
      FixedChar = True
      Size = 6
    end
    object EmpresaNUMEROSUFRAMA: TStringField
      FieldName = 'NUMEROSUFRAMA'
      FixedChar = True
      Size = 9
    end
    object EmpresaDESCONTAICMSPRO_SN: TStringField
      FieldName = 'DESCONTAICMSPRO_SN'
      FixedChar = True
      Size = 1
    end
    object EmpresaNIVEL_TABELA_PISCOF: TStringField
      FieldName = 'NIVEL_TABELA_PISCOF'
      Required = True
      FixedChar = True
      Size = 1
    end
    object EmpresaINDPRES: TSmallintField
      FieldName = 'INDPRES'
    end
    object EmpresaIDESTRANGEIRO: TStringField
      FieldName = 'IDESTRANGEIRO'
      FixedChar = True
    end
    object EmpresaCONSUMIDOR_FINAL: TIntegerField
      FieldName = 'CONSUMIDOR_FINAL'
    end
    object EmpresaINDIEDEST: TSmallintField
      FieldName = 'INDIEDEST'
    end
    object EmpresaEXCEDEU_SUBLIMITE_SIMPLES_SN: TStringField
      FieldName = 'EXCEDEU_SUBLIMITE_SIMPLES_SN'
      FixedChar = True
      Size = 1
    end
  end
  object ProdutoControlado: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select '
      #9'gs.CODGRUPOSUB,'
      '                gs.CodGrupo,'
      #9'gs.NOMESUBGRUPO,'
      #9'p.CodMercosulNCM,'
      #9'Peso / NullIf(Litros,0) as Densidade'
      'from GrupoSub gs '
      
        'inner join produto p on p.CODPRODUTO = (select top 1 p2.CODPRODU' +
        'TO from PRODUTO p2 '
      
        #9#9#9#9#9#9'where p2.CODAPLICACAO = '#39'0000'#39' and gs.CodGrupoSub = p2.Cod' +
        'GrupoSub)'
      'where 1=1'
      '/*Grupos*/'
      'order by NomeSubGrupo')
    Left = 216
    Top = 40
    object ProdutoControladoCODGRUPOSUB: TStringField
      FieldName = 'CODGRUPOSUB'
      Origin = 'CODGRUPOSUB'
      Required = True
      FixedChar = True
      Size = 7
    end
    object ProdutoControladoNOMESUBGRUPO: TStringField
      FieldName = 'NOMESUBGRUPO'
      Origin = 'NOMESUBGRUPO'
      FixedChar = True
      Size = 30
    end
    object ProdutoControladoCodMercosulNCM: TStringField
      FieldName = 'CodMercosulNCM'
      Origin = 'CodMercosulNCM'
      FixedChar = True
      Size = 9
    end
    object ProdutoControladoDensidade: TFMTBCDField
      FieldName = 'Densidade'
      Origin = 'Densidade'
      ReadOnly = True
      Precision = 38
      Size = 18
    end
    object ProdutoControladoCodGrupo: TStringField
      FieldName = 'CodGrupo'
      Origin = 'CodGrupo'
      FixedChar = True
      Size = 3
    end
  end
  object Movimentacao: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT *'
      'FROM'
      '('
      #9'SELECT '
      #9' '#39'S'#39' AS ENTRADASAIDA,'
      #9' M.CHAVENF,'
      #9'  m.Numero,'
      '                 m.CodCliente as CodCliFor,'
      #9'  M.DataComprovante,'
      #9'  C.NUMEROCGCMF,'
      #9'  C.RAZAOSOCIAL,'
      #9'  M.CODTRANSPORTADORA,'
      #9'  p.NomeSubUnidade,'
      #9'  p.CodAplicacao,'
      #9'  P.CodGrupoSub,'
      #9'  mp.CodProduto,'
      #9'  mp.Quantatendida,'
      '       mp.UNIDADEESTOQUE'
      #9'FROM MCLIPRO mp'
      #9'inner join MCLI M ON M.CHAVENF = MP.CHAVENF'
      #9'inner join PRODUTO P ON P.CODPRODUTO = MP.CODPRODUTO'
      #9'inner join CLIENTE C ON C.CODCLIENTE = M.CODCLIENTE'
      #9'WHERE 1=1'
      #9'/*ComprovantesVenda*/ /*data*/ /*Grupos*/'
      'UNION ALL'
      #9'SELECT '
      #9'  '#39'E'#39' AS ENTRADASAIDA,'
      #9'  M.CHAVENF,'
      #9'  m.Numero,'
      '                 M.CodFornecedor as CodCliFor,'
      #9'  M.DataComprovante,'
      #9'  F.NUMEROCGCMF,'
      #9'  F.RAZAOSOCIAL,'
      #9'  M.TRANCODTRANSPORTE AS CODTRANSPORTADORA,'
      #9'  p.NomeSubUnidade,'
      #9'  p.CodAplicacao,'
      #9'  P.CodGrupoSub,'
      #9'  mp.CodProduto,'
      #9'  mp.QUANT AS Quantatendida,'
      '   '#9' mp.UNIDADEESTOQUE'
      #9'FROM MFORPRO mp'
      #9'inner join MFOR M ON M.CHAVENF = MP.CHAVENF'
      #9'inner join PRODUTO P ON P.CODPRODUTO = MP.CODPRODUTO'
      #9'inner join FORNECED F ON F.CODFORNECEDOR = M.CODFORNECEDOR'
      #9'WHERE 1=1'
      #9'/*ComprovantesCompra*/ /*data*/ /*Grupos*/'
      ')X'
      'order by DataComprovante, EntradaSaida desc, ChaveNF, CodProduto')
    Left = 216
    Top = 168
    object MovimentacaoENTRADASAIDA: TStringField
      FieldName = 'ENTRADASAIDA'
      Origin = 'ENTRADASAIDA'
      ReadOnly = True
      Required = True
      Size = 1
    end
    object MovimentacaoCHAVENF: TStringField
      FieldName = 'CHAVENF'
      Origin = 'CHAVENF'
      ReadOnly = True
      Required = True
      FixedChar = True
      Size = 21
    end
    object MovimentacaoNumero: TStringField
      FieldName = 'Numero'
      Origin = 'Numero'
      ReadOnly = True
      FixedChar = True
      Size = 6
    end
    object MovimentacaoDataComprovante: TDateField
      FieldName = 'DataComprovante'
      Origin = 'DataComprovante'
      ReadOnly = True
    end
    object MovimentacaoNUMEROCGCMF: TStringField
      FieldName = 'NUMEROCGCMF'
      Origin = 'NUMEROCGCMF'
      ReadOnly = True
      FixedChar = True
      Size = 16
    end
    object MovimentacaoRAZAOSOCIAL: TStringField
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      ReadOnly = True
      Size = 80
    end
    object MovimentacaoCODTRANSPORTADORA: TStringField
      FieldName = 'CODTRANSPORTADORA'
      Origin = 'CODTRANSPORTADORA'
      ReadOnly = True
      FixedChar = True
      Size = 6
    end
    object MovimentacaoNomeSubUnidade: TStringField
      FieldName = 'NomeSubUnidade'
      Origin = 'NomeSubUnidade'
      ReadOnly = True
      FixedChar = True
      Size = 6
    end
    object MovimentacaoCodAplicacao: TStringField
      FieldName = 'CodAplicacao'
      Origin = 'CodAplicacao'
      ReadOnly = True
      FixedChar = True
      Size = 4
    end
    object MovimentacaoCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Origin = 'CodGrupoSub'
      ReadOnly = True
      FixedChar = True
      Size = 7
    end
    object MovimentacaoCodProduto: TStringField
      FieldName = 'CodProduto'
      Origin = 'CodProduto'
      ReadOnly = True
      Required = True
      FixedChar = True
      Size = 6
    end
    object MovimentacaoQuantatendida: TBCDField
      FieldName = 'Quantatendida'
      Origin = 'Quantatendida'
      ReadOnly = True
      Precision = 18
    end
    object MovimentacaoUNIDADEESTOQUE: TIntegerField
      FieldName = 'UNIDADEESTOQUE'
      Origin = 'UNIDADEESTOQUE'
      ReadOnly = True
    end
    object MovimentacaoCodCliFor: TStringField
      FieldName = 'CodCliFor'
      Origin = 'CodCliFor'
      ReadOnly = True
      FixedChar = True
      Size = 6
    end
  end
  object UtilizadoProducao: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select *'
      'from produzido')
    Left = 64
    Top = 168
    object UtilizadoProducaoCodOrdemProducao: TStringField
      FieldName = 'CodOrdemProducao'
      Origin = 'CodOrdemProducao'
      Required = True
      FixedChar = True
      Size = 6
    end
    object UtilizadoProducaoCodModelo: TIntegerField
      FieldName = 'CodModelo'
      Origin = 'CodModelo'
    end
    object UtilizadoProducaoCodProduto: TStringField
      FieldName = 'CodProduto'
      Origin = 'CodProduto'
      Required = True
      FixedChar = True
      Size = 6
    end
    object UtilizadoProducaoQuantAtendida: TBCDField
      FieldName = 'QuantAtendida'
      Origin = 'QuantAtendida'
      Precision = 18
    end
    object UtilizadoProducaoQuantAtendidaInsumos: TFMTBCDField
      FieldName = 'QuantAtendidaInsumos'
      Origin = 'QuantAtendidaInsumos'
      Precision = 38
      Size = 4
    end
    object UtilizadoProducaoNOMESUBUNIDADE: TStringField
      FieldName = 'NOMESUBUNIDADE'
      Origin = 'NOMESUBUNIDADE'
      FixedChar = True
      Size = 6
    end
    object UtilizadoProducaoPesoProduzido: TFMTBCDField
      FieldName = 'PesoProduzido'
      Origin = 'PesoProduzido'
      ReadOnly = True
      Precision = 38
      Size = 9
    end
    object UtilizadoProducaoPesoInsumos: TFMTBCDField
      FieldName = 'PesoInsumos'
      Origin = 'PesoInsumos'
      Precision = 38
      Size = 9
    end
    object UtilizadoProducaoLitrosProduzido: TFMTBCDField
      FieldName = 'LitrosProduzido'
      Origin = 'LitrosProduzido'
      ReadOnly = True
      Precision = 38
      Size = 11
    end
    object UtilizadoProducaoLitrosInsumos: TFMTBCDField
      FieldName = 'LitrosInsumos'
      Origin = 'LitrosInsumos'
      Precision = 38
      Size = 11
    end
  end
  object CdsConfGrupo: TClientDataSet
    PersistDataPacket.Data = {
      B70000009619E0BD020000001800000005000000000003000000B7000B436F64
      477275706F53756201004900000001000557494454480200020007000C4E6F6D
      65537562477275706F01004900000001000557494454480200020064000C436F
      6E63656E74726163616F080004000000000005436F6450460100490000000100
      0557494454480200020014000944656E73696461646512001200000002000844
      4543494D414C530200020004000557494454480200020020000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CodGrupoSub'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'NomeSubGrupo'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Concentracao'
        DataType = ftFloat
      end
      item
        Name = 'CodPF'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Densidade'
        DataType = ftFMTBcd
        Precision = 32
        Size = 4
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 72
    Top = 264
    object CdsConfGrupoCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Size = 7
    end
    object CdsConfGrupoNomeSubGrupo: TStringField
      FieldName = 'NomeSubGrupo'
      Size = 100
    end
    object CdsConfGrupoConcentracao: TFloatField
      FieldName = 'Concentracao'
    end
    object CdsConfGrupoDensidade: TFMTBCDField
      FieldName = 'Densidade'
      Precision = 32
      Size = 4
    end
    object CdsConfGrupoCodPF: TStringField
      FieldName = 'CodPF'
    end
  end
  object DS_ConfGrupo: TDataSource
    DataSet = CdsConfGrupo
    Left = 72
    Top = 360
  end
  object DS_ProdutoControlado: TDataSource
    AutoEdit = False
    DataSet = ProdutoControlado
    Left = 216
    Top = 88
  end
  object CdsErros: TClientDataSet
    PersistDataPacket.Data = {
      610000009619E0BD010000001800000003000000000003000000610007436F64
      4572726F040001000000000005536563616F0100490000000100055749445448
      020002006400084D656E736167656D0200490000000100055749445448020002
      002C010000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CodErro'
        DataType = ftInteger
      end
      item
        Name = 'Secao'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Mensagem'
        DataType = ftString
        Size = 300
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 360
    Top = 296
    object CdsErrosCodErro: TIntegerField
      FieldName = 'CodErro'
    end
    object CdsErrosSecao: TStringField
      FieldName = 'Secao'
      Size = 100
    end
    object CdsErrosMensagem: TStringField
      FieldName = 'Mensagem'
      Size = 300
    end
  end
  object Armazenadora: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT *, '
      '(select PF.CodigoIBGE(Estado, Municipio)) AS CodIBGE'
      'FROM'
      '(select '
      '  CodCliente,'
      '  C.RAZAOSOCIAL,'
      '  NUMEROCGCMF as CNPJ,'
      
        '  IsNull(NullIF(C.ENTREGALOGRADOURO,'#39#39'), LOGRADOURO) as Endereco' +
        ','
      
        '  PF.FormataCEP(ISNULL(NullIF(C.EntregaCEP, '#39#39'), C.CODIGOPOSTAL)' +
        ') as CEP,'
      '  ISNULL(NullIF(C.ENTREGALOGNUMERO, '#39#39'), C.LOGNUMERO) as Numero,'
      
        '  IsNull(NullIF(C.ENTREGALOGCOMPL, '#39#39'), C.LOGCOMPL) as Complemen' +
        'to,'
      '  ISNULL(NullIF(C.EntregaBairro, '#39#39'), C.BAIRRO) as Bairro,'
      '  ISNULL(NullIF(C.ENTREGAESTADO, '#39#39'), C.ESTADO) as Estado,'
      '  ISNULL(NullIF(C.ENTREGACIDADE, '#39#39'), C.Cidade) as Municipio'
      'from cliente C'
      'where CodCliente =:CodCliente'
      ')x'
      '')
    Left = 384
    Top = 168
    ParamData = <
      item
        Name = 'CODCLIENTE'
        DataType = ftString
        FDDataType = dtAnsiString
        ParamType = ptInput
      end>
    object ArmazenadoraCodCliente: TStringField
      FieldName = 'CodCliente'
      Origin = 'CodCliente'
      Required = True
      FixedChar = True
      Size = 6
    end
    object ArmazenadoraRAZAOSOCIAL: TStringField
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Size = 80
    end
    object ArmazenadoraCNPJ: TStringField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      FixedChar = True
      Size = 16
    end
    object ArmazenadoraEndereco: TStringField
      FieldName = 'Endereco'
      Origin = 'Endereco'
      ReadOnly = True
      Required = True
      Size = 60
    end
    object ArmazenadoraCEP: TMemoField
      FieldName = 'CEP'
      Origin = 'CEP'
      ReadOnly = True
      BlobType = ftMemo
      Size = 2147483647
    end
    object ArmazenadoraNumero: TStringField
      FieldName = 'Numero'
      Origin = 'Numero'
      ReadOnly = True
      Required = True
      Size = 10
    end
    object ArmazenadoraComplemento: TStringField
      FieldName = 'Complemento'
      Origin = 'Complemento'
      ReadOnly = True
      Required = True
      Size = 30
    end
    object ArmazenadoraBairro: TStringField
      FieldName = 'Bairro'
      Origin = 'Bairro'
      ReadOnly = True
      FixedChar = True
      Size = 25
    end
    object ArmazenadoraEstado: TStringField
      FieldName = 'Estado'
      Origin = 'Estado'
      ReadOnly = True
      FixedChar = True
      Size = 2
    end
    object ArmazenadoraMunicipio: TStringField
      FieldName = 'Municipio'
      Origin = 'Municipio'
      ReadOnly = True
      FixedChar = True
      Size = 35
    end
    object ArmazenadoraCodIBGE: TMemoField
      FieldName = 'CodIBGE'
      Origin = 'CodIBGE'
      ReadOnly = True
      BlobType = ftMemo
      Size = 2147483647
    end
  end
  object Transporte: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select NOMETRANSPORTE, '
      #9'   PF.NormalizaCNPJ(NUMEROCGC) as CNPJ'
      'from TRANSP'
      'where CodTransporte =:CodTransporte')
    Left = 384
    Top = 232
    ParamData = <
      item
        Name = 'CODTRANSPORTE'
        DataType = ftString
        FDDataType = dtAnsiString
        ParamType = ptInput
      end>
    object TransporteNOMETRANSPORTE: TStringField
      FieldName = 'NOMETRANSPORTE'
      Origin = 'NOMETRANSPORTE'
      FixedChar = True
      Size = 30
    end
    object TransporteCNPJ: TMemoField
      FieldName = 'CNPJ'
      Origin = 'CNPJ'
      ReadOnly = True
      BlobType = ftMemo
      Size = 2147483647
    end
  end
end
