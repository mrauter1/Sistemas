object Con: TCon
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 239
  Width = 394
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
end
