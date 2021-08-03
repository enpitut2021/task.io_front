//@dart = 2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/taskadd.dart';
import 'dart:convert';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/date_symbol_data_local.dart';
import './today.dart';

String date_format(@required String date) {
  // 2021-08-07T12:00:00+09:00
  date = date.replaceAll('-', '/');
  final result = date.substring(0, 10);
  return result;
}

Future<dynamic> fetchStores() async {
  var formatter = new DateFormat('yyyy-MM-dd');
  final now = DateTime.now();
  var date = formatter.format(now);
  final url = 'https://task-io-blitzkrieg.herokuapp.com/api/tasks/?day=' + date;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print(response.statusCode);
    print("success");
    String responseUTF = utf8.decode(response.bodyBytes);
    print(responseUTF);
    var decodedJson = json.decode(responseUTF);
    print(decodedJson);
    return decodedJson;
  } else {
    print("failed");
  }
}

Future<dynamic> today_calc(response) async {
  List<Map> ret = await List<Map>();
  var task;
  for (task in response) {
    Map each;
    DateTime deadline = DateTime.parse(task["deadline"]);
    DateTime created_at = DateTime.parse(task["created_at"]);
    DateTime now = DateTime.now();
    var all_days = created_at.difference(deadline).inDays;
    print(all_days);
    var left_days = now.difference(deadline).inDays;
    var goal = int.parse(task["tasktime"].substring(3, 5)) / all_days;
    var left = left_days / all_days * 100 % 1;
    print(goal);
    each.addAll({
      "goal": goal,
      "title": task["title"],
      "limit": task["deadline"],
      "left": left,
    });
    ret.add(each);
  }
  return ret;
}
