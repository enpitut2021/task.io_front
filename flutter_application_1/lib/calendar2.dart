// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/taskadd.dart';
import 'package:intl/date_symbol_data_local.dart';

// import 'pages/basics_example.dart';
// import 'pages/complex_example.dart';
// import 'pages/events_example.dart';
// import 'pages/multi_example.dart';
// import 'pages/range_example.dart';

import 'package:table_calendar/table_calendar.dart';

class Calendar2 extends StatefulWidget {
  @override
  _Calendar2State createState() => _Calendar2State();
}

class _Calendar2State extends State<Calendar2> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _eventsList = {};
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  String res = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _eventsList = {
      DateTime.now().subtract(Duration(days: 2)): [
        'task1: 達成済み:1時間, 残り:75%, 期限:7/31',
        'task2: 達成済み:20分, 残り:90%, 期限:8/4',
      ],
      DateTime.now().subtract(Duration(days: 1)): [
        'task1: 達成済み:30分, 残り:63%, 期限:7/31',
        'task2: 達成済み:20分, 残り:80%, 期限:8/4',
      ],
      DateTime.now(): [
        'task1: 目標:1時間30分, 残り:32%, 期限:7/31',
        'task2: 達成済み:20分, 残り:70%, 期限:8/4',
        'task3: 目標:0分, 残り:100%, 期限:8/7',
      ],
      DateTime.now().add(Duration(days: 1)): [
        'task1: 目標:1時間30分, 残り:0%, 期限:7/31',
        'task2: 目標:20分, 残り:60%, 期限:8/4',
        'task3: 目標:20分, 残り:80%, 期限:8/7',
      ],
      DateTime.now().add(Duration(days: 2)): [
        'task2: 目標:40分, 残り:40%, 期限:8/4',
        'task3: 目標:1時間, 残り:80%, 期限:8/6',
      ],
      DateTime.now().add(Duration(days: 3)): [
        'task2: 目標:20分, 残り:30%, 期限:8/4',
        'task3: 目標:30分, 残り:70%, 期限:8/6',
      ],
      DateTime.now().add(Duration(days: 4)): [
        'task2: 目標:20分, 残り:20%, 期限:8/4',
        'task3: 目標:0分, 残り:70%, 期限:8/6',
      ],
      DateTime.now().add(Duration(days: 5)): [
        'task2: 目標:40分, 残り:0%, 期限:8/4',
        'task3: 目標:0分, 残り:70%, 期限:8/6',
      ],
      DateTime.now().add(Duration(days: 6)): [
        'task3: 目標:1時間30分, 残り:40%, 期限:8/6',
      ],
      DateTime.now().add(Duration(days: 7)): [
        'task3: 目標:2時間, 残り:0%, 期限:8/6',
      ],
    };
  }

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
        title: Text('calendar sample'),
      ),
      body: Column(
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
            children: _getEventForDay(_selectedDay!)
                .map((event) => ListTile(
                      title: Text(event.toString()),
                    ))
                .toList(),
          )
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
