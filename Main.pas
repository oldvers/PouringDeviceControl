unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UARTLink, ExtCtrls, ComCtrls;

type
  TMainForm = class(TForm)
    UARTLink: TUARTLink;
    ConnectionGroup: TGroupBox;
    UpdatePortsList: TButton;
    PortsList: TComboBox;
    LED: TPanel;
    ConnectBtn: TButton;
    PourGroup: TGroupBox;
    StartBtn: TButton;
    IngredientsGroup1: TGroupBox;
    TrackBar1: TTrackBar;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    IngredientsGroup2: TGroupBox;
    Label2: TLabel;
    TrackBar2: TTrackBar;
    ProgressBar2: TProgressBar;
    IngredientsGroup3: TGroupBox;
    Label3: TLabel;
    TrackBar3: TTrackBar;
    ProgressBar3: TProgressBar;
    IngredientsGroup4: TGroupBox;
    Label4: TLabel;
    TrackBar4: TTrackBar;
    ProgressBar4: TProgressBar;
    Timer: TTimer;
    LogMemo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure UpdatePortsListClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PortsListChange(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure UARTLinkRxBlock(const Block: Pointer; const Size: Byte);
  private
    procedure Log(AStr : String; APar : array of const);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

type
  TPourReq =
    packed record
      Req    : Byte;
      Param1 : Word;
      Param2 : Word;
      Param3 : Word;
      Param4 : Word;
    end;

  TPourRsp =
    packed record
      Rsp     : Byte;
      Channel : Byte;
      Param   : Word;
    end;
  PPourRsp = ^TPourRsp;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  UARTLink.EnumPorts(PortsList.Items);
end;

procedure TMainForm.UpdatePortsListClick(Sender: TObject);
begin
  if PortsList.Enabled then
    begin
      PortsList.Clear;
      UARTLink.EnumPorts(PortsList.Items);
    end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  UpdatePortsList.SetFocus;
  MainForm.Left := 20;
  MainForm.Top := 20;
end;

procedure TMainForm.PortsListChange(Sender: TObject);
begin
  ConnectBtn.SetFocus;
end;

procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
  Label1.Caption := Format('%d ml', [TrackBar1.Position]);
end;

procedure TMainForm.TrackBar2Change(Sender: TObject);
begin
  Label2.Caption := Format('%d ml', [TrackBar2.Position]);
end;

procedure TMainForm.TrackBar3Change(Sender: TObject);
begin
  Label3.Caption := Format('%d ml', [TrackBar3.Position]);
end;

procedure TMainForm.TrackBar4Change(Sender: TObject);
begin
  Label4.Caption := Format('%d ml', [TrackBar4.Position]);
end;

procedure TMainForm.ConnectBtnClick(Sender: TObject);
var
  Port : String;
  Num  : Integer;
begin
  if PortsList.ItemIndex = -1 then Exit;

  try
    if ConnectBtn.Caption = 'Connect' then
      begin
        Port := PortsList.Items[PortsList.ItemIndex];
        Port := Copy(Port, 4, 3);
        Num := StrToInt(Port);
        UARTLink.Port := Num;
        if not UARTLink.Open then Exit;
        if UARTLink.Connected then
          begin
            LED.Color := clLime;
            PortsList.Enabled := False;
            ConnectBtn.Caption := 'Disconnect';
          end else begin
            LED.Color := clRed;
            PortsList.Enabled := True;
          end;
      end else begin
        UARTLink.Close;
        LED.Color := clRed;
        PortsList.Enabled := True;
        ConnectBtn.Caption := 'Connect';
      end;
  except
    MessageDlg('ERROR: Can not open selected port!', mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.StartBtnClick(Sender: TObject);
var Packet : TPourReq;
begin
  //TrackBar1.Position := 0;
  //Timer.Enabled := True;

  Packet.Req := 1;
  Packet.Param1 := TrackBar1.Position * 72;
  Packet.Param2 := TrackBar2.Position * 72;
  Packet.Param3 := TrackBar3.Position * 72;
  Packet.Param4 := TrackBar4.Position * 72;
  UARTLink.TxBlock(@Packet, SizeOf(Packet));
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  ProgressBar1.Position := ProgressBar1.Position + 10;
  if ProgressBar1.Position >= 250 then Timer.Enabled := False;
end;

procedure TMainForm.UARTLinkRxBlock(const Block : Pointer; const Size : Byte);
var RxPkt : PPourRsp;
begin
  //Log('Packet received', []);
  if Size <> SizeOf(TPourRsp) then Exit;

  RxPkt := PPourRsp(Block);
  if RxPkt.Rsp <> $01 then Exit;

  case RxPkt.Channel of
    0 : ProgressBar1.Position := RxPkt.Param;
    1 : ProgressBar2.Position := RxPkt.Param;
    2 : ProgressBar3.Position := RxPkt.Param;
    3 : ProgressBar4.Position := RxPkt.Param;
  end;
end;

procedure TMainForm.Log(AStr : String; APar : array of const);
begin
  LogMemo.Lines.Add(Format(AStr, APar));
end;

end.
