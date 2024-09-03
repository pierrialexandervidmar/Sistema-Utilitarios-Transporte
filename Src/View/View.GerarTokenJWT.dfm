object GerarTokenJWT: TGerarTokenJWT
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Autentica'#231#227'o JWT - Portal BW'
  ClientHeight = 483
  ClientWidth = 736
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
    Left = 16
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
    Left = 321
    Top = 8
    Width = 392
    Height = 15
    Caption = 
      'Ap'#243's gerar o link, basta copiar e inseir na barra de endere'#231'o do' +
      ' navegador.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 24
    Width = 76
    Height = 17
    Caption = 'Identificador'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object EditToken: TEdit
    Left = 16
    Top = 103
    Width = 345
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object Button1: TButton
    Left = 16
    Top = 140
    Width = 75
    Height = 25
    Caption = 'Gerar Link'
    TabOrder = 2
    OnClick = Button1Click
  end
  object DadosLink: TMemo
    Left = 16
    Top = 184
    Width = 697
    Height = 284
    TabOrder = 3
  end
  object EditIdentificador: TEdit
    Left = 16
    Top = 47
    Width = 209
    Height = 23
    CharCase = ecLowerCase
    TabOrder = 0
  end
  object BtnLimpar: TButton
    Left = 104
    Top = 140
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 4
    OnClick = BtnLimparClick
  end
  object RESTClient1: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 432
    Top = 56
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 520
    Top = 56
  end
  object RESTResponse1: TRESTResponse
    Left = 624
    Top = 56
  end
end
