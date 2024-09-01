object ConsultaCnpj: TConsultaCnpj
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Consulta CNPJ'
  ClientHeight = 611
  ClientWidth = 1133
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 27
    Height = 17
    Caption = 'Cnpj'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object EditCnpj: TEdit
    Left = 24
    Top = 45
    Width = 281
    Height = 23
    TabOrder = 0
  end
  object btnPesquisar: TButton
    Left = 24
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 1
    OnClick = btnPesquisarClick
  end
  object dados: TMemo
    Left = 333
    Top = 0
    Width = 800
    Height = 611
    Align = alRight
    ScrollBars = ssVertical
    TabOrder = 2
    ExplicitLeft = 484
  end
  object Button1: TButton
    Left = 120
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 3
    OnClick = Button1Click
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://www.receitaws.com.br/v1/cnpj'
    Params = <>
    SynchronizedEvents = False
    Left = 40
    Top = 240
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 40
    Top = 304
  end
  object RESTResponse1: TRESTResponse
    Left = 40
    Top = 368
  end
end
