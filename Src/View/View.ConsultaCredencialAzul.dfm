object ConsultaCredencialAzul: TConsultaCredencialAzul
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Consultar credencial Azul'
  ClientHeight = 363
  ClientWidth = 824
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
    Top = 40
    Width = 150
    Height = 17
    Caption = 'Identifica'#231#227'o do Usu'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 112
    Width = 37
    Height = 17
    Caption = 'Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 328
    Top = 40
    Width = 55
    Height = 17
    Caption = 'Resposta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object EditIdentificador: TEdit
    Left = 24
    Top = 63
    Width = 281
    Height = 23
    TabOrder = 0
  end
  object EditSenha: TEdit
    Left = 24
    Top = 135
    Width = 281
    Height = 23
    TabOrder = 1
  end
  object DadosRespostaAzul: TMemo
    Left = 328
    Top = 63
    Width = 457
    Height = 242
    TabOrder = 4
  end
  object BtnPesquisar: TButton
    Left = 24
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 2
    OnClick = BtnPesquisarClick
  end
  object BtnLimpar: TButton
    Left = 112
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 3
    OnClick = BtnLimparClick
  end
  object RESTClient1: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 24
    Top = 288
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 104
    Top = 288
  end
  object RESTResponse1: TRESTResponse
    Left = 192
    Top = 288
  end
end