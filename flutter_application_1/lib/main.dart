//@dart=2.9
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http; //httpリクエスト用
import 'dart:async'; //非同期処理用
import 'dart:convert';
import './task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form'),
        ),
        body: Center(
          child: ChangeForm(),
        ),
      ),
    );
  }
}

class ChangeForm extends StatefulWidget {
  @override
  _ChangeFormState createState() => _ChangeFormState();
}

class _ChangeFormState extends State<ChangeForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';

  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                new TextFormField(
                  maxLength: 100,
                  autovalidate: true,
                  decoration: const InputDecoration(
                    hintText: 'メールアドレス',
                    labelText: 'メールアドレス',
                  ),
                  validator: (String value) {
                    return !value.contains('@') ? '＠を含めてください' : null;
                  },
                  onSaved: (String value) {
                    this._email = value;
                  },
                ),
                new TextFormField(
                  enabled: true,
                  maxLength: 20,
                  maxLengthEnforced: false,
                  obscureText: false,
                  autovalidate: false,
                  decoration: const InputDecoration(
                    hintText: 'パスワード',
                    labelText: 'パスワード',
                  ),
                  validator: (String value) {
                    return value.length < 6 ? '6文字以上入力してください' : null;
                  },
                  onSaved: (String value) {
                    this._name = value;
                  },
                ),
                RaisedButton(
                  onPressed: _submission,
                  child: Text('保存'),
                )
              ],
            )));
  }

  void _submission() {
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      // print(this._name);
      // print(this._email);

      @override
      void initState() {
        super.initState();
        // getData();
        // res = fetchApiResults();
        res = "Hello World";
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              // （2） 実際に表示するページ(ウィジェット)を指定する
              builder: (context) => Task(res_: res)));
    }
  }

  // Future<ApiResults> res;
  String res;

  Future getData() async {
    //Future xxx async{} という記法
    http.Response response =
        await http.get("https://reqres.in/api/users?page=2");
  }

  // 非同期処理は、デフォルトでは呼び出し元は処理の完了を待ちませんが、
  // await キーワードをつけると完了を待つことができる。

}

class ApiResults {
  final String message;
  ApiResults({
    this.message,
  });
  factory ApiResults.fromJson(Map<String, dynamic> json) {
    return ApiResults(
      message: json['message'],
    );
  }
}

Future<ApiResults> fetchApiResults() async {
  var url = "http://172.16.0.223/creator/api/flutter_post_test";
  var request = new SampleRequest(id: 1234, name: '大和賢一郎');
  final response = await http.post(url,
      body: json.encode(request.toJson()),
      headers: {"Content-Type": "application/json"});
  if (response.statusCode == 200) {
    return ApiResults.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed');
  }
}

class SampleRequest {
  final int id;
  final String name;
  SampleRequest({
    this.id,
    this.name,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
