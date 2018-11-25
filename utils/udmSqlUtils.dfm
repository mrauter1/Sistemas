object DmSqlUtils: TDmSqlUtils
  OldCreateOrder = False
  Height = 175
  Width = 305
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'Password=masterkey'
      'Server=10.0.0.201'
      'Protocol=TCPIP'
      'Port=3051'
      'User_Name=SYSDBA'
      'Database=E:\Dados\BANCO.FDB')
    ResourceOptions.AssignedValues = [rvAutoConnect, rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    AfterCommit = FDConnectionAfterCommit
    Left = 137
    Top = 64
  end
end
