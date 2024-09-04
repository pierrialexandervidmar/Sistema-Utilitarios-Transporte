object TesteSSW: TTesteSSW
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Teste Cota'#231#227'o SSW'
  ClientHeight = 611
  ClientWidth = 1184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  ShowHint = True
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object Label2: TLabel
    Left = 24
    Top = 32
    Width = 51
    Height = 17
    Caption = 'Dom'#237'nio'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 23
    Top = 88
    Width = 33
    Height = 17
    Caption = 'Login'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 144
    Top = 88
    Width = 37
    Height = 17
    Caption = 'Senha'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 23
    Top = 152
    Width = 135
    Height = 17
    Caption = 'CNPJ Pagador (Lojista)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 23
    Top = 216
    Width = 72
    Height = 17
    Caption = 'CEP Origem'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 144
    Top = 216
    Width = 73
    Height = 17
    Caption = 'CEP Destino'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 24
    Top = 280
    Width = 51
    Height = 17
    Caption = 'Valor NF'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 144
    Top = 280
    Width = 71
    Height = 17
    Caption = 'Quantidade'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 24
    Top = 344
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
  object Label10: TLabel
    Left = 122
    Top = 344
    Width = 119
    Height = 17
    Caption = 'Volume (Mult. Dim.)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 23
    Top = 408
    Width = 156
    Height = 17
    Caption = 'Tipo de Mercadoria (Cod.)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabelCEPDestinatario: TLabel
    Left = 23
    Top = 472
    Width = 174
    Height = 17
    Caption = 'CPF ou CNPJ do Destinat'#225'rio'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 267
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
  object EditDominio: TEdit
    Left = 24
    Top = 55
    Width = 97
    Height = 23
    TabOrder = 0
  end
  object EditLogin: TEdit
    Left = 23
    Top = 111
    Width = 97
    Height = 23
    TabOrder = 1
  end
  object EditSenha: TEdit
    Left = 144
    Top = 111
    Width = 97
    Height = 23
    TabOrder = 2
  end
  object EditCNPJPagador: TEdit
    Left = 23
    Top = 175
    Width = 161
    Height = 23
    TabOrder = 3
  end
  object EditCepOrigem: TEdit
    Left = 24
    Top = 239
    Width = 97
    Height = 23
    TabOrder = 4
  end
  object EditCepDestino: TEdit
    Left = 144
    Top = 239
    Width = 97
    Height = 23
    TabOrder = 5
  end
  object EditValorNf: TEdit
    Left = 24
    Top = 303
    Width = 97
    Height = 23
    TabOrder = 6
  end
  object EditQuantidade: TEdit
    Left = 144
    Top = 303
    Width = 97
    Height = 23
    TabOrder = 7
  end
  object EditPeso: TEdit
    Left = 23
    Top = 367
    Width = 72
    Height = 23
    TabOrder = 8
  end
  object EditVolume: TEdit
    Left = 122
    Top = 367
    Width = 119
    Height = 23
    Hint = 'Deve multiplicar as dimens'#245'es, sem a cubagem, somente dimens'#245'es'
    TabOrder = 9
  end
  object EditCodigoMercadoria: TEdit
    Left = 24
    Top = 431
    Width = 160
    Height = 23
    TabOrder = 10
  end
  object EditCNPJCEPDestinatario: TEdit
    Left = 24
    Top = 495
    Width = 160
    Height = 23
    TabOrder = 11
  end
  object BtnConsultar: TButton
    Left = 24
    Top = 552
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 12
    OnClick = BtnConsultarClick
  end
  object BtnLimpar: TButton
    Left = 122
    Top = 552
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 13
    OnClick = BtnLimparClick
  end
  object RichEdit1: TRichEdit
    Left = 328
    Top = 0
    Width = 856
    Height = 611
    Align = alRight
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 14
  end
  object HTTPRIO1: THTTPRIO
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 240
    Top = 424
  end
end
