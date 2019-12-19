object MainForm: TMainForm
  Left = 210
  Top = 104
  BorderStyle = bsToolWindow
  Caption = 'Pouring device'
  ClientHeight = 640
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ConnectionGroup: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 49
    Caption = '  Connection  '
    TabOrder = 0
    object UpdatePortsList: TButton
      Left = 8
      Top = 16
      Width = 21
      Height = 20
      Caption = 'U'
      TabOrder = 0
      OnClick = UpdatePortsListClick
    end
    object PortsList: TComboBox
      Left = 32
      Top = 16
      Width = 97
      Height = 21
      Style = csDropDownList
      DragKind = dkDock
      ItemHeight = 13
      TabOrder = 1
      OnChange = PortsListChange
    end
    object LED: TPanel
      Left = 132
      Top = 16
      Width = 29
      Height = 21
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Color = clRed
      TabOrder = 2
    end
    object ConnectBtn: TButton
      Left = 164
      Top = 16
      Width = 75
      Height = 20
      Caption = 'Connect'
      TabOrder = 3
      OnClick = ConnectBtnClick
    end
  end
  object PourGroup: TGroupBox
    Left = 264
    Top = 8
    Width = 225
    Height = 49
    Caption = '  Pour  '
    TabOrder = 1
    object StartBtn: TButton
      Left = 8
      Top = 16
      Width = 209
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = StartBtnClick
    end
  end
  object IngredientsGroup1: TGroupBox
    Left = 8
    Top = 64
    Width = 481
    Height = 81
    Caption = '  Ingredient 1  '
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 40
      Width = 465
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0 ml'
    end
    object TrackBar1: TTrackBar
      Left = 8
      Top = 16
      Width = 465
      Height = 25
      Max = 250
      Frequency = 10
      TabOrder = 0
      ThumbLength = 10
      OnChange = TrackBar1Change
    end
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 56
      Width = 465
      Height = 17
      TabOrder = 1
    end
  end
  object IngredientsGroup2: TGroupBox
    Left = 8
    Top = 152
    Width = 481
    Height = 81
    Caption = '  Ingredient 2  '
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 465
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0 ml'
    end
    object TrackBar2: TTrackBar
      Left = 8
      Top = 16
      Width = 465
      Height = 25
      Max = 250
      Frequency = 10
      TabOrder = 0
      ThumbLength = 10
      OnChange = TrackBar2Change
    end
    object ProgressBar2: TProgressBar
      Left = 8
      Top = 56
      Width = 465
      Height = 17
      TabOrder = 1
    end
  end
  object IngredientsGroup3: TGroupBox
    Left = 8
    Top = 240
    Width = 481
    Height = 81
    Caption = '  Ingredient 3  '
    TabOrder = 4
    object Label3: TLabel
      Left = 8
      Top = 40
      Width = 465
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0 ml'
    end
    object TrackBar3: TTrackBar
      Left = 8
      Top = 16
      Width = 465
      Height = 25
      Max = 250
      Frequency = 10
      TabOrder = 0
      ThumbLength = 10
      OnChange = TrackBar3Change
    end
    object ProgressBar3: TProgressBar
      Left = 8
      Top = 56
      Width = 465
      Height = 17
      TabOrder = 1
    end
  end
  object IngredientsGroup4: TGroupBox
    Left = 8
    Top = 328
    Width = 481
    Height = 81
    Caption = '  Ingredient 4  '
    TabOrder = 5
    object Label4: TLabel
      Left = 8
      Top = 40
      Width = 465
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '0 ml'
    end
    object TrackBar4: TTrackBar
      Left = 8
      Top = 16
      Width = 465
      Height = 25
      Max = 250
      Frequency = 10
      TabOrder = 0
      ThumbLength = 10
      OnChange = TrackBar4Change
    end
    object ProgressBar4: TProgressBar
      Left = 8
      Top = 56
      Width = 465
      Height = 17
      TabOrder = 1
    end
  end
  object LogMemo: TMemo
    Left = 8
    Top = 416
    Width = 481
    Height = 217
    ScrollBars = ssVertical
    TabOrder = 6
  end
  object UARTLink: TUARTLink
    StartByte = 36
    EndByte = 66
    UseCS = True
    OnRxBlock = UARTLinkRxBlock
    Port = 2
    BufferSize = 65536
    BaudRate = BR_921600
    ByteSize = BS8
    Parity = P_None
    StopBits = SB_10
    Left = 152
    Top = 160
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 184
    Top = 160
  end
end
