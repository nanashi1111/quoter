
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quoter/repositories/quote_repository.dart';

final getIt = GetIt.instance;

Future configInstances() async {
  getIt.registerSingleton(Dio(
      BaseOptions(baseUrl: "https://api.quotable.io")
  ));

  getIt.registerSingleton(QuoteRepository());
}