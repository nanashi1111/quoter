
import 'package:shared_preferences/shared_preferences.dart';

class AdsRepository {

  AdsRepository._internal();

  static final AdsRepository instance = AdsRepository._internal();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final String _keyAdsEnabled = "ads_enable";
  final String _lastTimeShowAds = "last_time_show_ads";
  final String _purchaseRestored = "purchase_restored";

  Future<bool> isAdsEnabled() async {
    return (await _prefs).getBool(_keyAdsEnabled) ?? true;
  }

  Future setAdsEnabled(bool enabled) async {
    (await _prefs).setBool(_keyAdsEnabled, enabled);
  }

  Future<int> getLastTimeShowAds() async {
    return (await _prefs).getInt(_lastTimeShowAds) ?? 0;
  }

  Future setLastTimeShowAds() async {
    (await _prefs).setInt(_lastTimeShowAds, DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> isPurchaseRestored() async {
    return (await _prefs).getBool(_purchaseRestored) ?? false;
  }

  Future setPurchaseRestored(bool restored) async {
    (await _prefs).setBool(_purchaseRestored, restored);
  }
}