import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toastan {
  static void show_unusual(String massege, context, bool done) {
    FToast fToast = FToast();
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: done ? Colors.green : Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            done ? Icons.check : Icons.close,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            massege,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
    fToast.init(context);
    fToast.showToast(child: toast, toastDuration: Duration(seconds: 3));
  }
}
