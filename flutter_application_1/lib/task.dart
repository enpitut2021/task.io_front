// @dart=2.9
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  String res_;

  Task({Key key, @required this.res_}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          "{task1: 'limit: 2021/07/30, need: 3hours',\n'task2: limit: 2021/08/01, need: 4hours'}",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
