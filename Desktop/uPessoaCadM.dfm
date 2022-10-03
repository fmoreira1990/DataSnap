object PessoaCadM: TPessoaCadM
  Left = 0
  Top = 0
  Caption = 'Pessoa'
  ClientHeight = 559
  ClientWidth = 671
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
    Top = 70
    Width = 44
    Height = 13
    Caption = 'Natureza'
  end
  object Label2: TLabel
    Left = 26
    Top = 97
    Width = 54
    Height = 13
    Caption = 'Documento'
  end
  object Label3: TLabel
    Left = 26
    Top = 126
    Width = 68
    Height = 13
    Caption = 'Primeiro Nome'
  end
  object Label4: TLabel
    Left = 26
    Top = 153
    Width = 72
    Height = 13
    Caption = 'Segundo Nome'
  end
  object Label5: TLabel
    Left = 26
    Top = 180
    Width = 60
    Height = 13
    Caption = 'DT. Registro'
  end
  object Label6: TLabel
    Left = 26
    Top = 45
    Width = 52
    Height = 13
    Caption = 'ID. Pessoa'
  end
  object Label7: TLabel
    Left = 137
    Top = 45
    Width = 31
    Height = 13
    Caption = 'Label7'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 671
    Height = 41
    Align = alTop
    Caption = 'Informa'#231#245'es da Pessoa'
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
    Top = 67
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    DataField = 'flnatureza'
    DataSource = dsPessoa
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 137
    Top = 94
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    DataField = 'dsdocumento'
    DataSource = dsPessoa
    TabOrder = 2
  end
  object DBEdit3: TDBEdit
    Left = 137
    Top = 123
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    DataField = 'nmprimeiro'
    DataSource = dsPessoa
    TabOrder = 3
  end
  object DBEdit4: TDBEdit
    Left = 137
    Top = 150
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    DataField = 'nmsegundo'
    DataSource = dsPessoa
    TabOrder = 4
  end
  object DBEdit5: TDBEdit
    Left = 137
    Top = 177
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    DataField = 'dtregistro'
    DataSource = dsPessoa
    TabOrder = 5
  end
  object Panel2: TPanel
    Left = 0
    Top = 240
    Width = 671
    Height = 319
    Align = alBottom
    TabOrder = 6
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 669
      Height = 41
      Align = alTop
      Caption = 'Informa'#231#245'es do CEP'
      TabOrder = 0
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
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 202
      Width = 669
      Height = 119
      Align = alTop
      DataSource = dsIntegracao
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object Panel4: TPanel
      Left = 1
      Top = 161
      Width = 669
      Height = 41
      Align = alTop
      Caption = 'Detalhes do CEP - API'
      TabOrder = 2
    end
    object DBGrid2: TDBGrid
      Left = 1
      Top = 42
      Width = 669
      Height = 119
      Align = alTop
      DataSource = dsEndereco
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object dsPessoa: TDataSource
    DataSet = DMPessoa.Pessoa
    Left = 384
    Top = 56
  end
  object dsEndereco: TDataSource
    DataSet = DMPessoa.Endereco
    Left = 512
    Top = 56
  end
  object dsIntegracao: TDataSource
    DataSet = DMPessoa.Integracao
    Left = 448
    Top = 56
  end
end
