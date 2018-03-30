inherited ConexaoIBO: TConexaoIBO
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  object ConexaoBanco: TIB_Connection
    PasswordStorage = psParams
    SQLDialect = 3
    Params.Strings = (
      'USER NAME=SYSDBA'
      'FORCED WRITES=TRUE'
      'SQL DIALECT=3'
      'PASSWORD=masterkey')
    Left = 96
    Top = 56
  end
end
