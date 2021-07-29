import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                  validator: (String? value) {
                    return !value!.contains('@') ? '＠を含めてください' : null;
                  },
                  onSaved: (String? value) {
                    this._email = value!;
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
                  validator: (String? value) {
                    return value!.length < 6 ? '6文字以上入力してください' : null;
                  },
                  onSaved: (String? value) {
                    this._name = value!;
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
    if (this._formKey.currentState!.validate()) {
      this._formKey.currentState!.save();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      print(this._name);
      print(this._email);
    }
  }
}
