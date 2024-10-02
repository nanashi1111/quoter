import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/models/quote.dart';
import 'package:quoter/screen/menu/components/mene_item.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            'assets/images/bg_menu.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.only(top: 50),
            color: Colors.black.withOpacity(0.5),
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Quote creator",
                  style: TextStyle(fontFamily: "Painter", fontSize: 40, color: Colors.white),
                ),
                const Spacer(),
                Column(
                  children: [
                    MenuItem(title: "Best quotes", onClick: (){
                      context.push('/category');
                    }),
                    const SizedBox(height: 25,),
                    MenuItem(title: "Create My Quote", onClick: (){
                      Map<String, String> params = {}..addEntries(List.of([MapEntry("quote", jsonEncode(const Quote(content: ""))), const MapEntry("backgroundPatternPos", "1")]));
                      context.pushNamed("editor", pathParameters: params);
                    }),
                    const SizedBox(height: 25,),
                    MenuItem(title: "My gallery", onClick: (){}),
                    const SizedBox(height: 60,),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
