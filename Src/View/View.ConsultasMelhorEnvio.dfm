object ConsultasMelhorEnvio: TConsultasMelhorEnvio
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Consultas Melhor Envio'
  ClientHeight = 661
  ClientWidth = 1236
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
    Top = 16
    Width = 111
    Height = 17
    Caption = 'Listar Companhias'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 544
    Top = 18
    Width = 212
    Height = 17
    Caption = 'Listar Ag'#234'ncias por UF e/ou Cidade'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 544
    Top = 47
    Width = 13
    Height = 17
    Caption = 'ID'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 624
    Top = 47
    Width = 16
    Height = 17
    Caption = 'UF'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 704
    Top = 45
    Width = 41
    Height = 17
    Caption = 'Cidade'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtnConsultarCompanies: TButton
    Left = 24
    Top = 37
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 0
    OnClick = BtnConsultarCompaniesClick
  end
  object DadosCompanies: TMemo
    Left = 24
    Top = 68
    Width = 361
    Height = 585
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object EditID: TEdit
    Left = 563
    Top = 41
    Width = 38
    Height = 23
    TabOrder = 1
  end
  object EditUF: TEdit
    Left = 646
    Top = 41
    Width = 38
    Height = 23
    TabOrder = 2
  end
  object BtnConsultarAgency: TButton
    Left = 944
    Top = 37
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 4
    OnClick = BtnConsultarAgencyClick
  end
  object DadosAgency: TMemo
    Left = 544
    Top = 68
    Width = 665
    Height = 585
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object EditCidade: TEdit
    Left = 751
    Top = 41
    Width = 169
    Height = 23
    TabOrder = 3
  end
  object RESTClient1: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 136
    Top = 32
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 184
    Top = 32
  end
  object RESTResponse1: TRESTResponse
    Left = 232
    Top = 32
  end
  object RESTClient2: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 1064
    Top = 24
  end
  object RESTRequest2: TRESTRequest
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 1120
    Top = 24
  end
  object RESTResponse2: TRESTResponse
    Left = 1176
    Top = 24
  end
end