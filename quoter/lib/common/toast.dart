
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

showToast(BuildContext context, String content) {
  toastification.show(
    context: context,
    alignment: Alignment.bottomCenter,
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
    autoCloseDuration: const Duration(seconds: 2),
    description: Text(
      content,
      style: const TextStyle(color: Colors.blue),
    ),
  );
}