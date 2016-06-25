unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls, FMX.Layouts,
  FMX.ListBox;

type
  TForm1 = class(TForm)
    ListBoxStyleNames: TListBox;
    Splitter1: TSplitter;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure ListBoxStyleNamesChange(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  FMX.Styles;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // 登録されているスタイルを列挙します。
  TStyleManager.EnumStyleResources(
    procedure(const AResourceName: string; const APlatform: TOSPlatform)
    begin
      ListBoxStyleNames.Items.Add(AResourceName)
    end);

  if ListBoxStyleNames.Items.Count > 0 then
    ListBoxStyleNames.ItemIndex := 0;
end;

procedure TForm1.ListBoxStyleNamesChange(Sender: TObject);
var
  ResourceName: string;
  StyleResource: TFmxObject;
  StyleDescription: TStyleDescription;
begin
  Memo1.Lines.Clear;
  ResourceName := ListBoxStyleNames.Selected.Text;

  // スタイル名からスタイルオブジェクトを取得する
  StyleResource := TStyleManager.GetStyleResource(ResourceName);

  // スタイル説明を取得します
  StyleDescription := TStyleManager.FindStyleDescriptor(StyleResource);
  Memo1.Lines.Add('スタイルの作者=' + StyleDescription.Author);
  Memo1.Lines.Add('スタイルの作成者のeメールアドレス=' + StyleDescription.AuthorEMail);
  Memo1.Lines.Add('スタイルの作成者のWebサイトのURL =' + StyleDescription.AuthorURL);
  Memo1.Lines.Add('スタイルがモバイルプラットフォーム上で使用できるか=' +
    BoolToStr(StyleDescription.MobilePlatform, True));
  Memo1.Lines.Add('スタイルのタイトル=' + StyleDescription.Title);
  Memo1.Lines.Add('スタイルのバージョン=' + StyleDescription.Version);
end;

end.
