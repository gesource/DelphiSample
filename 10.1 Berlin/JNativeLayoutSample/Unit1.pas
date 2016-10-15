unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, Androidapi.JNI.Embarcadero, FMX.Controls.Presentation,
  FMX.StdCtrls, Androidapi.JNI.Widget;

type
  TForm1 = class(TForm)
    ButtonCreate: TButton;
    ButtonShow: TButton;
    ButtonHide: TButton;
    procedure ButtonCreateClick(Sender: TObject);
    procedure ButtonShowClick(Sender: TObject);
    procedure ButtonHideClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private êÈåæ }
    FEditText: JEditText;
    FNativeLayout: JNativeLayout;
    FRealBounds: TRect;
    procedure CalcRealBorder;
  public
    { public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses Androidapi.Helpers, FMX.Platform.Android, FMX.Helpers.Android,
  Androidapi.JNI.GraphicsContentViewText;

procedure TForm1.ButtonCreateClick(Sender: TObject);
begin
  CallInUIThreadAndWaitFinishing(
    procedure
    begin
      FNativeLayout := TJNativeLayout.JavaClass.Init(TAndroidHelper.Activity,
        MainActivity.getWindow.getDecorView.getWindowToken);

      FEditText := TJEditText.JavaClass.Init(TAndroidHelper.Activity);
      FEditText.setText(StrToJCharSequence('ÉeÉXÉg'),
        TJTextView_BufferType.JavaClass.NORMAL);

      FNativeLayout.setControl(FEditText);
      FNativeLayout.setPosition(50, 300);
      FNativeLayout.setSize(400, 200);
    end);
end;

procedure TForm1.ButtonHideClick(Sender: TObject);
begin
  CallInUIThread(
    procedure
    begin
      if FEditText.getVisibility <> TJView.JavaClass.INVISIBLE then
      begin
        FEditText.setVisibility(TJView.JavaClass.INVISIBLE);
        FNativeLayout.setPosition(FRealBounds.Right * 2,
          FRealBounds.Height * 2);
      end;
    end);
end;

procedure TForm1.ButtonShowClick(Sender: TObject);
begin
  CallInUIThread(
    procedure
    begin
      FNativeLayout.setPosition(50, 300);
      FNativeLayout.setSize(400, 200);

      if FEditText.getVisibility <> TJView.JavaClass.VISIBLE then
      begin
        FEditText.setVisibility(TJView.JavaClass.VISIBLE);
      end;
    end);
end;

procedure TForm1.CalcRealBorder;
var
  NativeWin: JWindow;
  ContentRect: JRect;
begin
  NativeWin := TAndroidHelper.Activity.getWindow;
  if NativeWin <> nil then
  begin
    ContentRect := TJRect.Create;
    NativeWin.getDecorView.getDrawingRect(ContentRect);
    FRealBounds := Rect(ContentRect.left, ContentRect.top, ContentRect.Right,
      ContentRect.bottom);
  end
  else
    FRealBounds := TRect.Empty;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CalcRealBorder;
end;

end.
