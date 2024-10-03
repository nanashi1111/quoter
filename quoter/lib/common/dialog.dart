
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/views.dart';

class InformationModal extends StatelessWidget {
  final String content;
  final String actionButtonContent;
  final Function confirmAction;

  const InformationModal({super.key, required this.content, required this.actionButtonContent, required this.confirmAction});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black), children: [
            TextSpan(text: content),
          ]),
        ),
        verticalSpacing(20),
        InkWell(
          child: Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: HexColor("#2F80ED")),
            child: Text(
              actionButtonContent,
              style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          onTap: () {
            confirmAction();
            context.pop();
          },
        )
      ],
    );
  }
}

showInformationDialog(BuildContext context, String title, String content, {Function? confirmActon, bool barrierDismissible = true}) {
  showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_icon.png',
              width: 30,
              height: 30,
            ),
            horizontalSpacing(10),
            Text(title,
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),),
            Expanded(child: GestureDetector(
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.close),
              ),
              onTap: (){
                context.pop();
              },
            ))
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              InformationModal(content: content, actionButtonContent: 'OK', confirmAction: (){
                if (confirmActon != null) {
                  confirmActon();
                }
              },)
            ],
          ),
        ),

      );
    },
  );
}
