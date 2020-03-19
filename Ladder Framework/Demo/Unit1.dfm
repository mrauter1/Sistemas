object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 377
  Width = 593
  object DB_SF: TADOConnection
    CommandTimeout = 999999999
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=sf@2012!@#$;Persist Security Info=T' +
      'rue;User ID=studio_fiscal;Initial Catalog=HOMOLOGACAO319;Data So' +
      'urce=127.0.0.1;Use Procedure for Prepare=1;Auto Translate=True;P' +
      'acket Size=4096;Workstation ID=000104PC;Use Encryption for Data=' +
      'False;Tag with column collation when possible=False'
    ConnectionTimeout = 999999999
    DefaultDatabase = 'HOMOLOGACAO319'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 140
    Top = 91
  end
end
