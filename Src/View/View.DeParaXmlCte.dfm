object DeParaXmlCte: TDeParaXmlCte
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Totais XML x Cota'#231#227'o Magazord'
  ClientHeight = 661
  ClientWidth = 1072
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
    Left = 360
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
    Left = 721
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
  object LblCaminhoXML: TLabel
    Left = 23
    Top = 6
    Width = 3
    Height = 15
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
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
    Width = 266
    Height = 500
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object BtnAnalisar: TBitBtn
    Left = 360
    Top = 43
    Width = 193
    Height = 33
    Caption = 'Realizar An'#225'lise >>>'
    TabOrder = 2
    OnClick = BtnAnalisarClick
  end
  object DadosResumoXML: TMemo
    Left = 360
    Top = 125
    Width = 320
    Height = 500
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object DadosResumoCotacao: TMemo
    Left = 721
    Top = 125
    Width = 320
    Height = 500
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object pnl1: TPanel
    Left = 325
    Top = 21
    Width = 2
    Height = 604
    BevelOuter = bvNone
    Color = clHighlight
    ParentBackground = False
    TabOrder = 5
  end
  object OpenDialog1: TOpenDialog
    Left = 272
    Top = 8
  end
  object XMLDocument1: TXMLDocument
    Left = 616
    Top = 32
  end
end
