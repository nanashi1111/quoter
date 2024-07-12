import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
      alignment: Alignment.center,
    );
  }
}