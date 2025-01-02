package com.dtv.quoter.quoter

import android.content.Intent
import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

  companion object {
    private const val CHANNEL = "com.quoter"
    private const val shareFile = "shareFile";
    private const val openUrl = "openUrl";
    private const val removeAdsForever = "removeAdsForever";
    private const val removeAds1Month = "removeAds1Month";
    private const val removeAds2Months = "removeAds2Months";
    private const val removeAds6Months = "removeAds6Months";
    private const val restoreProduct = "restoreProduct";
    private const val RC_SELECT_BLUETOOTH = 100
  }

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
      when (call.method) {
        removeAdsForever -> {
          Log.d("MainActivity", "removeAdsForever")
          disdjoaisjdaoisjdaiosd

          result.success(true)
        }
        removeAds1Month -> {
          Log.d("MainActivity", "removeAds1Month")
        }
        removeAds2Months -> {
          Log.d("MainActivity", "removeAds2Months")
        }
        removeAds6Months -> {
          Log.d("MainActivity", "removeAds6Months")
        }
        openUrl -> {
          Log.d("MainActivity", "openUrl")
        }
        shareFile -> {
          Log.d("MainActivity", "shareFile")
        }
      }
    }
  }
}
