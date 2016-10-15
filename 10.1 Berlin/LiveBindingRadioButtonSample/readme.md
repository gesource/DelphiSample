Delphi 10.1 BerlinのFireMonkeyアプリケーションでLive Bindingsを使ってデータベースの1つのフィールドと複数のRadioButtonを連結するサンプルプログラムです。

プロジェクトはこちらからダウンロードできます。

* [LiveBindingRadioButtonSample](https://github.com/gesource/DelphiSample/tree/master/10.1%20Berlin/LiveBindingRadioButtonSample)

このサンプルプログラムのフォームはこのようになっています。

<a href="http://www.gesource.jp/weblog/wp-content/uploads/2016/07/LiveBindings03.png"><img src="http://www.gesource.jp/weblog/wp-content/uploads/2016/07/LiveBindings03.png" alt="LiveBindings03" width="278" height="232" class="alignnone size-medium wp-image-7577" /></a>


データベースのフィールドとラジオボタンはLive Bindingsで連結しています。

フィールドの値が「1」のときはRadioButton1をチェック  
フィールドの値が「2」のときはRadioButton2をチェック  
フィールドの値が「3」のときはRadioButton3をチェック  
します。

Edit1に入力するとデータベースの値が更新され、ラジオボタンのチェックが更新されます。

<a href="http://www.gesource.jp/weblog/wp-content/uploads/2016/07/LiveBindings02.png"><img src="http://www.gesource.jp/weblog/wp-content/uploads/2016/07/LiveBindings02-300x148.png" alt="LiveBindings02" width="300" height="148" class="alignnone size-medium wp-image-7576" /></a>

データベースのフィールドは「Value」はInteger型のフィールドで連結する値を持ちます。  
データベースのフィールドは「RadioButton1」「RadioButton2」「RadioButton3」はBoolean型のフィールドで、計算項目です。  
「Value」フィールドの値が「1」のときは「RadioButton1」フィールドはTrue、
「Value」フィールドの値が「2」のときは「RadioButton2」フィールドはTrue、
「Value」フィールドの値が「3」のときは「RadioButton3」フィールドはTrue、
になります。

<a href="http://www.gesource.jp/weblog/wp-content/uploads/2016/07/LiveBindings01.png"><img src="http://www.gesource.jp/weblog/wp-content/uploads/2016/07/LiveBindings01.png" alt="LiveBindings01" width="116" height="246" class="alignnone size-full wp-image-7575" /></a>


    procedure TForm1.FDMemTable1CalcFields(DataSet: TDataSet);
    begin
      DataSet.FieldByName('RadioButton1').AsBoolean := (DataSet.FieldByName('Value').AsInteger = 1);
      DataSet.FieldByName('RadioButton2').AsBoolean := (DataSet.FieldByName('Value').AsInteger = 2);
      DataSet.FieldByName('RadioButton3').AsBoolean := (DataSet.FieldByName('Value').AsInteger = 3);
    end;

