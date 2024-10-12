import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quoter/models/diary.dart';
import 'package:quoter/models/diary_card.dart';
import 'package:quoter/repositories/entities/quote_editor_entity.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseManager {
  Future<Database> getDatabase() async {
    return await openDatabase("quote_db.db", version: 2, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Quote (id INTEGER PRIMARY KEY, content TEXT, backgroundPatternPosition INTEGER, backgroundImagePosition INTEGER, backgroundColor TEXT, textSize REAL, "
          "textColor TEXT, font TEXT)");
      await db.execute("CREATE TABLE Diary (id INTEGER PRIMARY KEY AUTOINCREMENT, day INTEGER, month INTEGER, year INTEGER, content TEXT, title TEXT, images TEXT)");
      await db.execute("CREATE TABLE DiaryCard (id INTEGER PRIMARY KEY, month INTEGER, year INTEGER, image TEXT)");
    });
  }

  Future saveQuote(QuoteEditorEntity quoteEditorEntity) async {
    Database database = await getDatabase();
    await database.transaction((txn) async {
      String query =
          "INSERT INTO Quote(id, content, backgroundPatternPosition, backgroundImagePosition, backgroundColor, textSize, textColor, font) VALUES (${quoteEditorEntity.id}, "
          "\"${quoteEditorEntity.content}\", ${quoteEditorEntity.backgroundPatternPosition}, ${quoteEditorEntity.backgroundImagePosition}, \"${quoteEditorEntity.backgroundColor}\", "
          "${quoteEditorEntity.textSize}, "
          "\"${quoteEditorEntity.textColor}\", \"${quoteEditorEntity.font}\")";
      //await txn.rawInsert(query);
      await txn.insert("Quote", quoteEditorEntity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<List<QuoteEditorEntity>> getQuotes() async {
    Database database = await getDatabase();
    List<Map> rawResult = await database.rawQuery("select * from Quote");
    List<QuoteEditorEntity> result = List.of([], growable: true);
    rawResult.forEach((element) {
      result.add(QuoteEditorEntity(
          id: int.parse("${element["id"]}"),
          content: element["content"],
          backgroundPatternPosition: int.parse("${element["backgroundPatternPosition"]}"),
          backgroundColor: element["backgroundColor"],
          backgroundImagePosition: int.parse("${element["backgroundImagePosition"]}"),
          textSize: double.parse("${element["textSize"]}"),
          textColor: element["textColor"],
          font: element["font"]));
    });
    return result;
  }

  Future<List<DiaryCard>> getDiaryCards(int year) async {
    debugPrint("Get Diary Cards: $year");
    List<DiaryCard> cards = List<int>.generate(12, (index) => 1 + index).map((e) => DiaryCard(diary_count: 0, month: e, year: year, image: "")).toList();
    Database database = await getDatabase();
    int index = 0;
    for (DiaryCard card in cards) {
      String query = "SELECT * FROM DiaryCard WHERE month = ${card.month} AND year = ${card.year}";
      List<Map> rawResult = await database.rawQuery(query);
      int diaryCount = await getNumberOfDaysHasDiary(card.month, card.year);
      print("diaryCount of ${card.month}/${card.year}: $diaryCount");
      card = card.copyWith(diary_count: diaryCount);
      cards[index] = card;
      if (rawResult.isNotEmpty) {
        card = card.copyWith(month: rawResult[0]["month"], year: rawResult[0]["year"], image: rawResult[0]["image"]);
      }
      index ++ ;
    }
    print(cards);
    return cards;
  }

  Future saveDiary(Diary diary) async {
    Database database = await getDatabase();
    Batch batch = database.batch();
    if (diary.id == 0) {
      batch.execute(
          "INSERT INTO Diary(day, month, year, content, title, images) VALUES (${diary.day}, ${diary.month}, ${diary.year}, \"${diary.content}\", \"${diary.title}\", \"${diary.images}\")");
    } else {
      batch.execute(
          "UPDATE Diary SET day = ${diary.day}, month = ${diary.month}, year = ${diary.year}, content = \"${diary.content}\", title = \"${diary.title}\", images = \"${diary.images}\" WHERE id = ${diary.id}");
    }
    batch.commit(noResult: false);
  }

  Future<List<Diary>> getDiaries(int month, int year) async {
    Database database = await getDatabase();
    String query = "SELECT * FROM Diary WHERE month = $month AND year = $year";
    List<Map> rawResult = await database.rawQuery(query);
    //List<Map> rawResult = await database.rawQuery("SELECT * FROM Diary");
    List<Diary> result = List.of([], growable: true);
    rawResult.forEach((element) {
      result.add(Diary(
          id: element["id"], day: element["day"], month: element["month"], year: element["year"], content: element["content"], title: element["title"], images: element["images"]));
    });
    return result;
  }

  Future<int> getNumberOfDaysHasDiary(int month, int year) async {
    debugPrint("Get Number of Diary: $month / $year");
    Database database = await getDatabase();
    String query = "SELECT day FROM Diary WHERE month = $month AND year = $year GROUP BY day";
    List<Map> rawResult = await database.rawQuery(query);
    debugPrint("RawResult: $rawResult");
    return rawResult.length;
  }
}
