inherited DmConnection1: TDmConnection1
  Height = 502
  Width = 510
  inherited FDConnection: TFDConnection
    Connected = True
  end
  object SqlEmpresa: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select *'
      'from Cliente where CodCliente = 010000')
    Left = 80
    Top = 176
    object SqlEmpresaCODCLIENTE: TStringField
      FieldName = 'CODCLIENTE'
      Origin = 'CODCLIENTE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaCODVENDEDOR: TStringField
      FieldName = 'CODVENDEDOR'
      Origin = 'CODVENDEDOR'
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaCODVENDEDOR2: TStringField
      FieldName = 'CODVENDEDOR2'
      Origin = 'CODVENDEDOR2'
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaCODVENDEDOR3: TStringField
      FieldName = 'CODVENDEDOR3'
      Origin = 'CODVENDEDOR3'
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaCODREGIAO: TStringField
      FieldName = 'CODREGIAO'
      Origin = 'CODREGIAO'
      FixedChar = True
      Size = 4
    end
    object SqlEmpresaCODSUBREGIAO: TStringField
      FieldName = 'CODSUBREGIAO'
      Origin = 'CODSUBREGIAO'
      FixedChar = True
      Size = 4
    end
    object SqlEmpresaCODROTEIRO: TStringField
      FieldName = 'CODROTEIRO'
      Origin = 'CODROTEIRO'
      FixedChar = True
      Size = 4
    end
    object SqlEmpresaCODROTEIROSUB: TStringField
      FieldName = 'CODROTEIROSUB'
      Origin = 'CODROTEIROSUB'
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaCODTIPOCLI: TStringField
      FieldName = 'CODTIPOCLI'
      Origin = 'CODTIPOCLI'
      FixedChar = True
      Size = 2
    end
    object SqlEmpresaFILIALCLIENTE: TStringField
      FieldName = 'FILIALCLIENTE'
      Origin = 'FILIALCLIENTE'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaSITUACAOCLI: TStringField
      FieldName = 'SITUACAOCLI'
      Origin = 'SITUACAOCLI'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaCLASSECLI: TStringField
      FieldName = 'CLASSECLI'
      Origin = 'CLASSECLI'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaNOMECLIENTE: TStringField
      FieldName = 'NOMECLIENTE'
      Origin = 'NOMECLIENTE'
      Size = 40
    end
    object SqlEmpresaRAZAOSOCIAL: TStringField
      FieldName = 'RAZAOSOCIAL'
      Origin = 'RAZAOSOCIAL'
      Size = 80
    end
    object SqlEmpresaBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      FixedChar = True
      Size = 25
    end
    object SqlEmpresaCIDADE: TStringField
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      FixedChar = True
      Size = 35
    end
    object SqlEmpresaESTADO: TStringField
      FieldName = 'ESTADO'
      Origin = 'ESTADO'
      FixedChar = True
      Size = 2
    end
    object SqlEmpresaCODIGOPOSTAL: TStringField
      FieldName = 'CODIGOPOSTAL'
      Origin = 'CODIGOPOSTAL'
      FixedChar = True
      Size = 8
    end
    object SqlEmpresaNUMEROCGCMF: TStringField
      FieldName = 'NUMEROCGCMF'
      Origin = 'NUMEROCGCMF'
      FixedChar = True
      Size = 16
    end
    object SqlEmpresaNUMEROINSC: TStringField
      FieldName = 'NUMEROINSC'
      Origin = 'NUMEROINSC'
      FixedChar = True
      Size = 16
    end
    object SqlEmpresaNUMEROISSQN: TStringField
      FieldName = 'NUMEROISSQN'
      Origin = 'NUMEROISSQN'
      FixedChar = True
      Size = 10
    end
    object SqlEmpresaNUMEROCPF: TStringField
      FieldName = 'NUMEROCPF'
      Origin = 'NUMEROCPF'
      FixedChar = True
      Size = 12
    end
    object SqlEmpresaPESSOA: TStringField
      FieldName = 'PESSOA'
      Origin = 'PESSOA'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaCODBANCO: TStringField
      FieldName = 'CODBANCO'
      Origin = 'CODBANCO'
      FixedChar = True
      Size = 3
    end
    object SqlEmpresaPRACACIDADE: TStringField
      FieldName = 'PRACACIDADE'
      Origin = 'PRACACIDADE'
      FixedChar = True
      Size = 35
    end
    object SqlEmpresaPRACAESTADO: TStringField
      FieldName = 'PRACAESTADO'
      Origin = 'PRACAESTADO'
      FixedChar = True
      Size = 2
    end
    object SqlEmpresaPRACACEP: TStringField
      FieldName = 'PRACACEP'
      Origin = 'PRACACEP'
      FixedChar = True
      Size = 8
    end
    object SqlEmpresaENTREGACIDADE: TStringField
      FieldName = 'ENTREGACIDADE'
      Origin = 'ENTREGACIDADE'
      FixedChar = True
      Size = 35
    end
    object SqlEmpresaENTREGAESTADO: TStringField
      FieldName = 'ENTREGAESTADO'
      Origin = 'ENTREGAESTADO'
      FixedChar = True
      Size = 2
    end
    object SqlEmpresaENTREGACEP: TStringField
      FieldName = 'ENTREGACEP'
      Origin = 'ENTREGACEP'
      FixedChar = True
      Size = 8
    end
    object SqlEmpresaCODTRANSPORTADORA: TStringField
      FieldName = 'CODTRANSPORTADORA'
      Origin = 'CODTRANSPORTADORA'
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaLIMITECREDITO: TBCDField
      FieldName = 'LIMITECREDITO'
      Origin = 'LIMITECREDITO'
      Precision = 18
      Size = 2
    end
    object SqlEmpresaCODCONDICAO: TStringField
      FieldName = 'CODCONDICAO'
      Origin = 'CODCONDICAO'
      FixedChar = True
      Size = 3
    end
    object SqlEmpresaDATAULTIMACOMPRA: TDateField
      FieldName = 'DATAULTIMACOMPRA'
      Origin = 'DATAULTIMACOMPRA'
    end
    object SqlEmpresaDATAINCLUSAO: TDateField
      FieldName = 'DATAINCLUSAO'
      Origin = 'DATAINCLUSAO'
    end
    object SqlEmpresaCODLISTAPRECO: TStringField
      FieldName = 'CODLISTAPRECO'
      Origin = 'CODLISTAPRECO'
      FixedChar = True
      Size = 4
    end
    object SqlEmpresaTEMCONVENIO: TStringField
      FieldName = 'TEMCONVENIO'
      Origin = 'TEMCONVENIO'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaOBSERVACAO: TMemoField
      FieldName = 'OBSERVACAO'
      Origin = 'OBSERVACAO'
      BlobType = ftMemo
    end
    object SqlEmpresaCLISENTOICM: TStringField
      FieldName = 'CLISENTOICM'
      Origin = 'CLISENTOICM'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaCLISENTOSUBST: TStringField
      FieldName = 'CLISENTOSUBST'
      Origin = 'CLISENTOSUBST'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaCLISENTOIPI: TStringField
      FieldName = 'CLISENTOIPI'
      Origin = 'CLISENTOIPI'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaCONTRIBUINTE: TStringField
      FieldName = 'CONTRIBUINTE'
      Origin = 'CONTRIBUINTE'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaCONTRIBUINTEBOX: TStringField
      FieldName = 'CONTRIBUINTEBOX'
      Origin = 'CONTRIBUINTEBOX'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaCLISENTOICM8702: TStringField
      FieldName = 'CLISENTOICM8702'
      Origin = 'CLISENTOICM8702'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaOBSDANOTA: TStringField
      FieldName = 'OBSDANOTA'
      Origin = 'OBSDANOTA'
      Size = 100
    end
    object SqlEmpresaCODDOMEDICO: TStringField
      FieldName = 'CODDOMEDICO'
      Origin = 'CODDOMEDICO'
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaDIAMAISVENCIMENTO: TIntegerField
      FieldName = 'DIAMAISVENCIMENTO'
      Origin = 'DIAMAISVENCIMENTO'
    end
    object SqlEmpresaCODIGOAUXILIAR: TStringField
      FieldName = 'CODIGOAUXILIAR'
      Origin = 'CODIGOAUXILIAR'
      FixedChar = True
      Size = 11
    end
    object SqlEmpresaPRACABAIRRO: TStringField
      FieldName = 'PRACABAIRRO'
      Origin = 'PRACABAIRRO'
      FixedChar = True
      Size = 25
    end
    object SqlEmpresaENTREGABAIRRO: TStringField
      FieldName = 'ENTREGABAIRRO'
      Origin = 'ENTREGABAIRRO'
      FixedChar = True
      Size = 25
    end
    object SqlEmpresaCOBRABLOQUETO: TStringField
      FieldName = 'COBRABLOQUETO'
      Origin = 'COBRABLOQUETO'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaDESCONTODECANAL: TCurrencyField
      FieldName = 'DESCONTODECANAL'
      Origin = 'DESCONTODECANAL'
    end
    object SqlEmpresaMICROEMPRESA: TStringField
      FieldName = 'MICROEMPRESA'
      Origin = 'MICROEMPRESA'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaSIMPLESESTADUAL: TStringField
      FieldName = 'SIMPLESESTADUAL'
      Origin = 'SIMPLESESTADUAL'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaTIPOFRETECLI: TStringField
      FieldName = 'TIPOFRETECLI'
      Origin = 'TIPOFRETECLI'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaNAOPROTESTAR: TStringField
      FieldName = 'NAOPROTESTAR'
      Origin = 'NAOPROTESTAR'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaINCLUIDOVIAPALM: TStringField
      FieldName = 'INCLUIDOVIAPALM'
      Origin = 'INCLUIDOVIAPALM'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaDESATIVADIASCOMPRA: TIntegerField
      FieldName = 'DESATIVADIASCOMPRA'
      Origin = 'DESATIVADIASCOMPRA'
    end
    object SqlEmpresaLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Required = True
      Size = 60
    end
    object SqlEmpresaLOGNUMERO: TStringField
      FieldName = 'LOGNUMERO'
      Origin = 'LOGNUMERO'
      Required = True
      Size = 10
    end
    object SqlEmpresaLOGCOMPL: TStringField
      FieldName = 'LOGCOMPL'
      Origin = 'LOGCOMPL'
      Required = True
      Size = 30
    end
    object SqlEmpresaPRACALOGRADOURO: TStringField
      FieldName = 'PRACALOGRADOURO'
      Origin = 'PRACALOGRADOURO'
      Required = True
      Size = 60
    end
    object SqlEmpresaPRACALOGNUMERO: TStringField
      FieldName = 'PRACALOGNUMERO'
      Origin = 'PRACALOGNUMERO'
      Required = True
      Size = 10
    end
    object SqlEmpresaPRACALOGCOMPL: TStringField
      FieldName = 'PRACALOGCOMPL'
      Origin = 'PRACALOGCOMPL'
      Required = True
      Size = 30
    end
    object SqlEmpresaENTREGALOGRADOURO: TStringField
      FieldName = 'ENTREGALOGRADOURO'
      Origin = 'ENTREGALOGRADOURO'
      Required = True
      Size = 60
    end
    object SqlEmpresaENTREGALOGNUMERO: TStringField
      FieldName = 'ENTREGALOGNUMERO'
      Origin = 'ENTREGALOGNUMERO'
      Required = True
      Size = 10
    end
    object SqlEmpresaENTREGALOGCOMPL: TStringField
      FieldName = 'ENTREGALOGCOMPL'
      Origin = 'ENTREGALOGCOMPL'
      Required = True
      Size = 30
    end
    object SqlEmpresaENDERECO: TStringField
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 102
    end
    object SqlEmpresaPRACAENDERECO: TStringField
      FieldName = 'PRACAENDERECO'
      Origin = 'PRACAENDERECO'
      Size = 102
    end
    object SqlEmpresaENTREGAENDERECO: TStringField
      FieldName = 'ENTREGAENDERECO'
      Origin = 'ENTREGAENDERECO'
      Size = 102
    end
    object SqlEmpresaCODCLIENTEMATRIZ: TStringField
      FieldName = 'CODCLIENTEMATRIZ'
      Origin = 'CODCLIENTEMATRIZ'
      Required = True
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaCLISENTOPISCOFINS: TStringField
      FieldName = 'CLISENTOPISCOFINS'
      Origin = 'CLISENTOPISCOFINS'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaCODPAIS: TStringField
      FieldName = 'CODPAIS'
      Origin = 'CODPAIS'
      Required = True
      FixedChar = True
      Size = 3
    end
    object SqlEmpresaDATAVENCELIMITE: TDateField
      FieldName = 'DATAVENCELIMITE'
      Origin = 'DATAVENCELIMITE'
    end
    object SqlEmpresaPEDIDOMINIMO: TBCDField
      FieldName = 'PEDIDOMINIMO'
      Origin = 'PEDIDOMINIMO'
      Precision = 18
      Size = 2
    end
    object SqlEmpresaCODCOMPROVANTE: TStringField
      FieldName = 'CODCOMPROVANTE'
      Origin = 'CODCOMPROVANTE'
      FixedChar = True
      Size = 3
    end
    object SqlEmpresaDATAALTERACAO: TSQLTimeStampField
      FieldName = 'DATAALTERACAO'
      Origin = 'DATAALTERACAO'
    end
    object SqlEmpresaCODVENDEDOR4: TStringField
      FieldName = 'CODVENDEDOR4'
      Origin = 'CODVENDEDOR4'
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaCODVENDEDOR5: TStringField
      FieldName = 'CODVENDEDOR5'
      Origin = 'CODVENDEDOR5'
      FixedChar = True
      Size = 6
    end
    object SqlEmpresaNUMEROSUFRAMA: TStringField
      FieldName = 'NUMEROSUFRAMA'
      Origin = 'NUMEROSUFRAMA'
      FixedChar = True
      Size = 9
    end
    object SqlEmpresaDESCONTAICMSPRO_SN: TStringField
      FieldName = 'DESCONTAICMSPRO_SN'
      Origin = 'DESCONTAICMSPRO_SN'
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaNIVEL_TABELA_PISCOF: TStringField
      FieldName = 'NIVEL_TABELA_PISCOF'
      Origin = 'NIVEL_TABELA_PISCOF'
      Required = True
      FixedChar = True
      Size = 1
    end
    object SqlEmpresaINDPRES: TSmallintField
      FieldName = 'INDPRES'
      Origin = 'INDPRES'
    end
    object SqlEmpresaIDESTRANGEIRO: TStringField
      FieldName = 'IDESTRANGEIRO'
      Origin = 'IDESTRANGEIRO'
      FixedChar = True
    end
    object SqlEmpresaCONSUMIDOR_FINAL: TIntegerField
      FieldName = 'CONSUMIDOR_FINAL'
      Origin = 'CONSUMIDOR_FINAL'
    end
    object SqlEmpresaINDIEDEST: TSmallintField
      FieldName = 'INDIEDEST'
      Origin = 'INDIEDEST'
    end
    object SqlEmpresaEXCEDEU_SUBLIMITE_SIMPLES_SN: TStringField
      FieldName = 'EXCEDEU_SUBLIMITE_SIMPLES_SN'
      Origin = 'EXCEDEU_SUBLIMITE_SIMPLES_SN'
      FixedChar = True
      Size = 1
    end
  end
end
