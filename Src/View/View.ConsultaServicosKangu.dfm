object ConsultaServicosKangu: TConsultaServicosKangu
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Consultar servi'#231'os Kangu'
  ClientHeight = 650
  ClientWidth = 959
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
    Left = 8
    Top = 17
    Width = 101
    Height = 17
    Caption = 'Token do Cliente'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 419
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
  object EditToken: TEdit
    Left = 8
    Top = 40
    Width = 345
    Height = 23
    TabOrder = 0
  end
  object DadosRespostaKangu: TMemo
    Left = 486
    Top = 0
    Width = 473
    Height = 650
    Align = alRight
    ScrollBars = ssVertical
    TabOrder = 2
    ExplicitLeft = 616
    ExplicitTop = 40
    ExplicitHeight = 602
  end
  object BtnConsultar: TButton
    Left = 8
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 1
    OnClick = BtnConsultarClick
  end
  object BtnLimpar: TButton
    Left = 96
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 3
    OnClick = BtnLimparClick
  end
  object RESTClient1: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 32
    Top = 176
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 120
    Top = 176
  end
  object RESTResponse1: TRESTResponse
    Left = 216
    Top = 176
  end
end
