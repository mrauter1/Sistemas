inherited ConSqlServer: TConSqlServer
  OldCreateOrder = True
  Height = 159
  Width = 246
  inherited FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=MSSQL'
      'Password=28021990'
      'Server=127.0.0.1'
      'Protocol=TCPIP'
      'Port=1433'
      'User_Name=user'
      'Database=Logistec')
    ResourceOptions.AssignedValues = [rvAutoConnect, rvAutoReconnect, rvKeepConnection]
    Connected = True
    Left = 113
    Top = 56
  end
end
