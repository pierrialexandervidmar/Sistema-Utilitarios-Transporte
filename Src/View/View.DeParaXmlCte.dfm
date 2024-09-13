object DeParaXmlCte: TDeParaXmlCte
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Totais XML x Cota'#231#227'o Magazord'
  ClientHeight = 761
  ClientWidth = 1184
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
    Left = 936
    Top = 16
    Width = 225
    Height = 32
    Caption = 'Em desenvolvimento'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 23
    Top = 98
    Width = 246
    Height = 21
    Caption = 'Dados da Cota'#231#227'o Original (JSON)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 23
    Top = 24
    Width = 236
    Height = 21
    Caption = 'Selecione o Arquivo XML da CTe'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 456
    Top = 98
    Width = 206
    Height = 21
    Caption = 'Resumo da Cobran'#231'a na CTE'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 832
    Top = 98
    Width = 244
    Height = 21
    Caption = 'Resumo da Cota'#231#227'o na Magazord'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtnBuscarXML: TButton
    Left = 23
    Top = 51
    Width = 137
    Height = 25
    Caption = 'Buscar XML'
    TabOrder = 0
    OnClick = BtnBuscarXMLClick
  end
  object DadosCotacao: TMemo
    Left = 23
    Top = 125
    Width = 338
    Height = 612
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object BtnAnalisar: TBitBtn
    Left = 328
    Top = 43
    Width = 193
    Height = 33
    Caption = 'Realizar An'#225'lise >>>'
    TabOrder = 2
    OnClick = BtnAnalisarClick
  end
  object DadosResumoXML: TMemo
    Left = 456
    Top = 125
    Width = 300
    Height = 321
    TabOrder = 3
  end
  object DadosResumoCotacao: TMemo
    Left = 832
    Top = 125
    Width = 300
    Height = 321
    TabOrder = 4
  end
  object OpenDialog1: TOpenDialog
    Left = 168
    Top = 48
  end
  object XMLDocument1: TXMLDocument
    Left = 616
    Top = 32
  end
end
