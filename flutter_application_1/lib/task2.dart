// @dart=2.9
import 'package:flutter/material.dart';

class Task2 extends StatelessWidget {
  String res_;

  Task2({Key key, @required this.res_}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user: user2"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "{task1: 'limit: 2021/07/31, need: 9hours',\n'task2: limit: 2021/08/02, need: 2hours'}",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
