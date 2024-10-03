import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/dialog.dart';
import 'package:quoter/common/method_channel_handler.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/repositories/ads_repository.dart';
import 'package:quoter/screen/go_premium/confirm_purchase_modal.dart';
import 'package:quoter/screen/go_premium/go_premium_item.dart';

class GoPremiumScreen extends StatelessWidget {
  const GoPremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkCommonColor,
        centerTitle: true,
        title: Text(
          "Remove ads",
          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        elevation: 10,
        leading: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            child: SvgPicture.asset(
              'assets/images/ic_back.svg',
              color: Colors.white,
              width: 25,
              height: 25,
            ),
          ),
          onTap: () {
            context.pop();
          },
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(child: Text(
                "Restore",
                style: GoogleFonts.montserrat(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
              ),),
            ),
            onTap: () async {
              bool restored = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.restoreProduct);
              if (restored) {
                showInformationDialog(context, "Restored", "You have restored purchases", confirmActon: () async {
                  context.pop();
                });
              } else {
                showInformationDialog(context, "Error", "Somethings went wrong, please try again later");
              }
            },
          )
        ],
      ),
      backgroundColor: darkCommonColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Image.asset(
              'assets/images/app_icon.png',
              width: 100,
              height: 100,
            ),
            verticalSpacing(20),
            GoPremiumItem(
                onClick: () {
                  _showConfirmationDialog(context, 1);
                },
                title: "Monthly\nSubscription",
                price: '15 USD',
                description: "• Free ads for 1 month\n• Auto renew after expired\n• You can cancel anytime",
                colors: [HexColor("#2F80ED"), HexColor("#56CCF2")],
                headerColor: HexColor("#2F80ED"),

                header: "Monthly Premium Subscription"),
            GoPremiumItem(
                onClick: () {
                  _showConfirmationDialog(context, 2);

                },
                title: "2 Months\nSubscription",
                price: '20 USD',
                description: "• Free ads for 2 months\n• Auto renew after expired\n• You can cancel anytime",
                colors: [HexColor("#0083B0"), HexColor("#00B4DB")],
                headerColor: HexColor("#0083B0"),
                header: "2 Months Premium Subscription"),
            GoPremiumItem(
                onClick: () {
                  _showConfirmationDialog(context, 6);

                },
                title: "6 Months\nSubscription",
                price: '50 USD',
                description: "• Free ads for 6 months\n• Auto renew after expired\n• You can cancel anytime",
                colors: [HexColor("#667db6"), HexColor("#0082c8")],
                headerColor: HexColor("#667db6"),
                header: "6 Months Premium Subscription"),
            GoPremiumItem(
                onClick: () {
                  _showConfirmationDialog(context, 0);

                },
                title: "Remove ads\nForever",
                price: '100 USD',
                description: "• Free ads forever",
                colors: [HexColor("#000046"), HexColor("#1CB5E0")],
                headerColor: Colors.white,
                header: "Remove ads forever"),
          ],
        ),
      ),
    );
  }

  _showConfirmationDialog(BuildContext context, int type) {
    showDialog(context: context, builder: (dialogContext) {
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
            Text("Confirmation",
              style: GoogleFonts.montserrat(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),),
            Expanded(child: GestureDetector(
              child: Container(
                alignment: Alignment.centerRight,
                child: Icon(Icons.close),
              ),
              onTap: (){
                dialogContext.pop();
              },
            ))
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              ConfirmPurchaseModal(type: type, onConfirm: () async {
                dialogContext.pop();
                bool purchaseResult = false;
                String successMessage = "";
                switch(type) {
                  case 1:
                    purchaseResult = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.removeAds1Month);
                    successMessage = "You have purchased for 1 month ads free. Have a good day. Thanks from Quoter team.";
                    break;
                  case 2:
                    purchaseResult = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.removeAds2Months);
                    successMessage = "You have purchased for 2 months ads free. Have a good day. Thanks from Quoter team.";
                    break;
                  case 6:
                    purchaseResult = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.removeAds6Months);
                    successMessage = "You have purchased for 6 months ads free. Have a good day. Thanks from Quoter team.";
                    break;
                  default:
                    purchaseResult = await MethodChannelHandler.instance.invokeMethod(MethodChannelHandler.removeAdsForever);
                    successMessage = "You have purchased for ads free. Have a good day. Thanks from Quoter team.";
                    break;
                }
                if (purchaseResult) {
                  AdsRepository.instance.setAdsEnabled(false);

                  showInformationDialog(context, "Purchase", successMessage, confirmActon: (){
                    context.pop();
                  }, barrierDismissible: false);
                } else {
                  showInformationDialog(context, "Error", "Something went wrong, please try again later");
                }
              })
            ],
          ),
        ),
      );
    });
  }
}
