//@dart = 2.9

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/taskadd.dart';
import 'package:intl/date_symbol_data_local.dart';

// import 'pages/basics_example.dart';
// import 'pages/complex_example.dart';
// import 'pages/events_example.dart';
// import 'pages/multi_example.dart';
// import 'pages/range_example.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import './utils.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  Map<DateTime, List> _eventsList = {};
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  String res = '';
  List<Map<String, dynamic>> events = List<Map<String, dynamic>>();

  @override
  void initState() {
    super.initState();
    String response = '''[
                    {
                        "date": "2021-08-04T09:24:58+09:00",
                        "task": [
                            {
                                "title": "enpit",
                                "detail": "ιηΊγγ",
                                "tasktime": "02:00:00",
                                "deadline": "2021-08-31T00:00:00+09:00",
                                "created_at": "2021-08-04T09:23:59.473077+09:00",
                                "progress": [
                                    {
                                        "progress": 50,
                                        "date": "2021-08-04T09:24:13+09:00"
                                    },
                                    {
                                        "progress": 100,
                                        "date": "2021-08-05T09:24:13+09:00"
                                    }
                                ]
                            },
                            {
                                "title": "painting",
                                "detail": "η΅΅γζγ",
                                "tasktime": "02:00:00",
                                "deadline": "2021-08-31T00:00:00+09:00",
                                "created_at": "2021-08-04T09:23:59.473077+09:00",
                                "progress": [
                                    {
                                        "progress": 50,
                                        "date": "2021-08-04T09:24:13+09:00"
                                    },
                                    {
                                        "progress": 100,
                                        "date": "2021-08-05T09:24:13+09:00"
                                    }
                                ]
                            }
                        ]
                    },
                    {
                        "date": "2021-08-05T09:24:58+09:00",
                        "task": [
                            {
                                "title": "enpit",
                                "detail": "ιηΊγγ",
                                "tasktime": "02:00:00",
                                "deadline": "2021-08-31T00:00:00+09:00",
                                "created_at": "2021-08-04T09:23:59.473077+09:00",
                                "progress": [
                                    {
                                        "progress": 50,
                                        "date": "2021-08-04T09:24:13+09:00"
                                    },
                                    {
                                        "progress": 100,
                                        "date": "2021-08-05T09:24:13+09:00"
                                    }
                                ]
                            },
                            {
                                "title": "painting",
                                "detail": "η΅΅γζγ",
                                "tasktime": "02:00:00",
                                "deadline": "2021-08-31T00:00:00+09:00",
                                "created_at": "2021-08-04T09:23:59.473077+09:00",
                                "progress": [
                                    {
                                        "progress": 50,
                                        "date": "2021-08-04T09:24:13+09:00"
                                    },
                                    {
                                        "progress": 100,
                                        "date": "2021-08-05T09:24:13+09:00"
                                    }
                                ]
                            }
                        ]
                    }
                ]
                ''';
    var decoded = json.decode(response);
    decoded.forEach((value) {
      // print(value);
      events.add(value);
    });
    // String response = '''[[{"date":"2021-08-03"},
    //                       {"id1":"id1", "title": "task1", "detail": "test1", "limit": "2021-08-05T12:00:00+09:00", "goal": "2hours", "achieved": "false", "left": "60"},
    //                       {"id2":"id2", "title": "task2", "detail": "test2", "limit": "2021-08-07T12:00:00+09:00", "goal": "1hour", "achieved": "false",  "left": "80"}],
    //                     [{"date":"2021-08-04"},
    //                       {"id1":"id1", "title": "task1", "detail": "test1", "limit": "2021-08-05T12:00:00+09:00", "goal": "2hours", "achieved": "false", "left": "40"},
    //                       {"id1":"id1", "title": "task2", "detail": "test2", "limit": "2021-08-07T12:00:00+09:00", "goal": "1hour", "achieved": "false", "left": "60"}]]''';
    // List<dynamic> events = List<dynamic>();

    print("print");
    print(events[0]["date"]);
    print(events[0]["task"]);
    print(events[0]["task"][0]);
    print(events[0]["task"][0]["progress"]);
    print(events[0]["task"][0]["progress"][0]);
    print(events[0]["task"][0]["progress"][0]["progress"]);
    print(events[0]["task"][0]["progress"][0]["date"]);
    print("formatting1");
    print(date_format(events[0]["date"]));
    print("formatting2");
    print(date_format(events[0]["task"][0]["progress"][0]["date"]));
    print(date_format(events[0]["date"]) ==
        date_format(events[0]["task"][0]["progress"][0]["date"]));
    initializeDateFormatting("ja_JP");

    void test() async {
      var response2 = await fetchStores();
      print("response");
      print(response2);

      // var decoded = json.decode(response)
      // decoded.forEach((value){
      //   events.add(value);
      // });
      var tasks = Today_calc(response2);
      print(tasks);
      print(tasks[0]);
      _selectedDay = _focusedDay;
      _eventsList = {
        // DateTime.now().subtract(Duration(days: 2)): [
        //   'task1: ιζζΈγΏ:1ζι, ζ?γ:75%, ζι:7/31',
        //   'task2: ιζζΈγΏ:20ε, ζ?γ:90%, ζι:8/4',
        // ],
        for (var event in events)
          DateTime.parse(event["date"]): [
            for (var task in event["task"])
              for (var left in task["progress"])
                for (var task_task in tasks)
                  if (date_format(event["date"]) == date_format(left["date"]) &&
                      task["title"] == task_task["title"])
                    // if (true)
                    task["title"] +
                        "   η?ζ¨:" +
                        task_task["goal"] +
                        "hours" +
                        "   δ»ζ₯γη΅γγγ¨ζ?γ:" +
                        (100 - left["progress"]).toString() +
                        "%   ζι:" +
                        date_format(task["deadline"])
          ]
      };

      // _selectedDay = _focusedDay;
      // _eventsList = {
      //   for (var event in events)
      //     DateTime.parse(event["date"]): [
      //       for (var task in event["task"])
      //         for (var left in task["progress"])
      //           if (date_format(event["date"]) == date_format(left["date"]))
      //             task["title"] +
      //                 "   η?ζ¨:" +
      //                 "   δ»ζ₯γη΅γγγ¨ζ?γ:" +
      //                 (100 - left["progress"]).toString() +
      //                 "%   ζι:" +
      //                 date_format(task["deadline"])
      //     ]
      // for (var event in events)
      //   DateTime.parse(event[0]["date"]): [
      //     for (var task in event.sublist(1))
      //       task["title"] +
      //           "   η?ζ¨:" +
      //           task["goal"] +
      //           "   ιζεΊ¦:" +
      //           100 -
      //           int.parse(task["left"]) +
      //           "%   ζι:" +
      //           date_format(task["limit"])
      //   ]

      // DateTime.now().subtract(Duration(days: 2)): [
      //   'task1: ιζζΈγΏ:1ζι, ζ?γ:75%, ζι:7/31',
      //   'task2: ιζζΈγΏ:20ε, ζ?γ:90%, ζι:8/4',
      // ],
      // DateTime.now().subtract(Duration(days: 1)): [
      //   'task1: ιζζΈγΏ:30ε, ζ?γ:63%, ζι:7/31',
      //   'task2: ιζζΈγΏ:20ε, ζ?γ:80%, ζι:8/4',
      // ],
      // DateTime.now(): [
      //   'task1: η?ζ¨:1ζι30ε, ζ?γ:32%, ζι:7/31',
      //   'task2: ιζζΈγΏ:20ε, ζ?γ:70%, ζι:8/4',
      // ],
      // DateTime.now().add(Duration(days: 1)): [
      //   'task1: η?ζ¨:1ζι30ε, ζ?γ:0%, ζι:7/31',
      //   'task2: η?ζ¨:20ε, ζ?γ:60%, ζι:8/4',
      // ],
      // DateTime.now().add(Duration(days: 2)): [
      //   'task2: η?ζ¨:40ε, ζ?γ:40%, ζι:8/4',
      // ],
      // DateTime.now().add(Duration(days: 3)): [
      //   'task2: η?ζ¨:20ε, ζ?γ:30%, ζι:8/4',
      // ],
      // DateTime.now().add(Duration(days: 4)): [
      //   'task2: η?ζ¨:20ε, ζ?γ:20%, ζι:8/4',
      // ],
      // DateTime.now().add(Duration(days: 5)): [
      //   'task2: η?ζ¨:40ε, ζ?γ:0%, ζι:8/4',
      // ],
    }

    test3();
    print("_eventsList");
    print(_eventsList);
  }

  void test3() async {
    String response = '''[
                      {
                          "date": "2021-08-04T09:24:58+09:00",
                          "task": [
                              {
                                  "title": "enpit",
                                  "detail": "ιηΊγγ",
                                  "tasktime": "02:00:00",
                                  "deadline": "2021-08-31T00:00:00+09:00",
                                  "created_at": "2021-08-04T09:23:59.473077+09:00",
                                  "progress": [
                                      {
                                          "progress": 50,
                                          "date": "2021-08-04T09:24:13+09:00"
                                      },
                                      {
                                          "progress": 100,
                                          "date": "2021-08-05T09:24:13+09:00"
                                      }
                                  ]
                              },
                              {
                                  "title": "painting",
                                  "detail": "η΅΅γζγ",
                                  "tasktime": "02:00:00",
                                  "deadline": "2021-08-31T00:00:00+09:00",
                                  "created_at": "2021-08-04T09:23:59.473077+09:00",
                                  "progress": [
                                      {
                                          "progress": 50,
                                          "date": "2021-08-04T09:24:13+09:00"
                                      },
                                      {
                                          "progress": 100,
                                          "date": "2021-08-05T09:24:13+09:00"
                                      }
                                  ]
                              }
                          ]
                      },
                      {
                          "date": "2021-08-05T09:24:58+09:00",
                          "task": [
                              {
                                  "title": "enpit",
                                  "detail": "ιηΊγγ",
                                  "tasktime": "02:00:00",
                                  "deadline": "2021-08-31T00:00:00+09:00",
                                  "created_at": "2021-08-04T09:23:59.473077+09:00",
                                  "progress": [
                                      {
                                          "progress": 50,
                                          "date": "2021-08-04T09:24:13+09:00"
                                      },
                                      {
                                          "progress": 100,
                                          "date": "2021-08-05T09:24:13+09:00"
                                      }
                                  ]
                              },
                              {
                                  "title": "painting",
                                  "detail": "η΅΅γζγ",
                                  "tasktime": "02:00:00",
                                  "deadline": "2021-08-31T00:00:00+09:00",
                                  "created_at": "2021-08-04T09:23:59.473077+09:00",
                                  "progress": [
                                      {
                                          "progress": 50,
                                          "date": "2021-08-04T09:24:13+09:00"
                                      },
                                      {
                                          "progress": 100,
                                          "date": "2021-08-05T09:24:13+09:00"
                                      }
                                  ]
                              }
                          ]
                      }
                  ]
                  ''';
    var decoded = json.decode(response);
    decoded.forEach((value) {
      events.add(value);
    });

    var response3 = await fetchStores();
    // print("response");
    // print(response3);

    // var decoded = json.decode(response)
    // decoded.forEach((value){
    //   events.add(value);
    // });
    var tasks = Today_calc(response3);
    _selectedDay = _focusedDay;
    _eventsList = {
      // DateTime.now().subtract(Duration(days: 2)): [
      //   'task1: ιζζΈγΏ:1ζι, ζ?γ:75%, ζι:7/31',
      //   'task2: ιζζΈγΏ:20ε, ζ?γ:90%, ζι:8/4',
      // ],
      for (var event in events)
        DateTime.parse(event["date"]): [
          for (var task in event["task"])
            for (var left in task["progress"])
              for (var task_task in tasks)
                if (date_format(event["date"]) == date_format(left["date"]) &&
                    task["title"] == task_task["title"])
                  // if (true)
                  task["title"] +
                      "   η?ζ¨:" +
                      task_task["goal"] +
                      "hours" +
                      "   δ»ζ₯γη΅γγγ¨ζ?γ:" +
                      (100 - left["progress"]).toString() +
                      "%   ζι:" +
                      date_format(task["deadline"])
        ]
    };

    print("eventsList in test3");
    print(_eventsList);
  }

  // test3();

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List _getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Schedule'),
      ),
      body: FutureBuilder(
          future: _getFutureValue(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData && snapshot.data != null) {
              return Column(
                children: [
                  TableCalendar(
                    locale: 'ja_JP',
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    eventLoader: _getEventForDay,
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                        _getEventForDay(selectedDay);
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: _getEventForDay(_selectedDay)
                        .map((event) => ListTile(
                              title: Text(event.toString()),
                            ))
                        .toList(),
                  )
                ],
              );
            } else {
              print("null");
              return Container(
                child: Text('null'),
              );
            }
          }
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(Icons.add),
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             // οΌ2οΌ ε?ιγ«θ‘¨η€ΊγγγγΌγΈ(γ¦γ£γΈγ§γγ)γζε?γγ
          //             builder: (context) => TaskAdd(res_: res)));
          //   },
          // ),
          ),
    );
  }
}

Future<String> _getFutureValue() async {
  return Future.delayed(new Duration(seconds: 2), () {
    return "completed!!";
  });
  // ζ¬δΌΌηγ«ιδΏ‘δΈ­γθ‘¨ηΎγγγγγ«οΌη§ιγγγ
  // await Future.delayed(
  //   Duration(seconds: 5),
  // );

  // try {
  //   // εΏγγ¨γ©γΌγηΊηγγγ
  //   throw Exception("γγΌγΏγ?εεΎγ«ε€±ζγγΎγγ");
  // } catch (error) {
  //   return Future.error(error);
  // }
}
