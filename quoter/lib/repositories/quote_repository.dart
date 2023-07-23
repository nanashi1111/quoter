
import 'package:dio/dio.dart';
import 'package:quoter/repositories/apis.dart';
import 'package:quoter/repositories/base_repository.dart';
import 'package:quoter/repositories/entities/category_entity.dart';
import 'package:quoter/repositories/entities/quote_entity.dart';
import 'dart:convert';

class QuoteRepository extends BaseRepository {
  Future<List<CategoryEntity>> getCatgories() async {
    Response<String> response = await dio.get(ApiPaths.PATH_QUOTES_CATEGORIES);
    if (response.statusCode == 200 && response.data != null) {
      return List<CategoryEntity>.from(json.decode(response.data!).map((x) => CategoryEntity.fromJson(x)));
    } else {
      return List.empty();
    }
  }

  Future<List<QuoteEntity>> getQuotes(String categorySlug) async {
    Response<String> response = await dio.get(ApiPaths.PATH_QUOTES,
        queryParameters: <String, String>{}..addEntries(List.of([const MapEntry("limit", "10"), MapEntry("tags", categorySlug)])));
    if (response.statusCode == 200 && response.data != null) {
      return List<QuoteEntity>.from(json.decode(response.data!).map((x) => QuoteEntity.fromJson(x)));
    } else {
      return List.empty();
    }
  }
}