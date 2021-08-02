//@dart = 2.9
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  List tasks;
  //YYYY-MM-DDTHH:MM:SS+GMT
  //'{"key1":"value", "key2":123, "key3":{"key4":"value2", "key5":456}}'
  @override
  void initState() {
    super.initState();
    var decoded = json.decode(
        "{'id1':{'title': 'task1', 'detail': 'test1', 'limit': '2021-08-02T12:00:00+09:00', 'goal': '2hours', 'achieved': 'false'},'id2':{'title': 'task2', 'detail': 'test2', 'limit': '2021-08-03T12:00:00+09:00', 'goal': '1hour', 'achieved': 'false'}}");
    decoded.forEach((key, value) {
      tasks.add(json.decode(value));
    });
  }

  @override
  Widget build(BuildContext context) {
    var contentWidgets = _makeWidgets();
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Task'),
      ),
      // body: ListView(
      //   children: <Widget>[
      //     for (var task in tasks)
      //       {
      //         Text(
      //           task['title'],
      //         ),
      //       }
      //   ],
      // ),
      body: ListView(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: contentWidgets),
        ],
      ),
    );
  }

  List<Widget> _makeWidgets() {
    var contentWidgets = List<Widget>();

    contentWidgets.add(Text('Hello'));
    if (true) {
      contentWidgets.add(Padding(
        padding: EdgeInsets.only(top: 10, right: 20, bottom: 30, left: 40),
        child: Text('world'),
      ));
    }

    return contentWidgets;
  }
}
