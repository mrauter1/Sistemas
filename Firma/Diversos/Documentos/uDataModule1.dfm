object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 539
  Top = 230
  Height = 284
  Width = 415
  object CdsOrcamento: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 8
    object CdsOrcamentoNumero: TStringField
      DisplayLabel = 'NUMERO'
      FieldName = 'Numero'
      Size = 100
    end
    object CdsOrcamentoDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object CdsOrcamentoPRAZO: TStringField
      FieldName = 'PRAZO'
    end
    object CdsOrcamentoFRETE: TStringField
      FieldName = 'FRETE'
      Size = 100
    end
    object CdsOrcamentoENTREGA: TStringField
      FieldName = 'ENTREGA'
      Size = 100
    end
    object CdsOrcamentoOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 999
    end
    object CdsOrcamentoEMPNOME: TStringField
      FieldName = 'EMPNOME'
      Size = 100
    end
    object CdsOrcamentoEMPENDERECO: TStringField
      FieldName = 'EMPENDERECO'
      Size = 255
    end
    object CdsOrcamentoEMPFONE: TStringField
      FieldName = 'EMPFONE'
      Size = 14
    end
    object CdsOrcamentoEMPFAX: TStringField
      FieldName = 'EMPFAX'
      Size = 14
    end
    object CdsOrcamentoEMPCEP: TStringField
      DisplayWidth = 9
      FieldName = 'EMPCEP'
      Size = 9
    end
    object CdsOrcamentoEMPCNPJ: TStringField
      FieldName = 'EMPCNPJ'
    end
    object CdsOrcamentoEMPIE: TStringField
      FieldName = 'EMPIE'
      Size = 12
    end
    object CdsOrcamentoVENNOME: TStringField
      FieldName = 'VENNOME'
      Size = 100
    end
    object CdsOrcamentoVENFONE: TStringField
      FieldName = 'VENFONE'
      Size = 14
    end
    object CdsOrcamentoVENEMAIL: TStringField
      FieldName = 'VENEMAIL'
      Size = 14
    end
    object CdsOrcamentoCLINOME: TStringField
      FieldName = 'CLINOME'
      Size = 100
    end
    object CdsOrcamentoCLIENDERECO: TStringField
      FieldName = 'CLIENDERECO'
      Size = 255
    end
    object CdsOrcamentoCLICONTATO: TStringField
      FieldName = 'CLICONTATO'
      Size = 100
    end
    object CdsOrcamentoCLIEMAIL: TStringField
      FieldName = 'CLIEMAIL'
      Size = 100
    end
  end
  object CdsOrcamentoPro: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 56
    object CdsOrcamentoProNUMERO: TStringField
      FieldName = 'ORCNUMERO'
      Size = 100
    end
    object CdsOrcamentoProNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object CdsOrcamentoProEMBALAGEM: TStringField
      FieldName = 'EMBALAGEM'
      Size = 100
    end
    object CdsOrcamentoProVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object CdsOrcamentoProSITTRIB: TStringField
      FieldName = 'SITTRIB'
    end
    object CdsOrcamentoProIPI: TStringField
      FieldName = 'IPI'
    end
    object CdsOrcamentoProICMS: TStringField
      FieldName = 'ICMS'
    end
  end
end
