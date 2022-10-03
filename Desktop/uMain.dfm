object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 304
    Top = 128
    object acPessoas1: TMenuItem
      Action = acPessoas
    end
  end
  object ActionList1: TActionList
    Left = 440
    Top = 136
    object acPessoas: TAction
      Caption = 'Cadastro de Pessoas'
      OnExecute = acPessoasExecute
    end
  end
end
