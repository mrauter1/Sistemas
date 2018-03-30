inherited ConexaoDBX: TConexaoDBX
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 178
  Width = 265
  object ConexaoBanco: TSQLConnection
    ConnectionName = 'FBCONNECTION'
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=database.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Left = 40
    Top = 48
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from pedidoitem'
      '')
    SQLConnection = ConexaoBanco
    Left = 152
    Top = 48
  end
end
