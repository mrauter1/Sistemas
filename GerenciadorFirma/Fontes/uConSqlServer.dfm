inherited ConSqlServer: TConSqlServer
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 159
  Width = 246
  inherited FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=MSSQL'
      'Password=28021990'
      'Server=10.0.0.201,1433'
      'Protocol=TCPIP'
      'Port=3051'
      'User_Name=user'
      'Database=Logistec')
    ResourceOptions.AssignedValues = [rvAutoConnect, rvAutoReconnect, rvKeepConnection]
    Connected = True
    Left = 113
    Top = 56
  end
end
