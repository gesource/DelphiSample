unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.DApt.Intf, FireDAC.Comp.Client, System.Math.Vectors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, Data.DB,
  FireDAC.Comp.DataSet, FMX.StdCtrls, Data.Bind.Components, FMX.Edit,
  Data.Bind.DBScope, FMX.Controls3D,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    BindingsList1: TBindingsList;
    ProxyObject1: TProxyObject;
    BindSourceDB1: TBindSourceDB;
    Edit1: TEdit;
    LinkControlToField1: TLinkControlToField;
    LinkPropertyToFieldIsChecked: TLinkPropertyToField;
    LinkPropertyToFieldIsChecked2: TLinkPropertyToField;
    LinkPropertyToFieldIsChecked3: TLinkPropertyToField;
    FDMemTable1: TFDMemTable;
    FDMemTable1Value: TIntegerField;
    FDMemTable1RadioButton1: TBooleanField;
    FDMemTable1RadioButton2: TBooleanField;
    FDMemTable1RadioButton3: TBooleanField;
    procedure FDMemTable1CalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { private 宣言 }
  public
    { public 宣言 }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FDMemTable1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('RadioButton1').AsBoolean := (DataSet.FieldByName('Value').AsInteger = 1);
  DataSet.FieldByName('RadioButton2').AsBoolean := (DataSet.FieldByName('Value').AsInteger = 2);
  DataSet.FieldByName('RadioButton3').AsBoolean := (DataSet.FieldByName('Value').AsInteger = 3);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FDMemTable1.Open;
  FDMemTable1.Append;
  FDMemTable1.FieldByName('value').AsInteger := 1;
  FDMemTable1.Post;
end;

end.
