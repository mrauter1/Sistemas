object Dtm_DNF: TDtm_DNF
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 336
  Top = 192
  Height = 330
  Width = 418
  object Connnection: TSQLConnection
    ConnectionName = 'IBConnection'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=SERVIDOR:C:\Dados\Banco.fdb'
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
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Left = 24
    Top = 16
  end
  object SQL_Filtro: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'Select M.ChaveNF, M.Numero, M.Serie, M.DataDocumento,  C.NomeCli' +
        'ente,'
      
        'M.DataComprovante, C.CodCliente, C.NumeroCGCMF, C.NumeroCPF, M.C' +
        'odPedido'
      'from MCli M, Cliente C'
      'where C.CodCliente = M.CodCliente'
      ''
      ''
      '')
    SQLConnection = Connnection
    Left = 40
    Top = 80
  end
  object Con_Filtro: TDataSource
    DataSet = CDS_Filtro
    Left = 40
    Top = 224
  end
  object DTS_Filtro: TDataSetProvider
    DataSet = SQL_Filtro
    Left = 40
    Top = 128
  end
  object CDS_Filtro: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DTS_Filtro'
    AfterScroll = CDS_FiltroAfterScroll
    Left = 40
    Top = 176
  end
  object Dts_MCliPro: TDataSetProvider
    DataSet = SQL_MCliPro
    Left = 120
    Top = 128
  end
  object CDS_MCliPro: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Dts_MCliPro'
    Left = 120
    Top = 176
  end
  object SQL_MCliPro: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftString
        Name = 'CHAVENF'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select mp.chavenf,'
      '  mp.codproduto,'
      '  mp.preco,'
      '  mp.unidadeestoque,'
      '  mp.quantatendida,'
      '  mp.codfiscalpro,'
      '  mp.aliqipi,'
      '  pro.unidade,'
      '  pro.nomesubunidade,'
      '  pro.peso,'
      '  gru.codgrupo'
      'from MCLIPRO mp'
      'inner join produto pro on pro.codproduto = mp.codproduto'
      'inner join gruposub gru on gru.codgruposub  = pro.codgruposub'
      'where mp.CHAVENF = :CHAVENF'
      ''
      ''
      ''
      '')
    SQLConnection = Connnection
    Left = 122
    Top = 80
  end
  object Aux: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Connnection
    Left = 272
    Top = 64
  end
end
