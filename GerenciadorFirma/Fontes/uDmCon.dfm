object DmCon: TDmCon
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 159
  Width = 246
  object FDConSqlServer: TFDConnection
    Params.Strings = (
      'DriverID=MSSQL'
      'Server=(local)'
      'Database=Logistec'
      'User_Name=user'
      'Password=28021990')
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
    Left = 111
    Top = 48
  end
end
