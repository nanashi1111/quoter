import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/common/images.dart';
import 'package:quoter/models/diary.dart';
import 'package:quoter/repositories/diary_repository.dart';
import 'package:quoter/utils/constants.dart';

part 'create_diary_event.dart';
part 'create_diary_state.dart';
part 'create_diary_bloc.freezed.dart';

class CreateDiaryBloc extends Bloc<CreateDiaryEvent, CreateDiaryState> {

  final DiaryRepository diaryRepository = getIt.get();

  CreateDiaryBloc() : super(const CreateDiaryState.initial(currentPos: 0, savedDiary: false, cacheDiary: Diary(id: 0, day: 1, month: 1, year: 1, content: "", title: "",
      images: "_"))) {
    on<_Started>((event, emit) async {
      Diary? diary = event.diary;
      if (diary == null) {
        DateTime now = DateTime.now();
        emit(state.copyWith(
          cacheDiary: Diary(id: 0, day: now.day, month: now.month, year: now.year, content: "", title: "", images: ""),
        ));
      } else {
        emit(state.copyWith(
          cacheDiary: diary,
        ));
      }
    });

    on<_AddImages>((event, emit) async {
      debugPrint("Pos: ${event.pos} ; Picked: ${event.images.map((e) => e.path).toList()}");
      List<String> images = state.cacheDiary.images.split(IMAGE_SEPERATOR);
      for (XFile image in event.images) {
        String data = await ImageUtils.encodeImage(File(image.path));
        images.add(data);
        //images.insert(0, data);
      }
      emit(state.copyWith(
          currentPos: images.length - 1,
          cacheDiary: state.cacheDiary.copyWith(images: images.where((element) => element.isNotEmpty).join(IMAGE_SEPERATOR))));
    });

    on<_RemoveImage>((event, emit) async {
      List<String> images = state.cacheDiary.images.split(IMAGE_SEPERATOR);
      images.removeAt(event.pos);
      int posAfterRemoving = 0;
      if (event.pos >= images.length) {
        posAfterRemoving = images.length - 1;
      }
      else {
        posAfterRemoving = event.pos;
      }
      emit(state.copyWith(
          currentPos: posAfterRemoving,
          cacheDiary: state.cacheDiary.copyWith(images: images.where((element) => element.isNotEmpty).join(IMAGE_SEPERATOR))));
    });

    on<_OnPageChanged>((event, emit) async {
      emit(state.copyWith(currentPos: event.pos));
    });

    on<_Save>((event, emit) async {
      Diary cachedDiary = state.cacheDiary.copyWith(title: event.title, content: event.content);
      debugPrint("Save diary: $cachedDiary");
      await diaryRepository.saveDiary(cachedDiary);
      emit(state.copyWith(savedDiary: true));
    });
  }
}
