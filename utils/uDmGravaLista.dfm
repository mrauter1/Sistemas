object DmGravaLista: TDmGravaLista
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 318
  Width = 532
  object QryListaSidicom: TFDQuery
    Connection = ConFirebird.FDConnection
    SQL.Strings = (
      'select *'
      'from ListaPre'
      'where CodLista = :CodLista')
    Left = 336
    Top = 120
    ParamData = <
      item
        Name = 'CODLISTA'
        ParamType = ptInput
      end>
    object QryListaSidicomCODLISTA: TStringField
      FieldName = 'CODLISTA'
      Origin = 'CODLISTA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 4
    end
    object QryListaSidicomCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryListaSidicomPRECOCOMPRA: TBCDField
      FieldName = 'PRECOCOMPRA'
      Origin = 'PRECOCOMPRA'
      Precision = 18
    end
    object QryListaSidicomMARGEM: TBCDField
      FieldName = 'MARGEM'
      Origin = 'MARGEM'
      Precision = 18
    end
    object QryListaSidicomPRECOVENDA: TBCDField
      FieldName = 'PRECOVENDA'
      Origin = 'PRECOVENDA'
      Precision = 18
    end
    object QryListaSidicomPRECOANTERIOR: TBCDField
      FieldName = 'PRECOANTERIOR'
      Origin = 'PRECOANTERIOR'
      Precision = 18
    end
    object QryListaSidicomDATAALTERACAO: TDateField
      FieldName = 'DATAALTERACAO'
      Origin = 'DATAALTERACAO'
    end
    object QryListaSidicomHORAALTERACAO: TTimeField
      FieldName = 'HORAALTERACAO'
      Origin = 'HORAALTERACAO'
    end
    object QryListaSidicomDESCONTO: TCurrencyField
      FieldName = 'DESCONTO'
      Origin = 'DESCONTO'
    end
    object QryListaSidicomDESCONTOMAX: TCurrencyField
      FieldName = 'DESCONTOMAX'
      Origin = 'DESCONTOMAX'
    end
    object QryListaSidicomDESATIVADO: TStringField
      FieldName = 'DESATIVADO'
      Origin = 'DESATIVADO'
      FixedChar = True
      Size = 1
    end
    object QryListaSidicomPRECODOLAR: TBCDField
      FieldName = 'PRECODOLAR'
      Origin = 'PRECODOLAR'
      Precision = 18
    end
    object QryListaSidicomACRECIMOLISTA: TCurrencyField
      FieldName = 'ACRECIMOLISTA'
      Origin = 'ACRECIMOLISTA'
    end
    object QryListaSidicomCUSTOSLISTA: TCurrencyField
      FieldName = 'CUSTOSLISTA'
      Origin = 'CUSTOSLISTA'
    end
    object QryListaSidicomCODFAIXA_DESC_LOTE: TIntegerField
      FieldName = 'CODFAIXA_DESC_LOTE'
      Origin = 'CODFAIXA_DESC_LOTE'
    end
  end
  object QryListaReal: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      'Select p.apresentacao, l.*, GS.CodGrupo'
      'from lista.PrecoProdutoIcm(:IcmPisCofins, getdate()) l'
      'inner join PRODUTO p on p.CODPRODUTO = l.CODPRODUTO'
      'inner join GrupoSub GS on GS.CodGrupoSub =  P.CodGrupoSub'
      'order by CodGrupoSub, CodAplicacao')
    Left = 144
    Top = 120
    ParamData = <
      item
        Name = 'ICMPISCOFINS'
        DataType = ftCurrency
        FDDataType = dtCurrency
        ParamType = ptInput
      end>
    object QryListaRealapresentacao: TStringField
      FieldName = 'apresentacao'
      Origin = 'apresentacao'
      Size = 80
    end
    object QryListaRealCODPRODUTO: TStringField
      FieldName = 'CODPRODUTO'
      Origin = 'CODPRODUTO'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryListaRealCodGrupoSub: TStringField
      FieldName = 'CodGrupoSub'
      Origin = 'CodGrupoSub'
      Required = True
      FixedChar = True
      Size = 7
    end
    object QryListaRealCodAplicacao: TStringField
      FieldName = 'CodAplicacao'
      Origin = 'CodAplicacao'
      Required = True
      FixedChar = True
      Size = 4
    end
    object QryListaRealCodGrupo: TStringField
      FieldName = 'CodGrupo'
      Origin = 'CodGrupo'
      FixedChar = True
      Size = 3
    end
    object QryListaRealTABELAICM: TStringField
      FieldName = 'TABELAICM'
      Required = True
      Size = 7
    end
    object QryListaRealPRECO: TFMTBCDField
      FieldName = 'PRECO'
      Origin = 'PRECO'
      ReadOnly = True
      Precision = 23
      Size = 7
    end
  end
end
