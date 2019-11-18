object Con: TCon
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 283
  Width = 500
  object TimerRelatorios: TTimer
    Left = 96
    Top = 144
  end
  object QryRelatorios: TFDQuery
    Left = 248
    Top = 144
  end
  object CdsGatilhos: TClientDataSet
    PersistDataPacket.Data = {
      460000009619E0BD0100000018000000020000000000030000004600044E6F6D
      6501004900000001000557494454480200020064000A556C74696D6145786563
      08000800000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    AfterPost = CdsGatilhosAfterPost
    Left = 96
    Top = 40
    object CdsGatilhosNome: TStringField
      FieldName = 'Nome'
      Size = 100
    end
    object CdsGatilhosUltimaExec: TDateTimeField
      FieldName = 'UltimaExec'
    end
  end
  object QrySimilares: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      #9#9'/* Adiciona produtos que ficam estocados nos tanques em KG */'
      #9'WITH cteSimilares AS'
      #9'('
      #9#9'select'
      #9#9' p.CodProduto as Cod1, '
      #9#9' p.APRESENTACAO as A1,'
      #9#9' p2.CodProduto AS COD2,'
      #9#9' P2.APRESENTACAO as a2'
      #9#9'from Produto P'
      #9#9'inner join PRODUTO P2 on p2.CODGRUPOSUB = P.CODGRUPOSUB '
      #9#9#9#9#9#9#9'and p2.CODAPLICACAO = p2.CODAPLICACAO '
      #9#9#9#9#9#9#9'and P2.CodProduto <> p.CodProduto '
      
        #9#9#9#9#9#9#9'and cast(P2.CODAPLICACAO as int) between 1001 and 1027 /*' +
        'Apenas nos tanques*/'
      
        #9#9#9#9#9#9#9'AND'#9'dbo.SubUnidadeQuilo(P2.NOMESUBUNIDADE) = 1 -- Apenas ' +
        'Em KG'
      
        #9#9'where cast(P.CODAPLICACAO as int) between 1001 and 1027 /*Apen' +
        'as nos tanques*/'
      #9#9#9'  AND'#9'dbo.SubUnidadeQuilo(P.NOMESUBUNIDADE) = 1'
      
        #9#9#9'  and not exists(select * from Similares S where S.COD1 = P.C' +
        'ODPRODUTO and S.COD2 = P2.CODPRODUTO)'
      #9'),'
      #9'EQUIVALENTES AS'
      #9'('
      #9#9'select Cod1, Cod2 from cteSimilares s1 '
      
        #9#9'where not exists(select * from cteSimilares s2 where s2.Cod1 =' +
        ' s1.COD2 and s2.COD2 = s1.Cod1 and s2.Cod1 < s1.Cod1)'
      #9')'
      #9'select * from EQUIVALENTES')
    Left = 248
    Top = 40
    object QrySimilaresCod1: TStringField
      FieldName = 'Cod1'
      Origin = 'Cod1'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QrySimilaresCod2: TStringField
      FieldName = 'Cod2'
      Origin = 'Cod2'
      Required = True
      FixedChar = True
      Size = 6
    end
  end
  object QryInsumosSugeridos: TFDQuery
    Connection = ConSqlServer.FDConnection
    SQL.Strings = (
      
        'select X.*, (select apresentacao from PRODUTO where CODPRODUTO =' +
        ' InsumoSugerido) as NomeInsumoSugerido, ep.ESTOQUEATUAL'
      'from '
      '('
      
        'SELECT PI.APRESENTACAO as ProInsumo, pi.CODPRODUTO as CodInsumo,' +
        ' '
      '    case when ep.ESTOQUEATUAL = 0 then'
      
        #9#9'IsNull((SELECT TOP 1 S.Cod1 FROM Similares S inner join EstoqP' +
        'rodutos ep on ep.CodProduto = S.Cod1 and ep.ESTOQUEATUAL > 0'
      
        #9#9' where s.Cod2 = PI.CODPRODUTO order by ep.ESTOQUEATUAL desc), ' +
        'pi.codproduto)'
      #9'else PI.CODPRODUTO end as InsumoSugerido'
      'FROM PRODUTO PI '
      'inner join EstoqProdutos ep on ep.CodProduto = PI.CODPRODUTO'
      'where PI.CODPRODUTO in (select CodProduto from Insumos_Insumo) '
      ')X'
      'inner join EstoqProdutos ep on ep.CodProduto = X.InsumoSugerido'
      'where X.CodInsumo <> X.InsumoSugerido'
      'ORDER BY ProInsumo')
    Left = 392
    Top = 40
    object QryInsumosSugeridosProInsumo: TStringField
      FieldName = 'ProInsumo'
      Origin = 'ProInsumo'
      Size = 80
    end
    object QryInsumosSugeridosCodInsumo: TStringField
      FieldName = 'CodInsumo'
      Origin = 'CodInsumo'
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryInsumosSugeridosInsumoSugerido: TStringField
      FieldName = 'InsumoSugerido'
      Origin = 'InsumoSugerido'
      ReadOnly = True
      Required = True
      FixedChar = True
      Size = 6
    end
    object QryInsumosSugeridosNomeInsumoSugerido: TStringField
      FieldName = 'NomeInsumoSugerido'
      Origin = 'NomeInsumoSugerido'
      ReadOnly = True
      Size = 80
    end
    object QryInsumosSugeridosESTOQUEATUAL: TBCDField
      FieldName = 'ESTOQUEATUAL'
      Origin = 'ESTOQUEATUAL'
      Precision = 18
    end
  end
end
