unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Edit;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    StringColumn1: TStringColumn;
    procedure StringGrid1CreateCustomEditor(Sender: TObject;
      const Column: TColumn; var Control: TStyledControl);
  private
    { private �錾 }
  public
    { public �錾 }
  end;

  TMyEdit = class(TEdit, ICellControl)
  private
    [Weak]
    FColumn: TColumn;
    procedure ChangeProc(Sender: TObject);
    { ICellControl }
    function GetColumn: TColumn;
    procedure SetColumn(const Value: TColumn);
    procedure ValidateText(Sender: TObject; var Text: string);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{ TMyEdit }

procedure TMyEdit.ChangeProc(Sender: TObject);
begin
  // ��ɑ΂��ĕύX��ʒm����B���ꂪ�Ȃ��ƕҏW�����l���o�^����Ȃ�
  if FColumn <> nil then
    FColumn.EditorModified;
end;

constructor TMyEdit.Create(AOwner: TComponent);
begin
  inherited;
  // ���͂��ꂽ��ChangeProc�������s��
  OnChangeTracking := ChangeProc;
  // ���͂��I������Ƃ���ValidateText�������s��
  OnValidate := ValidateText;
end;

function TMyEdit.GetColumn: TColumn;
begin
  // �ҏW�Ώۂ̗�
  Result := FColumn;
end;

procedure TMyEdit.SetColumn(const Value: TColumn);
begin
  // �ҏW�Ώۂ̗�
  FColumn := Value;
end;

procedure TMyEdit.ValidateText(Sender: TObject; var Text: string);
begin
  // ���͂��I�������啶���ɕϊ�����
  Text := UpperCase(Text);
end;

procedure TForm1.StringGrid1CreateCustomEditor(Sender: TObject;
  const Column: TColumn; var Control: TStyledControl);
begin
  Control := TMyEdit.Create(Sender as TComponent);
end;

end.
