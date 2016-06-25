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
    { private 宣言 }
  public
    { public 宣言 }
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
  // 列に対して変更を通知する。これがないと編集した値が登録されない
  if FColumn <> nil then
    FColumn.EditorModified;
end;

constructor TMyEdit.Create(AOwner: TComponent);
begin
  inherited;
  // 入力されたらChangeProc処理を行う
  OnChangeTracking := ChangeProc;
  // 入力が終わったときにValidateText処理を行う
  OnValidate := ValidateText;
end;

function TMyEdit.GetColumn: TColumn;
begin
  // 編集対象の列
  Result := FColumn;
end;

procedure TMyEdit.SetColumn(const Value: TColumn);
begin
  // 編集対象の列
  FColumn := Value;
end;

procedure TMyEdit.ValidateText(Sender: TObject; var Text: string);
begin
  // 入力が終わったら大文字に変換する
  Text := UpperCase(Text);
end;

procedure TForm1.StringGrid1CreateCustomEditor(Sender: TObject;
  const Column: TColumn; var Control: TStyledControl);
begin
  Control := TMyEdit.Create(Sender as TComponent);
end;

end.
