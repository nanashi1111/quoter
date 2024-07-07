import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quoter/models/remove_ads_model.dart';

class RemoveAdsModal extends StatelessWidget {

  final Function onRemoveAds1Month;
  final Function onRemoveAds2Months;
  final Function onRemoveAds6Months;
  final Function onRemoveAdsForever;

  const RemoveAdsModal({super.key, required this.onRemoveAds1Month, required this.onRemoveAds2Months, required this.onRemoveAds6Months, required this.onRemoveAdsForever});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          alignment: Alignment.center,
          child: Text("Remove ads options", style: GoogleFonts.montserrat(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700)),
        ),
        RemoveAdsItem(model: RemoveAdsModel(title: "For 1 month", price: 15), onSelected: (){
          onRemoveAds1Month();
        }),
        RemoveAdsItem(model: RemoveAdsModel(title: "For 2 months", price: 20), onSelected: (){
          onRemoveAds2Months();
        }),
        RemoveAdsItem(model: RemoveAdsModel(title: "For 6 months", price: 50), onSelected: (){
          onRemoveAds6Months();
        }),
        RemoveAdsItem(model: RemoveAdsModel(title: "Forever", price: 100), onSelected: (){
          onRemoveAdsForever();
        }),
      ],
    );
  }
}

class RemoveAdsItem extends StatelessWidget {
  final RemoveAdsModel model;
  final Function onSelected;

  const RemoveAdsItem({super.key, required this.model, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: (){
          onSelected();
          context.pop();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            children: [
             Expanded(child:  Text(model.title ?? "", style: GoogleFonts.montserrat(
                 color: Colors.black,
                 fontSize: 14
             ),)),
              Text("${model.price} USD", style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 12
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
