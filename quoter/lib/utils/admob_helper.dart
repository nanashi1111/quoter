import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/repositories/ads_repository.dart';

class AdmobHelper {
  AdmobHelper._internal();

  static final AdmobHelper instance = AdmobHelper._internal();
  final _adsRepository = AdsRepository.instance;

  final int minTimeBetweenAds = 5000;

  InterstitialAd? _interstitialAd;

  /*String _getOpenAdsId() {
    if (Platform.isIOS) {
      return "ca-app-pub-9211831291242531/7256547911";
    } else {
      return "";
    }
  }*/

  String _getInterAdsId() {
    if (Platform.isIOS) {
      if (kDebugMode) {
        return "ca-app-pub-3940256099942544/1033173712";
      } else {
        return "ca-app-pub-9211831291242531/9241930469";
      }
    } else {
      return "";
    }
  }

  initSdk() {
    MobileAds.instance.initialize();
    _loadInterAds();
  }

  Future<bool> _ableToShowAds() async {
    bool adsEnabled = await _adsRepository.isAdsEnabled();
    if (!adsEnabled) {
      return false;
    }
    int lastTimeShowAds = await _adsRepository.getLastTimeShowAds();
    if (DateTime.now().millisecondsSinceEpoch - lastTimeShowAds < minTimeBetweenAds) {
      return false;
    }
    return true;
  }

  _loadInterAds() {
    InterstitialAd.load(
        adUnitId: _getInterAdsId(),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _interstitialAd = ad;
        }, onAdFailedToLoad: (err) {
          _interstitialAd = null;
        }));
  }

  showInterAds(Function onCompletion) {
    if (_interstitialAd == null) {
      onCompletion();
      return;
    }
    _ableToShowAds().then((able) {
      if (able) {
        _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
          _interstitialAd = null;
          _adsRepository.setLastTimeShowAds();
          onCompletion();
          _loadInterAds();
        });
        _interstitialAd?.show();
      } else {
        onCompletion();
      }
    });
  }
}
