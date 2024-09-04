object DeParaXmlCte: TDeParaXmlCte
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Totais XML x Cota'#231#227'o Magazord'
  ClientHeight = 711
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
    Left = 448
    Top = 32
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
  object Button1: TButton
    Left = 32
    Top = 72
    Width = 137
    Height = 25
    Caption = 'Selecionar XML CTe'
    TabOrder = 0
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Left = 224
    Top = 48
  end
end
