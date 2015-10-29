object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Locale Parser'
  ClientHeight = 519
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    704
    519)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 248
    Top = 13
    Width = 34
    Height = 13
    Caption = 'Found:'
  end
  object ButtonSave: TButton
    Left = 540
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Save XML'
    TabOrder = 0
    OnClick = ButtonSaveClick
  end
  object MemoFound: TMemo
    Left = 248
    Top = 39
    Width = 448
    Height = 472
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object ButtonParse: TButton
    Left = 459
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Parse strings'
    TabOrder = 2
    OnClick = ButtonParseClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 263
    Width = 234
    Height = 106
    Caption = 'Base project markers'
    TabOrder = 3
    DesignSize = (
      234
      106)
    object Label2: TLabel
      Left = 9
      Top = 19
      Width = 64
      Height = 13
      Caption = 'Common text'
    end
    object Label3: TLabel
      Left = 9
      Top = 46
      Width = 66
      Height = 13
      Caption = 'Localized text'
    end
    object etCommon: TEdit
      Left = 192
      Top = 16
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      Text = '3'
    end
    object etLocalized: TEdit
      Left = 192
      Top = 43
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      Text = '4'
    end
    object ButtonAvtoFM: TButton
      Left = 9
      Top = 71
      Width = 216
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Generate base strings'
      TabOrder = 2
      OnClick = ButtonAvtoFMClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 375
    Width = 234
    Height = 137
    Caption = 'Inheritor project markers'
    TabOrder = 4
    DesignSize = (
      234
      137)
    object Label4: TLabel
      Left = 9
      Top = 19
      Width = 112
      Height = 13
      Caption = 'Additional common text'
    end
    object Label5: TLabel
      Left = 9
      Top = 46
      Width = 113
      Height = 13
      Caption = 'Additional localized text'
    end
    object Label6: TLabel
      Left = 9
      Top = 74
      Width = 112
      Height = 13
      Caption = 'Replacing localized text'
    end
    object etAddCommon: TEdit
      Left = 192
      Top = 16
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      Text = '6'
    end
    object etAddLocalized: TEdit
      Left = 192
      Top = 43
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      Text = '7'
    end
    object ButtonAvtoCE: TButton
      Left = 9
      Top = 101
      Width = 216
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Generate updated strings'
      TabOrder = 2
      OnClick = ButtonAvtoCEClick
    end
    object etAddReplacing: TEdit
      Left = 192
      Top = 71
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 3
      Text = '5'
    end
  end
  object ButtonOpen: TButton
    Left = 378
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Open TSV'
    TabOrder = 5
    OnClick = ButtonOpenClick
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 151
    Width = 234
    Height = 106
    Caption = 'Main markers'
    TabOrder = 6
    DesignSize = (
      234
      106)
    object Label7: TLabel
      Left = 9
      Top = 21
      Width = 90
      Height = 13
      Caption = 'Non-output strings'
    end
    object Label8: TLabel
      Left = 9
      Top = 49
      Width = 73
      Height = 13
      Caption = 'Language code'
    end
    object Label9: TLabel
      Left = 9
      Top = 77
      Width = 105
      Height = 13
      Caption = 'Parent language code'
    end
    object etComment: TEdit
      Left = 192
      Top = 18
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 0
      Text = '0'
    end
    object etlanguageCode: TEdit
      Left = 192
      Top = 46
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 1
      Text = '1'
    end
    object etLanguageParentCode: TEdit
      Left = 192
      Top = 74
      Width = 33
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 2
      Text = '2'
    end
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 8
    Width = 234
    Height = 89
    Caption = 'General settings'
    TabOrder = 7
    DesignSize = (
      234
      89)
    object Label10: TLabel
      Left = 9
      Top = 19
      Width = 81
      Height = 13
      Caption = 'Default file name'
    end
    object etFilename: TEdit
      Left = 9
      Top = 38
      Width = 216
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'Localization - String.tsv'
    end
    object chbAutoexit: TCheckBox
      Left = 9
      Top = 63
      Width = 151
      Height = 17
      Caption = 'exit after generation'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object ButtonClearMemo: TButton
    Left = 621
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    TabOrder = 8
    OnClick = ButtonClearMemoClick
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 103
    Width = 234
    Height = 42
    Caption = 'Output options'
    TabOrder = 9
    object chbTransable: TCheckBox
      Left = 9
      Top = 19
      Width = 200
      Height = 17
      Caption = 'Add [translatable="false"] to common text'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 328
    Top = 8
  end
end
