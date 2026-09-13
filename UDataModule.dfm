object DM: TDM
  OldCreateOrder = False
  Height = 150
  Width = 215
  object SessionA2: TDBISAMSession
    EngineVersion = '4.49 Build 4'
    SessionName = 'SessionA2'
    RemoteEncryptionPassword = 'elevatesoft'
    RemoteAddress = '127.0.0.1'
    Left = 24
    Top = 16
  end
  object DatabaseA2: TDBISAMDatabase
    EngineVersion = '4.49 Build 4'
    DatabaseName = 'KpiData'
    SessionName = 'SessionA2'
    Left = 80
    Top = 16
  end
  object QryAnalitycs: TDBISAMQuery
    DatabaseName = 'KpiData'
    SessionName = 'SessionA2'
    EngineVersion = '4.49 Build 4'
    Params = <>
    Left = 144
    Top = 16
  end
end
