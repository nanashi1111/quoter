import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/screen/go_premium/confirm_bloc.dart';

class ConfirmPurchaseModal extends StatelessWidget {
  final int type;
  final Function onConfirm;

  const ConfirmPurchaseModal({super.key, required this.type, required this.onConfirm});

  String _providePriceText() {
    String price = "";
    switch (type) {
      case 1:
        price = "15 USD";
        break;
      case 2:
        price = "20 USD";
        break;
      case 6:
        price = "50 USD";
        break;
      default:
        price = "100 USD";
        break;
    }
    return price;
  }

  String _provideDescription() {
    String packageName = "";
    switch (type) {
      case 1:
        packageName = "Remove ads for 1 month";
        break;
      case 2:
        packageName = "Remove ads for 2 months";
        break;
      case 6:
        packageName = "Remove ads for 6 months";
        break;
      default:
        packageName = "Remove ads forever";
        break;
    }
    return packageName;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfirmBloc>(
      create: (context) => ConfirmBloc(),
      child: BlocBuilder<ConfirmBloc, ConfirmState>(
        builder: (context, state) {
          return Container(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black), children: [
                    TextSpan(text: "You are purchasing ${_providePriceText()} for our ${_provideDescription()} package. You will be charged immediately after clicking PURCHASE "
                        "button. Please "
                        "carefully "
                        "read our "),
                    TextSpan(
                        text: "Term of use",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            debugPrint("TERM");
                            MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.openUrl, data:"https://cungdev.com/quote-creator-eula/");
                          },
                        style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue)),
                    TextSpan(text: " and "),
                    TextSpan(
                        text: "Privacy & Policy",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            debugPrint("Go policy");
                            MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.openUrl, data:"https://cungdev.com/quote-creator-privacy-policy/");
                          },
                        style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue)),
                    TextSpan(text: ". You can only purchase after agreeing to and accepting the following: "),
                  ]),
                ),
                verticalSpacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(-10, 0),
                      child: Checkbox(
                          value: state.confirmed,
                          onChanged: (value) {
                            context.read<ConfirmBloc>().add(const ConfirmEvent.confirm());
                          }),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Text("I accept Term of Use and Privacy & Policy", style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black)),
                        onTap: () {
                          context.read<ConfirmBloc>().add(const ConfirmEvent.confirm());
                        },
                      ),
                    )
                  ],
                ),
                verticalSpacing(10),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: state.confirmed ? HexColor("#2F80ED") : HexColor("#2F80ED").withOpacity(0.7)),
                    child: Text(
                      "PURCHASE",
                      style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    if (!state.confirmed) {
                      return;
                    }
                    onConfirm();
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
