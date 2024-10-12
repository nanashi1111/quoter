import 'package:quoter/models/diary.dart';
import 'package:quoter/utils/constants.dart';

extension DiaryExt on Diary {
  bool hasImage() {
    return images.isNotEmpty;
  }

  String firstImage() {
    if (!hasImage()) {
      return "";
    }
    return images.split(IMAGE_SEPERATOR).first;
  }
}
