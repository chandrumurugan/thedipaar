import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ToastUtil {
  static void show(String message, int sts) {
    Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.grey[200],
      textColor: sts == 0 ? Colors.red : Colors.green,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}