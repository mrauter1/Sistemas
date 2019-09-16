object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 193
  Width = 417
  object FDConFirebird: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'Password=masterkey'
      'Server=10.0.0.201'
      'Protocol=TCPIP'
      'Port=3051'
      'User_Name=SYSDBA'
      'Database=E:\DADOS\banco.fdb')
    Connected = True
    LoginPrompt = False
    Left = 104
    Top = 72
  end
  object FDConPostgres: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'Password=28021990'
      'Server=127.0.0.1'
      'Protocol=TCPIP'
      'Port=5432'
      'User_Name=postgres'
      'Database=Logitec')
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtWideString
        TargetDataType = dtAnsiString
      end
      item
        SourceDataType = dtMemo
        TargetDataType = dtWideString
      end>
    Connected = True
    LoginPrompt = False
    Left = 284
    Top = 72
  end
end
