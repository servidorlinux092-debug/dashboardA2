object FrmSplash: TFrmSplash
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FrmSplash'
  ClientHeight = 200
  ClientWidth = 450
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LabelEstado: TLabel
    Left = 8
    Top = 59
    Width = 312
    Height = 23
    Caption = 'Inicializando Datos para Analisis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object ProgressBarCopia: TProgressBar
    Left = 8
    Top = 88
    Width = 417
    Height = 33
    TabOrder = 0
  end
end
