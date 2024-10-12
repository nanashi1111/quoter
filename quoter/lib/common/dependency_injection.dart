import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quoter/repositories/ads_repository.dart';
import 'package:quoter/repositories/cached/database_manager.dart';
import 'package:quoter/repositories/diary_repository.dart';
import 'package:quoter/repositories/quote_repository.dart';
import 'package:quoter/utils/admob_helper.dart';

final getIt = GetIt.instance;

Future configInstances() async {
  getIt.registerSingleton(Dio(BaseOptions(baseUrl: "https://api.quotable.io")));
  getIt.registerSingleton(DataBaseManager());
  getIt.registerSingleton(QuoteRepository());
  getIt.registerSingleton(DiaryRepository());
}
