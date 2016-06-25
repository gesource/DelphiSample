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
    { private �錾 }
  public
    { public �錾 }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  FMX.Styles;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // �o�^����Ă���X�^�C����񋓂��܂��B
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

  // �X�^�C��������X�^�C���I�u�W�F�N�g���擾����
  StyleResource := TStyleManager.GetStyleResource(ResourceName);

  // �X�^�C���������擾���܂�
  StyleDescription := TStyleManager.FindStyleDescriptor(StyleResource);
  Memo1.Lines.Add('�X�^�C���̍��=' + StyleDescription.Author);
  Memo1.Lines.Add('�X�^�C���̍쐬�҂�e���[���A�h���X=' + StyleDescription.AuthorEMail);
  Memo1.Lines.Add('�X�^�C���̍쐬�҂�Web�T�C�g��URL =' + StyleDescription.AuthorURL);
  Memo1.Lines.Add('�X�^�C�������o�C���v���b�g�t�H�[����Ŏg�p�ł��邩=' +
    BoolToStr(StyleDescription.MobilePlatform, True));
  Memo1.Lines.Add('�X�^�C���̃^�C�g��=' + StyleDescription.Title);
  Memo1.Lines.Add('�X�^�C���̃o�[�W����=' + StyleDescription.Version);
end;

end.
