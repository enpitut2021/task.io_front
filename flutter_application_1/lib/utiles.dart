//@dart = 2.9
import 'package:flutter/cupertino.dart';

String date_format(@required String date) {
  // 2021-08-07T12:00:00+09:00
  date = date.replaceAll('-', '/');
  final result = date.substring(0, 9);
  print(result);
  return result;
}
