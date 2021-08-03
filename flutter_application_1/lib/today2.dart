//@dart = 2.9
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/taskadd.dart';
import 'dart:convert';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/date_symbol_data_local.dart';
import './utils.dart';

class Today2 extends StatefulWidget {
  @override
  _TodayState2 createState() => _TodayState2();
}

class _TodayState2 extends State<Today2> {
  List<dynamic> tasks = List<dynamic>();
  //YYYY-MM-DDTHH:MM:SS+GMT
  //'{"key1":"value", "key2":123, "key3":{"key4":"value2", "key5":456}}'
  String res = '';
  DateFormat formatter;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ja_JP', null);
    formatter = new DateFormat('yyyy-MM-dd');

    String respons =
        '[{"id1":"id1", "title": "task1", "detail": "test1", "limit": "2021-08-02T12:00:00+09:00", "goal": "2hours", "achieved": "false", "progress": "805"}, {"id2":"id2", "title": "task2", "detail": "test2", "limit": "2021-08-03T12:00:00+09:00", "goal": "1hour", "achieved": "false"}]';
    var decoded = json.decode(respons);
    print("respons");
    print(respons);
    print("decoded");
    print(decoded);
    print(decoded[0]);
    decoded.forEach((value) {
      print(value);
      tasks.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Today\'s Task'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                fetchStores();
              },
              icon: Icon(Icons.autorenew))
        ],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          for (var task in tasks)
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text(
                        task["title"],
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff333333),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        date_format(task["limit"]),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xff333333),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    task["goal"],
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 40,
                thickness: 3,
                color: Colors.blue,
                indent: 0,
                endIndent: 0,
              ),
            ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) => TaskAdd(res_: res)));
        },
      ),
    );
  }
}
