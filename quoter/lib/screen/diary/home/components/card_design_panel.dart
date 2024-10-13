import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/views.dart';

const List<String> colors = [
  "#528B8B",
  "#A0522D",
  "#8B7D6B",
  "#1874CD",
  "#6E7B8B",
  "#00C5CD",
  "#00CD66",
  "#CDCD00",
  "#CD5555",
  "#CD919E",
  "#68228B",
  "#ECAB53",
  "#FFA07A",
  "#00008B",
  "#E6E6FA",
  "#CDC9C9"
];

class CardDesignPanel extends StatelessWidget {
  final ImagePicker picker = ImagePicker();
  final Function(String) onColorSelected;
  final Function(XFile) onImageSelected;

  CardDesignPanel({super.key, required this.onColorSelected, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacing(20),
          Text(
            "Design your card",
            style: GoogleFonts.lato(color: darkCommonColor.withOpacity(0.7), fontSize: 16, fontWeight: FontWeight.bold),
          ),
          verticalSpacing(20),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            height: 1,
          ),
          GestureDetector(
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "From photo",
                      style: GoogleFonts.lato(color: darkCommonColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: darkCommonColor,
                      size: 15,
                    )
                  ],
                )),
            onTap: () async {
              final XFile? galleryPhoto = await picker.pickImage(source: ImageSource.gallery);
              if (galleryPhoto == null) {
                return;
              }
              onImageSelected(galleryPhoto);
            },
          ),
          Divider(
            color: Colors.grey.withOpacity(0.5),
            height: 1,
          ),
          verticalSpacing(20),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return CardColorPickerItem(
                hexColor: colors[index],
                onSelected: (color) {
                  debugPrint("Selected color: $color");
                  onColorSelected(color);
                },
              );
            },
            itemCount: colors.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}

class CardColorPickerItem extends StatelessWidget {
  final String hexColor;
  final Function(String) onSelected;

  const CardColorPickerItem({super.key, required this.hexColor, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: HexColor(hexColor),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onTap: () {
        onSelected(hexColor);
      },
    );
  }
}
