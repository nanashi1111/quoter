
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
  static const removeAds1Week = "remove_ads_1_week";
  static const removeAds2Weeks = "remove_ads_2_week";
  static const removeAds3Weeks = "remove_ads_3_week";
  static const restoreProduct = "restoreProduct";

  static const removeAdsType1Week = 11;
  static const removeAdsType2Weeks = 12;
  static const removeAdsType3Weeks = 13;
  static const removeAdsType1Month = 1;
  static const removeAdsType2Months = 2;
  static const removeAdsType6Months = 6;
  static const removeAdsTypeForever = 0;

  final MethodChannel _platform = const MethodChannel(channel);

  Future<dynamic> invokeMethod(String method, {Object? data}) async {
    return await _platform.invokeMethod(method, data);
  }
}