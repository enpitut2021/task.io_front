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
  // List<dynamic> tasks = ["0", "1", "2", "3"];
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

    test();
    // '[{"id1":"id1", "title": "task1", "detail": "test1", "limit": "2021-08-02T12:00:00+09:00", "goal": "2hours", "achieved": "false", "left": "80"}, {"id2":"id2", "title": "task2", "detail": "test2", "limit": "2021-08-03T12:00:00+09:00", "goal": "1hour", "achieved": "false", "left": "50"}]';
    // print(tasks);
    print("decoded");
    //   decoded.forEach((value) {
    //     print(value);
    //     tasks.add(value);
    //   });
  }

  void test() async {
    response = await fetchStores();
    print("response");
    print(response);

    // var decoded = json.decode(response)
    // decoded.forEach((value){
    //   events.add(value);
    // });
    tasks = Today_calc(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Today\'s Task'),
        // actions: <Widget>[
        //   IconButton(
        //       onPressed: () async {
        //         response = await fetchStores();
        //         print('response_pressed');
        //         print(response);
        //         tasks = Today_calc(response);
        //         // print(response[0]["title"]);
        //       },
        //       icon: Icon(Icons.autorenew))
        // ],
      ),
      body: FutureBuilder(
        future: _getFutureValue(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData && snapshot.data != null) {
            print("is in!");
            // print(tasks);
            return ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                for (var task in tasks)
                  // for (var task = 0; task < 3; task++)
                  OutlinedButton(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(width: 30),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  //SizedBox(height: 5),
                                  Container(
                                    width: 100,
                                    child: Text(
                                      //"Hello WOrlaaaaaaaaaaaaaaaaaaaaad!",
                                      task["title"],
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff333333),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: 110,
                                    child: Text(
                                      "~" + date_format(task["limit"]),
                                      //"hello",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: const Color(0xff333333),
                                      ),
                                      textAlign: TextAlign.center,
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
                                    task["goal"] + "hours",
                                    //"hellooo",
                                    style: TextStyle(
                                      fontSize: 40,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          color: Colors.lightGreenAccent[400],
                                          width: 1.20 *
                                              (100 - int.parse(task["left"])),
                                          // width: 1.30 * (100 - 80),
                                          height: 25),
                                      Container(
                                          color: Colors.blueGrey[200],
                                          width: 1.20 * int.parse(task["left"]),
                                          // width: 1.30 * 20,
                                          height: 25),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Divider(
                          //   height: 40,
                          //   thickness: 3,
                          //   color: Colors.black,
                          //   indent: 0,
                          //   endIndent: 0,
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      // style: OutlineButton.styleFrom(
                      //   primary:Colors.black,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circula(10),
                      //   ),
                      //   side:const BorderSide(),
                      // ),
                      onPressed: () {
                        var result = showDialog<int>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('詳細'),
                                content: Text(task['detail']),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Cancel'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(0),
                                  ),
                                  FlatButton(
                                    child: Text('OK'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(1),
                                  ),
                                ],
                              );
                            });
                      }),
              ],
            );
          } else {
            print("null");
            return Container(
              child: Text('null'),
            );
          }
          ;
        },
      ),
    );
  }
}

Future<String> _getFutureValue() async {
  return Future.delayed(new Duration(seconds: 2), () {
    return "completed!!";
  });
  // 擬似的に通信中を表現するために１秒遅らせる
  // await Future.delayed(
  //   Duration(seconds: 5),
  // );

  // try {
  //   // 必ずエラーを発生させる
  //   throw Exception("データの取得に失敗しました");
  // } catch (error) {
  //   return Future.error(error);
  // }
}
