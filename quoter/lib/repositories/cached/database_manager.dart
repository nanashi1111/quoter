import 'dart:ffi';

import 'package:quoter/repositories/entities/quote_editor_entity.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseManager {
  Future<Database> getDatabase() async {
    return await openDatabase("quote_db.db", version: 1, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Quote (id INTEGER PRIMARY KEY, content TEXT, backgroundPatternPosition INTEGER, backgroundColor TEXT, textSize REAL, textColor TEXT, font TEXT)");
    });
  }

  Future saveQuote(QuoteEditorEntity quoteEditorEntity) async {
    Database database = await getDatabase();
    await database.transaction((txn) async {
      String query = "INSERT INTO Quote(id, content, backgroundPatternPosition, backgroundColor, textSize, textColor, font) VALUES (${quoteEditorEntity.id}, "
          "\"${quoteEditorEntity.content}\", ${quoteEditorEntity.backgroundPatternPosition}, \"${quoteEditorEntity.backgroundColor}\", ${quoteEditorEntity.textSize}, \"${quoteEditorEntity.textColor}\", \"${quoteEditorEntity.font}\")";
      //await txn.rawInsert(query);
      await txn.insert("Quote", quoteEditorEntity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<List<QuoteEditorEntity>> getQuotes() async {
    Database database = await getDatabase();
    List<Map> rawResult = await database.rawQuery("select * from Quote");
    List<QuoteEditorEntity> result = List.of([], growable: true);
    rawResult.forEach((element) {
      result.add(QuoteEditorEntity(id: int.parse("${element["id"]}"), content: element["content"], backgroundPatternPosition: int.parse("${element["backgroundPatternPosition"]}"),
          backgroundColor: element["backgroundColor"],
          backgroundImagePosition: int.parse("${element["backgroundImagePosition"]}"),
          textSize: double.parse("${element["textSize"]}"), textColor: element["textColor"], font: element["font"]));
    });
    return result;
  }
}
