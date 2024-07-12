
import 'package:flutter/services.dart';

class MethodChannelHandler {
  MethodChannelHandler._internal();

  static MethodChannelHandler instance = MethodChannelHandler._internal();

  static const channel = "com.quoter";
  static const shareFile = "shareFile";
  static const showPrivacy = "showPrivacy";
  static const removeAdsForever = "removeAdsForever";
  static const removeAds1Month = "removeAds1Month";
  static const removeAds2Months = "removeAds2Months";
  static const removeAds6Months = "removeAds6Months";
  static const getPurchasedProduct = "getPurchasedProduct";
  static const restoreProduct = "restoreProduct";

  final MethodChannel _platform = const MethodChannel(channel);

  Future<dynamic> invokeMethod(String method, {Object? data}) async {
    return await _platform.invokeMethod(method, data);
  }
}