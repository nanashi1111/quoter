
import 'package:flutter/services.dart';

class MethodChannelHandler {
  MethodChannelHandler._internal();

  static MethodChannelHandler instance = MethodChannelHandler._internal();

  static const channel = "com.quoter";
  static const shareFile = "shareFile";
  static const openUrl = "openUrl";
  static const removeAdsForever = "remove_ads_forever";
  static const removeAds1Month = "remove_ads_1_month";
  static const removeAds2Months = "remove_ads_2_month";
  static const removeAds6Months = "remove_ads_6_month";
  static const restoreProduct = "restoreProduct";

  final MethodChannel _platform = const MethodChannel(channel);

  Future<dynamic> invokeMethod(String method, {Object? data}) async {
    return await _platform.invokeMethod(method, data);
  }
}