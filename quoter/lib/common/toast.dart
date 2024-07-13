import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

showToast(BuildContext context, String content, {Alignment alignment = Alignment.bottomCenter, Duration autoCloseDuration = const Duration(seconds: 2), bool bigToast = false}) {
  toastification.show(
    context: context,
    alignment: alignment,
    animationDuration: const Duration(milliseconds: 300),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    style: ToastificationStyle.flat,
    showProgressBar: false,
    autoCloseDuration: autoCloseDuration,
    description: !bigToast
        ? Text(
            content,
            style: const TextStyle(color: Colors.blue),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Container(
              width: double.infinity,
              child: Text(
                content,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ),
  );
}
