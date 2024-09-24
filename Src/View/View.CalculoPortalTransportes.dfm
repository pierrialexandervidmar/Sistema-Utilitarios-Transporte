object CalculoPortalTransportes: TCalculoPortalTransportes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cota'#231#227'o via Portal de Transportes'
  ClientHeight = 611
  ClientWidth = 998
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 80
    Width = 100
    Height = 17
    Caption = 'Token do Admin'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 144
    Width = 91
    Height = 17
    Caption = 'CEP de Origem'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 181
    Top = 144
    Width = 92
    Height = 17
    Caption = 'CEP de Destino'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 24
    Top = 208
    Width = 30
    Height = 17
    Caption = 'Valor'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 24
    Top = 16
    Width = 347
    Height = 15
    Caption = 
      'Consulta para validar se as configura'#231#245'es do Portal est'#227'o corret' +
      'as.'
  end
  object Label6: TLabel
    Left = 24
    Top = 37
    Width = 327
    Height = 15
    Caption = 'Portando, simula'#231#245'es complexas, solicitar ao time de Suporte.'
  end
  object Label7: TLabel
    Left = 181
    Top = 208
    Width = 29
    Height = 17
    Caption = 'Peso'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 24
    Top = 296
    Width = 37
    Height = 17
    Caption = 'Altura'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 103
    Top = 296
    Width = 46
    Height = 17
    Caption = 'Largura'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 181
    Top = 296
    Width = 84
    Height = 17
    Caption = 'Comprimento'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 24
    Top = 273
    Width = 168
    Height = 17
    Caption = 'Dimens'#245'es em cent'#237'metros:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 24
    Top = 368
    Width = 305
    Height = 17
    Caption = 'Siglas das Transportadoras (separadas por v'#237'rgula)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label13: TLabel
    Left = 432
    Top = 8
    Width = 55
    Height = 17
    Caption = 'Resposta'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object EditTokenAdmin: TEdit
    Left = 24
    Top = 103
    Width = 257
    Height = 23
    TabOrder = 0
  end
  object EditCepOrigem: TEdit
    Left = 24
    Top = 167
    Width = 100
    Height = 23
    TabOrder = 1
  end
  object EditCepDestino: TEdit
    Left = 181
    Top = 167
    Width = 100
    Height = 23
    TabOrder = 2
  end
  object EditValor: TEdit
    Left = 24
    Top = 231
    Width = 100
    Height = 23
    TabOrder = 3
  end
  object EditPeso: TEdit
    Left = 181
    Top = 231
    Width = 100
    Height = 23
    TabOrder = 4
  end
  object EditAltura: TEdit
    Left = 24
    Top = 319
    Width = 57
    Height = 23
    TabOrder = 5
  end
  object EditLargura: TEdit
    Left = 103
    Top = 319
    Width = 57
    Height = 23
    TabOrder = 6
  end
  object EditComprimento: TEdit
    Left = 181
    Top = 319
    Width = 57
    Height = 23
    TabOrder = 7
  end
  object EditSigla: TEdit
    Left = 24
    Top = 391
    Width = 463
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 8
  end
  object DadosCalculoFrete: TMemo
    Left = 504
    Top = 0
    Width = 494
    Height = 611
    Align = alRight
    ScrollBars = ssVertical
    TabOrder = 10
  end
  object BtnConsultar: TButton
    Left = 24
    Top = 456
    Width = 110
    Height = 33
    Caption = 'Consultar'
    TabOrder = 9
    OnClick = BtnConsultarClick
  end
  object BtnLimpar: TButton
    Left = 155
    Top = 456
    Width = 110
    Height = 33
    Caption = 'Limpar'
    TabOrder = 11
    OnClick = BtnLimparClick
  end
  object RESTClient1: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 56
    Top = 544
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 152
    Top = 544
  end
  object RESTResponse1: TRESTResponse
    Left = 240
    Top = 544
  end
end
