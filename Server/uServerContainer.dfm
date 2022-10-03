object ServerContainer: TServerContainer
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    ChannelResponseTimeout = 1200000
    Left = 96
    Top = 11
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    LifeCycle = 'Invocation'
    Left = 200
    Top = 11
  end
end
