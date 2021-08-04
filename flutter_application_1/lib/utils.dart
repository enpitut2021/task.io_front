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
  print("fetchStores");
  var formatter = new DateFormat('yyyy-MM-dd');
  final now = DateTime.now();
  var date = formatter.format(now);
  final url = 'https://task-io-blitzkrieg.herokuapp.com/api/tasks/?day=' + date;
  final response = await http.get(url);
  if (response.statusCode == 200) {
    // print(response.statusCode);
    print("success");
    String responseUTF = utf8.decode(response.bodyBytes);
    print(responseUTF);
    var decodedJson = json.decode(responseUTF);
    // print(decodedJson);
    return decodedJson;
  } else {
    print("failed");
  }
}

List<Map> Today_calc(response) {
  print("0");
  List<Map> ret = [];
  var task;
  print("1");
  for (task in response) {
    print("2");
    Map<String, dynamic> each = {};
    print("3");
    DateTime deadline = DateTime.parse(task["deadline"]);
    print("4");
    DateTime createdAt = DateTime.parse(task["created_at"]);
    print("5");
    DateTime now = DateTime.now();
    var allDays = deadline.difference(createdAt).inDays;
    print(allDays);
    var leftDays = deadline.difference(now).inDays;
    var goal = int.parse(task["tasktime"].substring(3, 5)) / (allDays + 1) + 1;
    var left = (leftDays - 1) / allDays * 100;
    // var goal = "20";
    // var left = "30";
    print(goal);
    // print(allDays.runtimeType);
    // print(leftDays.runtimeType);
    print(goal.runtimeType);
    print("left.rentimeType");
    print(left.runtimeType);
    String strgoal = goal.ceil().toString();
    String strleft = left.ceil().toString();
    // print(allDays.runtimeType);
    // print(leftDays.runtimeType);
    print(goal.runtimeType);
    print(left.runtimeType);
    each.addAll({
      "goal": strgoal,
      "title": task["title"],
      "limit": task["deadline"],
      "left": strleft,
      "detail": task["detail"],
    });
    ret.add(each);
  }
  print(ret);
  return ret;
}
