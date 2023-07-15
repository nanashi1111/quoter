
import 'package:dio/dio.dart';
import 'package:quoter/common/dependency_injection.dart';

class BaseRepository {

  Dio dio = getIt.get<Dio>();
}