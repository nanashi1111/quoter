import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:quoter/screen/diary/create/components/diary_photo_picker.dart';
import 'package:quoter/utils/constants.dart';

class DiaryPhotoContent extends StatelessWidget {
  final int initPos;
  final List<String> images;
  final Function(int) onPageChanged;
  final CarouselSliderController controller;

  const DiaryPhotoContent({super.key, required this.images, required this.onPageChanged, required this.initPos, required this.controller, });

  @override
  Widget build(BuildContext context) {

    debugPrint("DiaryPhotoContent Pos: ${initPos}");

    double width = MediaQuery.of(context).size.width;
    double height = width * PHOTO_PICKER_RATIO;
    if (images.where((image) => image.isNotEmpty).isEmpty) {
      return SizedBox(
        width: width,
        height: height,
      );
    }

    CarouselSlider view = CarouselSlider(
      carouselController: controller,
      options: CarouselOptions(
          height: height,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            onPageChanged(index);
          }),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width: width,
              height: height,
              child: Image.memory(base64Decode(image), fit: BoxFit.cover, width: width, height: height),
              //child: Image.network(image, fit: BoxFit.cover, width: width, height: height)
            );
          },
        );
      }).toList(),
    );
    return view;
  }
}
