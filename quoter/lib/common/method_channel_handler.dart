
import 'package:flutter/services.dart';

class MethodChannelHandler {
  MethodChannelHandler._internal();

  static MethodChannelHandler instance = MethodChannelHandler._internal();

  static const channel = "com.quoter";
  static const shareFile = "shareFile";
  static const showPrivacy = "showPrivacy";


  final MethodChannel _platform = const MethodChannel(channel);

  Future<dynamic> invokeMethod(String method, {Object? data}) async {
    return await _platform.invokeMethod(method, data);
  }
}