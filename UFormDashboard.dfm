object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 832
  ClientWidth = 934
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlFiltros: TPanel
    Left = 0
    Top = 0
    Width = 934
    Height = 153
    Align = alTop
    Caption = 'PnlFiltros'
    TabOrder = 0
    ExplicitWidth = 930
    object Label1: TLabel
      Left = 16
      Top = 76
      Width = 58
      Height = 23
      Caption = 'Desde'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 19
      Top = 114
      Width = 55
      Height = 23
      Caption = 'Hasta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 272
      Top = 43
      Width = 49
      Height = 23
      Caption = 'Zona:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 464
      Top = 45
      Width = 106
      Height = 23
      Caption = 'Vendedores:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 656
      Top = 43
      Width = 51
      Height = 23
      Caption = 'Linea:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 80
      Top = 43
      Width = 144
      Height = 23
      Caption = 'Rango de Fecha:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dtpDesde: TDateTimePicker
      Left = 80
      Top = 72
      Width = 186
      Height = 27
      Date = 46277.520721087960000000
      Time = 46277.520721087960000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dtpHasta: TDateTimePicker
      Left = 80
      Top = 114
      Width = 186
      Height = 27
      Date = 46277.526874780090000000
      Time = 46277.526874780090000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object clbZonas: TCheckListBox
      Left = 272
      Top = 72
      Width = 177
      Height = 67
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 19
      ParentFont = False
      TabOrder = 2
    end
    object clbVendedores: TCheckListBox
      Left = 464
      Top = 74
      Width = 178
      Height = 65
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 19
      ParentFont = False
      TabOrder = 3
    end
    object BtnFiltrar: TButton
      Left = 840
      Top = 41
      Width = 75
      Height = 25
      Caption = 'FILTRAR'
      TabOrder = 4
      OnClick = BtnFiltrarClick
    end
    object BtnVersionPro: TButton
      Left = 840
      Top = 83
      Width = 75
      Height = 25
      Caption = 'Ver Financiero'
      TabOrder = 5
    end
    object BtnSalir: TButton
      Left = 840
      Top = 114
      Width = 75
      Height = 25
      Caption = 'SALIR'
      TabOrder = 6
      OnClick = BtnSalirClick
    end
    object clbCategorias: TCheckListBox
      Left = 656
      Top = 72
      Width = 178
      Height = 67
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 19
      ParentFont = False
      TabOrder = 7
    end
    object btntodozna: TButton
      Left = 384
      Top = 41
      Width = 33
      Height = 25
      Caption = 'T'
      TabOrder = 8
      OnClick = btntodoznaClick
    end
    object btnningunzna: TButton
      Left = 416
      Top = 41
      Width = 33
      Height = 25
      Caption = 'N'
      TabOrder = 9
      OnClick = btnningunznaClick
    end
    object btntodovnd: TButton
      Left = 576
      Top = 43
      Width = 33
      Height = 25
      Caption = 'T'
      TabOrder = 10
      OnClick = btntodovndClick
    end
    object btnningunvnd: TButton
      Left = 609
      Top = 43
      Width = 33
      Height = 25
      Caption = 'N'
      TabOrder = 11
      OnClick = btnningunvndClick
    end
    object btntododpto: TButton
      Left = 770
      Top = 41
      Width = 33
      Height = 25
      Caption = 'T'
      TabOrder = 12
      OnClick = btntododptoClick
    end
    object btnningundpto: TButton
      Left = 801
      Top = 41
      Width = 33
      Height = 25
      Caption = 'N'
      TabOrder = 13
      OnClick = btnningundptoClick
    end
  end
  object PnlMetricas: TPanel
    Left = 0
    Top = 153
    Width = 934
    Height = 88
    Align = alTop
    Caption = 'PnlMetricas'
    TabOrder = 1
    ExplicitWidth = 930
    object Label7: TLabel
      Left = 70
      Top = 10
      Width = 151
      Height = 25
      Caption = 'Total Facturas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 384
      Top = 10
      Width = 119
      Height = 25
      Caption = 'Total Cajas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 712
      Top = 10
      Width = 143
      Height = 25
      Caption = 'Total Clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object lblCifraFacturas: TLabel
      Left = 90
      Top = 40
      Width = 15
      Height = 29
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCifraCajas: TLabel
      Left = 384
      Top = 40
      Width = 13
      Height = 25
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCifraClientes: TLabel
      Left = 712
      Top = 40
      Width = 13
      Height = 25
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object PnlTotalFacturas: TPanel
      Left = 1
      Top = 1
      Width = 296
      Height = 86
      Align = alLeft
      Caption = 'PnlTotalFacturas'
      TabOrder = 0
      ExplicitLeft = -5
      ExplicitTop = 6
    end
    object PnlTotalCajas: TPanel
      Left = 297
      Top = 1
      Width = 316
      Height = 86
      Align = alClient
      Caption = 'PnlTotalCajas'
      TabOrder = 1
      ExplicitLeft = 290
      ExplicitTop = 6
      ExplicitWidth = 313
    end
    object PnlTotalClientes: TPanel
      Left = 613
      Top = 1
      Width = 320
      Height = 86
      Align = alRight
      Caption = 'PnlTotalClientes'
      TabOrder = 2
      ExplicitLeft = 615
      ExplicitTop = 6
    end
  end
  object pnlGraficos: TPanel
    Left = 0
    Top = 241
    Width = 934
    Height = 550
    Align = alClient
    Caption = 'pnlGraficos'
    TabOrder = 2
    ExplicitTop = 247
    ExplicitWidth = 933
    ExplicitHeight = 538
    object chtVendedores: TChart
      Left = 1
      Top = 1
      Width = 502
      Height = 312
      Title.Text.Strings = (
        'Top Vendedores')
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series1: THorizBarSeries
        BarBrush.Gradient.Direction = gdLeftRight
        Gradient.Direction = gdLeftRight
        XValues.Name = 'Bar'
        XValues.Order = loNone
        YValues.Name = 'Y'
        YValues.Order = loAscending
      end
    end
    object chtLineas: TChart
      Left = 504
      Top = 5
      Width = 429
      Height = 308
      Title.Text.Strings = (
        'Lineas + Vendidas')
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      TabOrder = 1
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series2: TPieSeries
        XValues.Order = loAscending
        YValues.Name = 'Pie'
        YValues.Order = loNone
        Frame.InnerBrush.BackColor = clRed
        Frame.InnerBrush.Gradient.EndColor = clGray
        Frame.InnerBrush.Gradient.MidColor = clWhite
        Frame.InnerBrush.Gradient.StartColor = 4210752
        Frame.InnerBrush.Gradient.Visible = True
        Frame.MiddleBrush.BackColor = clYellow
        Frame.MiddleBrush.Gradient.EndColor = 8553090
        Frame.MiddleBrush.Gradient.MidColor = clWhite
        Frame.MiddleBrush.Gradient.StartColor = clGray
        Frame.MiddleBrush.Gradient.Visible = True
        Frame.OuterBrush.BackColor = clGreen
        Frame.OuterBrush.Gradient.EndColor = 4210752
        Frame.OuterBrush.Gradient.MidColor = clWhite
        Frame.OuterBrush.Gradient.StartColor = clSilver
        Frame.OuterBrush.Gradient.Visible = True
        Frame.Width = 4
        OtherSlice.Legend.Visible = False
      end
    end
  end
  object pnlInfo: TPanel
    Left = 0
    Top = 791
    Width = 934
    Height = 41
    Align = alBottom
    Caption = 'pnlInfo'
    TabOrder = 3
    ExplicitLeft = 312
    ExplicitTop = 808
    ExplicitWidth = 185
  end
end
