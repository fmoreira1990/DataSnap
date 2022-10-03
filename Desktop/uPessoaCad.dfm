object PessoaCad: TPessoaCad
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoas'
  ClientHeight = 560
  ClientWidth = 826
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 826
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnCEP: TButton
      Left = 412
      Top = 8
      Width = 75
      Height = 25
      Caption = 'API CEP'
      TabOrder = 5
      OnClick = btnCEPClick
    end
    object btnInsert: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Insert'
      TabOrder = 0
      OnClick = btnInsertClick
    end
    object btnEdit: TButton
      Left = 89
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Edit'
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 170
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Delete'
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object btnIportacao: TButton
      Left = 331
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Importar'
      TabOrder = 4
      OnClick = btnIportacaoClick
    end
    object btnAtualizar: TButton
      Left = 251
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Atualizar'
      TabOrder = 3
      OnClick = btnAtualizarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 826
    Height = 479
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 824
      Height = 477
      Align = alClient
      DataSource = dsPessoas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      OnKeyDown = DBGrid1KeyDown
    end
  end
  object MemoAPI: TMemo
    Left = 0
    Top = 520
    Width = 826
    Height = 40
    Align = alBottom
    TabOrder = 2
    Visible = False
  end
  object dsPessoas: TDataSource
    DataSet = DMPessoa.Pessoas
    Left = 328
    Top = 193
  end
  object OpenTextFileDialog: TOpenTextFileDialog
    InitialDir = 'D:\WK'
    Left = 432
    Top = 193
  end
end
