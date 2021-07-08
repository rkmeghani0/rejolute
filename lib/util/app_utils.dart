import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DebugMode {
  static bool get isInDebugMode {
    bool inDebugMode = true;
    return inDebugMode;
  }
}

class AppUtils {
  /// showing toast message
  static void showSnackBar({
    @required String? text,
    @required BuildContext? context,
  }) {
    final snackBar = SnackBar(
      content: Text(text!),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  static void showToast(String text,
      {Color backgroundColor = Colors.red, ToastGravity? toastGravity}) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity ?? ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static double roundDouble(double value, int places) {
    double? mod = pow(10.0, places) as double?;
    return ((value * mod!).round().toDouble() / mod);
  }

  ///Used to hide keyboard
  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  ///return true if keyboard is visible
  static bool isKeyBoardVisible(BuildContext context) {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  static String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }
}
