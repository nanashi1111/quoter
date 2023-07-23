import 'package:flutter/material.dart';

class ListLoadingFooter extends StatelessWidget {
  const ListLoadingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.white,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: Colors.blueAccent,),
    );
  }
  
}