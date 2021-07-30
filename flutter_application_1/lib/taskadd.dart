// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import './calendar.dart';
import './calendar2.dart';

// リスト追加画面用Widget
class TaskAdd extends StatefulWidget {
  String res_;
  TaskAdd({Key key, @required this.res_}) : super(key: key);
  @override
  _TaskAddState createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {
  DateFormat formatter;
  @override
  void initState() {
    super.initState();
    // getData();
    // res = fetchApiResults();
    initializeDateFormatting('ja_JP', null);
    formatter = new DateFormat('MM/dd(E) HH:mm');
  }

  var _mydatetime = new DateTime.now();
  // var formatter = new DateFormat('MM/dd(E) HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // *** 追加する部分 ***
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      // *** 追加する部分 ***
      body: Container(
        // 余白を付ける
        padding: EdgeInsets.all(64),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextFormField(
                maxLength: 100,
                decoration: const InputDecoration(
                  hintText: 'タスクを入力してください',
                  labelText: 'タスク名',
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 100,
                decoration: const InputDecoration(
                  labelText: '所要時間（時）',
                  hintText: '所要時間を入力してください(時)',
                ),
                validator: (String value) {
                  return double.parse(value, (e) => null) == null
                      ? '数字を入力してください'
                      : null;
                },
              ),
              Text(''),
              Container(
                child: FloatingActionButton.extended(
                  label: Text('期限を入力'),
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      // onChanged内の処理はDatepickerの選択に応じて毎回呼び出される
                      onChanged: (date) {
                        // print('change $date');
                      },
                      // onConfirm内の処理はDatepickerで選択完了後に呼び出される
                      onConfirm: (date) {
                        setState(() {
                          _mydatetime = date;
                        });
                      },
                      // Datepickerのデフォルトで表示する日時
                      currentTime: DateTime.now(),
                      // localによって色々な言語に対応
                      //  locale: LocaleType.en
                    );
                  },
                  tooltip: 'Datetime',
                  icon: Icon(Icons.access_time),
                ),
              ),
              Text(''),
              Text(
                // フォーマッターを使用して指定したフォーマットで日時を表示
                // format()に渡すのはDate型の値で、String型で返される
                formatter.format(_mydatetime),
                style: Theme.of(context).textTheme.display1,
              ),
              const SizedBox(height: 8),
              Container(
                // 横幅いっぱいに広げる
                width: double.infinity,
                // リスト追加ボタン
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            // （2） 実際に表示するページ(ウィジェット)を指定する
                            builder: (context) => Calendar2()));
                  },
                  child: Text('登録', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                // 横幅いっぱいに広げる
                width: double.infinity,
                // キャンセルボタン
                child: TextButton(
                  // ボタンをクリックした時の処理
                  onPressed: () {
                    // "pop"で前の画面に戻る
                    Navigator.of(context).pop();
                  },
                  child: Text('キャンセル'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
