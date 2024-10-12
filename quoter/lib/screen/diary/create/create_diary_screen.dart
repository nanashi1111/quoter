import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quoter/common/colors.dart';
import 'package:quoter/common/views.dart';
import 'package:quoter/models/diary.dart';
import 'package:quoter/screen/diary/create/bloc/create_diary_bloc.dart';
import 'package:quoter/screen/diary/create/components/diary_content.dart';
import 'package:quoter/screen/diary/create/components/diary_date.dart';
import 'package:quoter/screen/diary/create/components/diary_photo_content.dart';
import 'package:quoter/screen/diary/create/components/diary_photo_picker.dart';
import 'package:quoter/utils/constants.dart';

class CreateDiaryScreen extends StatelessWidget {
  final ImagePicker picker = ImagePicker();
  final Diary? diary;

  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final  CarouselSliderController _carouselController = CarouselSliderController();


  CreateDiaryScreen({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateDiaryBloc>(
      create: (_) => CreateDiaryBloc()..add(CreateDiaryEvent.started(diary: diary)),
      child: BlocConsumer<CreateDiaryBloc, CreateDiaryState>(
        listener: (context, state) async {
          debugPrint("Jump to page: ${state.currentPos}");
          _carouselController.jumpToPage(state.currentPos);
        },
        listenWhen: (previous, current) {
          print("build_CreateDiaryBloc: ${previous.cacheDiary.images != current.cacheDiary.images}");
          return previous.cacheDiary.images != current.cacheDiary.images;
        },
        buildWhen: (previous, current) {
          print("build_CreateDiaryBloc: ${previous.cacheDiary.images != current.cacheDiary.images}");
          return previous.cacheDiary.images != current.cacheDiary.images;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  child: Text(
                    "Save",
                    style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                )
              ],
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
              title: Text(
                'Write diary',
                style: GoogleFonts.lato(color: Colors.white, fontSize: 14),
              ),
              centerTitle: Platform.isIOS,
              backgroundColor: darkCommonColor,
            ),
            backgroundColor: darkCommonColor,
            body: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Stack(
                    children: [
                      DiaryPhotoContent(
                          initPos: state.currentPos,
                          controller: _carouselController,
                          onPageChanged: (currentPos) {
                            debugPrint("OnPageChanged: $currentPos");
                            context.read<CreateDiaryBloc>().add(CreateDiaryEvent.onPageChanged(pos: currentPos));
                          },
                          images: state.cacheDiary.images.split(IMAGE_SEPERATOR)),
                      DiaryPhotoPicker(
                        images: state.cacheDiary.images.split(IMAGE_SEPERATOR),
                        onAddPhotoClicked: () async {
                          final XFile? galleryPhoto = await picker.pickImage(source: ImageSource.gallery);
                          if (galleryPhoto == null) {
                            return;
                          }

                          context.read<CreateDiaryBloc>().add(CreateDiaryEvent.addImages(images: [galleryPhoto], pos: state.currentPos));
                        },
                        onRemovePhotoClicked: () {
                          context.read<CreateDiaryBloc>().add(CreateDiaryEvent.removeImage(pos: context.read<CreateDiaryBloc>().state.currentPos));
                        },
                      ),
                    ],
                  ),
                  verticalSpacing(10),
                  DiaryDate(dateTime: DateTime(state.cacheDiary.year, state.cacheDiary.month, state.cacheDiary.day)),
                  Expanded(child: DiaryContent(contentController: _contentController, titleController: _titleController))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
