object DMPessoa: TDMPessoa
  OldCreateOrder = False
  Height = 357
  Width = 701
  object Pessoa: TFDMemTable
    OnNewRecord = PessoaNewRecord
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'idpessoa'
    MasterFields = 'idpessoa'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 216
    Top = 88
  end
  object Endereco: TFDMemTable
    BeforePost = EnderecoBeforePost
    OnNewRecord = EnderecoNewRecord
    IndexFieldNames = 'idpessoa'
    MasterSource = dsPessoa
    MasterFields = 'idpessoa'
    DetailFields = 'idendereco'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 216
    Top = 160
  end
  object dsPessoa: TDataSource
    DataSet = Pessoa
    Left = 288
    Top = 88
  end
  object Pessoas: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'IDPESSOA'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 216
    Top = 32
  end
  object FDBatchMove: TFDBatchMove
    Reader = FDBatchMoveTextReader
    Writer = FDBatchMoveJSONWriter
    Options = [poClearDest, poClearDestNoUndo, poIdentityInsert, poCreateDest, poSkipUnmatchedDestFields, poUseTransactions]
    Mappings = <>
    LogFileName = 'Data.log'
    Analyze = [taFormatSet, taHeader, taFields]
    Left = 408
    Top = 232
  end
  object FDBatchMoveTextReader: TFDBatchMoveTextReader
    DataDef.Fields = <>
    DataDef.Delimiter = ';'
    DataDef.Separator = ';'
    DataDef.RecordFormat = rfCustom
    DataDef.WithFieldNames = True
    Left = 408
    Top = 296
  end
  object FDBatchMoveJSONWriter: TFDBatchMoveJSONWriter
    DataDef.Fields = <>
    Left = 544
    Top = 296
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 256
    Top = 288
  end
  object Integracao: TFDMemTable
    IndexFieldNames = 'idendereco'
    MasterSource = dsEndereco
    MasterFields = 'idendereco'
    DetailFields = 'idendereco'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 216
    Top = 224
  end
  object dsEndereco: TDataSource
    DataSet = Endereco
    Left = 288
    Top = 160
  end
end
