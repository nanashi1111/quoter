import 'package:quoter/models/diary.dart';
import 'package:quoter/models/diary_card.dart';
import 'package:quoter/repositories/base_repository.dart';
import 'package:quoter/repositories/cached/database_manager.dart';

class DiaryRepository extends BaseRepository {

  Future<List<DiaryCard>> getDiaryCards(int year) {
    return dataBaseManager.getDiaryCards(year);
  }

  Future<void> saveDiary(Diary diary) {
    return dataBaseManager.saveDiary(diary);
  }

  Future<List<Diary>> getDiaries(int month, int year) {
    return dataBaseManager.getDiaries(month, year);
  }
}