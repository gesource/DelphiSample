unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.ListBox, FMX.ComboEdit, FMX.EditBox, FMX.NumberBox, FMX.DateTimeCtrls,
  FMX.Edit;

type
  TForm1 = class(TForm)
    ButtonDefault: TButton;
    ListBoxStyleNames: TListBox;
    Button1: TButton;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    TrackBar1: TTrackBar;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    DateEdit1: TDateEdit;
    TimeEdit1: TTimeEdit;
    NumberBox1: TNumberBox;
    ComboEdit1: TComboEdit;
    procedure ButtonDefaultClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxStyleNamesChange(Sender: TObject);
  private const
    StyleNames: array [0 .. 10] of string = ('CopperStyle', 'CopperDarkStyle',
      'CoralCrystalStyle', 'CoralDarkStyle', 'DiamondStyle',
      'EmeraldCrystalStyle', 'EmeraldDarkStyle', 'JetStyle', 'RadiantStyle',
      'SterlingStyle', 'VaporStyle');
  private
    { private êÈåæ }
    function LoadStyleNames: TArray<string>;
    procedure LoadListBoxItem;
    procedure SetStyle(const AStyleIndex: Integer);
  public
    { public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.IOUtils, FMX.Styles, System.Generics.Collections;

{$IFDEF MACOS}
{$R Resource.mac.res}
{$ENDIF}
{$IFDEF MSWINDOWS}
{$R Resource.win.res}
{$ENDIF}

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadListBoxItem;
end;

procedure TForm1.ListBoxStyleNamesChange(Sender: TObject);
begin
  if ListBoxStyleNames.Selected <> nil then
    SetStyle(ListBoxStyleNames.Selected.Index);
end;

procedure TForm1.LoadListBoxItem;
begin
  ListBoxStyleNames.Items.AddStrings(LoadStyleNames);
end;

function TForm1.LoadStyleNames: TArray<string>;
var
  StyleName: string;
  Style: TFmxObject;
  StyleDescription: TStyleDescription;
  List: TList<string>;
begin
  List := TList<string>.Create;

  for StyleName in StyleNames do
  begin
    Style := TStyleStreaming.LoadFromResource(HInstance, StyleName, RT_RCDATA);
    StyleDescription := TStyleManager.FindStyleDescriptor(Style);
    List.Add(StyleDescription.Title);

    StyleDescription.Free;
    Style.Free;
  end;

  Result := List.ToArray;
end;

procedure TForm1.SetStyle(const AStyleIndex: Integer);
var
  Control: TFmxObject;
begin
  Control := TStyleStreaming.LoadFromResource(HInstance,
    StyleNames[AStyleIndex], RT_RCDATA);
  TStyleManager.SetStyle(Control);
end;

procedure TForm1.ButtonDefaultClick(Sender: TObject);
begin
  TStyleManager.SetStyle(nil);
end;

end.
