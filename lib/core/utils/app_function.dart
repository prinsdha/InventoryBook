import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

flutterToast(String msg) async {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.black,
      backgroundColor: Colors.white,
      fontSize: 14);
}

void disposeKeyboard() {
  return FocusManager.instance.primaryFocus!.unfocus();
}

String getDayOfMonthSuffix(int dayNum) {
  if (!(dayNum >= 1 && dayNum <= 31)) {
    throw Exception('Invalid day of month');
  }

  if (dayNum >= 11 && dayNum <= 13) {
    return 'th';
  }

  switch (dayNum % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
