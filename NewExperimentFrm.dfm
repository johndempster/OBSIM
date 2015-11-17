object SetExperimentFrm: TSetExperimentFrm
  Left = 371
  Top = 346
  BorderStyle = bsDialog
  Caption = 'New Experiment'
  ClientHeight = 71
  ClientWidth = 181
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cbTissue: TComboBox
    Left = 8
    Top = 8
    Width = 169
    Height = 25
    Hint = 'Select type of tissue in organ bath'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 17
    ItemIndex = 0
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = 'Chick biventer muscle'
    Items.Strings = (
      'Chick biventer muscle'
      'Guinea pig ileum')
  end
  object bOK: TButton
    Left = 8
    Top = 40
    Width = 49
    Height = 25
    Caption = 'OK'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 1
  end
  object bCancel: TButton
    Left = 64
    Top = 40
    Width = 57
    Height = 17
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ModalResult = 2
    ParentFont = False
    TabOrder = 2
  end
end
