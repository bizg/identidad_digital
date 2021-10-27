import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void show(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromRGBO(222, 222, 222, 0.1),
        child: Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(
            top: 305,
            left: 180,
            bottom: 305,
            right: 180
          ),
          child: const CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.green,
            strokeWidth: 5,
            
          ),
        ),
      );
    }
  );
}

void dismiss(BuildContext context) {
  Navigator.pop(context);
}