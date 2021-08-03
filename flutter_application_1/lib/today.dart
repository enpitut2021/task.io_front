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

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  List<dynamic> tasks = List<dynamic>();
  List<dynamic> response;
  //YYYY-MM-DDTHH:MM:SS+GMT
  //'{"key1":"value", "key2":123, "key3":{"key4":"value2", "key5":456}}'
  String res = '';
  DateFormat formatter;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ja_JP', null);
    formatter = new DateFormat('yyyy-MM-dd');
    void test() async {
      // response = await fetchStores();
      print("response");
      print(response);
      tasks = '[
        {
          "id1": "id1",
          "title": "task1",
          "detail": "test1",
          "limit": "2021-08-02T12:00:00+09:00",
          "goal": "2hours",
          "achieved": "false",
          "left": "80"
        },
        {
          "id2": "id2",
          "title": "task2",
          "detail": "test2",
          "limit": "2021-08-03T12:00:00+09:00",
          "goal": "1hour",
          "achieved": "false",
          "left": "50"
        }
      ]';
      var decoded = json.decode(response)
      decoded.forEach((value){
        events.add(value);
      });
      // tasks = await today_calc(response);
    }

    test();
    // '[{"id1":"id1", "title": "task1", "detail": "test1", "limit": "2021-08-02T12:00:00+09:00", "goal": "2hours", "achieved": "false", "left": "80"}, {"id2":"id2", "title": "task2", "detail": "test2", "limit": "2021-08-03T12:00:00+09:00", "goal": "1hour", "achieved": "false", "left": "50"}]';

    print("decoded");
    //   decoded.forEach((value) {
    //     print(value);
    //     tasks.add(value);
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Today\'s Task'),
          actions: <Widget>[
            IconButton(
                onPressed: () async {
                  response = await fetchStores();
                  print('response_pressed');
                  print(response);
                  // tasks = await today_calc(response);
                  // print(response[0]["title"]);
                },
                icon: Icon(Icons.autorenew))
          ],
        ),
        body: ListView(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          for (var task in tasks)
            Column(
              children: [
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
                          "~" + date_format(task["limit"]),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          task["goal"],
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                                color: Colors.lightGreenAccent[400],
                                width: 1.30 * (100 - int.parse(task["left"])),
                                height: 25),
                            Container(
                                color: Colors.blueGrey[200],
                                width: 1.30 * int.parse(task["left"]),
                                height: 25),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 40,
                  thickness: 3,
                  color: Colors.black,
                  indent: 0,
                  endIndent: 0,
                ),
              ],
            ),
        ]));
  }
}
