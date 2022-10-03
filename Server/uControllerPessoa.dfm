object ControllerPessoa: TControllerPessoa
  OldCreateOrder = False
  Height = 487
  Width = 704
  object FDPessoa: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 168
    Top = 48
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'Database=banco'
      'MetaCurSchema=public'
      'MetaDefSchema=public'
      'User_Name=postgres'
      'Server=localhost'
      'Password=atma123@#$'
      'ExtendedMetadata=False')
    ResourceOptions.AssignedValues = [rvDirectExecute]
    ResourceOptions.DirectExecute = True
    TxOptions.AutoStop = False
    ConnectedStoredUsage = [auDesignTime]
    LoginPrompt = False
    Left = 272
    Top = 48
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 376
    Top = 48
  end
  object FDEndereco: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 168
    Top = 112
  end
  object FDSequence: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select nextval(:sequence)::bigint as id')
    Left = 376
    Top = 120
    ParamData = <
      item
        Name = 'SEQUENCE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDIntegracao: TFDQuery
    Connection = FDConnection1
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvDirectExecute]
    ResourceOptions.DirectExecute = True
    Left = 168
    Top = 176
  end
  object RESTClient1: TRESTClient
    Params = <>
    Left = 408
    Top = 192
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    Left = 408
    Top = 248
  end
  object RESTResponse1: TRESTResponse
    Left = 408
    Top = 296
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = FDCEP
    FieldDefs = <>
    Response = RESTResponse1
    TypesMode = Rich
    Left = 408
    Top = 344
  end
  object FDCEP: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 408
    Top = 400
  end
  object FDScript: TFDScript
    SQLScripts = <>
    Connection = FDConnection1
    Params = <>
    Macros = <>
    Left = 160
    Top = 360
  end
  object FDCEPs: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 568
    Top = 176
  end
  object FDDados: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 568
    Top = 240
  end
end
