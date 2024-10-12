
import 'package:flutter/material.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/utils/constants.dart';



class DiaryPhotoPicker extends StatelessWidget {

  final List<String> images;
  final Function onAddPhotoClicked;
  final Function onRemovePhotoClicked;

  const DiaryPhotoPicker({super.key, required this.onAddPhotoClicked, required this.images, required this.onRemovePhotoClicked});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    if (images.where((image) => image.isNotEmpty).isEmpty) {
      return Container(
        alignment: Alignment.center,
        width: size, height: size * PHOTO_PICKER_RATIO,
        color: Colors.white.withOpacity(0.5),
        child: GestureDetector(
          child: Container(
            width: 80, height: 80,
            color: Colors.black.withOpacity(0.2),
            alignment: Alignment.center,
            child: Icon(Icons.add, color: Colors.white, size: 40),
          ),
          onTap: () { onAddPhotoClicked(); },
        ),
      );

    }
    else {
      return Container(
        alignment: Alignment.center,
        width: size, height: size * PHOTO_PICKER_RATIO,
        child: Wrap(
          children: [
            GestureDetector(
              child: Container(
                width: 80, height: 80,
                color: Colors.black.withOpacity(0.2),
                alignment: Alignment.center,
                child: Icon(Icons.remove, color: Colors.white, size: 40),
              ),
              onTap: () { onRemovePhotoClicked(); },
            ),
            horizontalSpacing(20),
            GestureDetector(
              child: Container(
                width: 80, height: 80,
                color: Colors.black.withOpacity(0.2),
                alignment: Alignment.center,
                child: Icon(Icons.add, color: Colors.white, size: 40),
              ),
              onTap: () { onAddPhotoClicked(); },
            )
          ],
        ),
      );
    }
  }

}