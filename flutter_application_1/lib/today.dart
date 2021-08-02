//@dart = 2.9
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/taskadd.dart';
import 'dart:convert';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  List<dynamic> tasks = List<dynamic>();
  //YYYY-MM-DDTHH:MM:SS+GMT
  //'{"key1":"value", "key2":123, "key3":{"key4":"value2", "key5":456}}'
  String res = '';
  @override
  void initState() {
    super.initState();
    String respons =
        '{"id1":{"title": "task1", "detail": "test1", "limit": "2021-08-02T12:00:00+09:00", "goal": "2hours", "achieved": "false"},"id2":{"title": "task2", "detail": "test2", "limit": "2021-08-03T12:00:00+09:00", "goal": "1hour", "achieved": "false"}}';
    var decoded = json.decode(respons);
    print(respons);
    print(decoded);
    print(decoded["id1"]);
    decoded.forEach((key, value) {
      print(key);
      print(value);
      tasks.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today\'s Task'),
      ),
      body: ListView(
        children: <Widget>[
          // for (var task in tasks)
          //   Card(
          //     child: ListTile(
          //       title: Text(task['title']),
          //     ),
          //   ),
          for (var task in tasks)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      task["title"],
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff333333),
                      ),
                    ),
                    Text(
                      task["limit"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff333333),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 60,
                ),
                // ClipRRect(
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(10),
                //       bottomLeft: Radius.circular(10),
                //     ),
                //     child: Image.network(
                //       'https://picsum.photos/200',
                //       width: 100,
                //       height: 100,
                //     )),
                Text(
                  task["goal"],
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
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
