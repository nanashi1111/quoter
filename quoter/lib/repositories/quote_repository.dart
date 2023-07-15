
import 'package:dio/dio.dart';
import 'package:quoter/repositories/apis.dart';
import 'package:quoter/repositories/base_repository.dart';
import 'package:quoter/repositories/entities/category.dart';
import 'package:quoter/repositories/entities/quote.dart';

class QuoteRepository extends BaseRepository {
  Future<List<QuoteCategoryEntity>> getCatgories() async {
    Response<String> response = await dio.get(ApiPaths.PATH_QUOTES_CATEGORIES);
    if (response.statusCode == 200 && response.data != null) {
      return quoteCategoryEntityFromJson(response.data!);
    } else {
      return List.empty();
    }
  }

  Future<List<QuoteEntity>> getQuotes(String categorySlug) async {
    Response<String> response = await dio.get(ApiPaths.PATH_QUOTES,
        queryParameters: Map<String, String>()..addEntries(List.of([MapEntry("limit", "50"), MapEntry("tags", categorySlug)])));
    if (response.statusCode == 200 && response.data != null) {
      return quoteEntityFromJson(response.data!);
    } else {
      return List.empty();
    }
  }
}