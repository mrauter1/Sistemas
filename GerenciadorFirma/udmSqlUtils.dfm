object DmSqlUtils: TDmSqlUtils
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 226
  Width = 305
  object SQLConnection: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=127.0.0.1:F:\DADOS\BANCO_447.FDB'
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
    Left = 112
    Top = 48
  end
end
