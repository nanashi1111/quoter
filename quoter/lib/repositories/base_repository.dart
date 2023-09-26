
import 'package:dio/dio.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/repositories/cached/database_manager.dart';

class BaseRepository {
  Dio dio = getIt.get<Dio>();
  DataBaseManager dataBaseManager = getIt.get<DataBaseManager>();
}