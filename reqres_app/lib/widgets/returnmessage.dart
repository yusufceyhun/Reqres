import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReturnMessage {
  bool result;
  String message;

  ReturnMessage(this.result, this.message);
}

void showReturnMessage(ReturnMessage message) {
  Fluttertoast.showToast(
    msg: message.message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: message.result ? Colors.green : Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
