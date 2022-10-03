object PessoaCadD: TPessoaCadD
  Left = 0
  Top = 0
  Caption = 'CEP'
  ClientHeight = 258
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 26
    Top = 67
    Width = 19
    Height = 13
    Caption = 'CEP'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    Caption = 'Informa'#231#245'es do CEP'
    TabOrder = 0
    object btnSave: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TButton
      Left = 89
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object DBEdit1: TDBEdit
    Left = 137
    Top = 64
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    DataField = 'dscep'
    DataSource = dEndereco
    TabOrder = 1
    OnKeyPress = DBEdit1KeyPress
  end
  object Panel2: TPanel
    Left = 0
    Top = 168
    Width = 635
    Height = 90
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 3
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 633
      Height = 88
      Align = alClient
      DataSource = dsIntegracao
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 127
    Width = 635
    Height = 41
    Align = alBottom
    Caption = 'Detalhes do CEP - API'
    TabOrder = 2
  end
  object dEndereco: TDataSource
    DataSet = DMPessoa.Endereco
    Left = 384
    Top = 56
  end
  object dsIntegracao: TDataSource
    DataSet = DMPessoa.Integracao
    Left = 448
    Top = 56
  end
end
