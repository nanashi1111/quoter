package com.dtv.quoter.quoter

import android.content.Intent
import android.util.Log
import androidx.lifecycle.lifecycleScope
import com.klmobile.iap.BillingEventListener
import com.klmobile.iap.BillingRepository
import com.klmobile.iap.BillingRepositoryImpl
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL = "com.quoter"
        private const val shareFile = "shareFile";
        private const val openUrl = "openUrl";
        private const val removeAdsForever = "remove_ads_forever";
        private const val removeAds1Month = "remove_ads_1_month";
        private const val removeAds2Months = "remove_ads_2_month";
        private const val removeAds6Months = "remove_ads_6_month";
        private const val restoreProduct = "restoreProduct";
        private const val RC_SELECT_BLUETOOTH = 100
    }

    private val billingRepository: BillingRepository by lazy {
        BillingRepositoryImpl.getInstance(lifecycleScope)
            .setProductIds(
                listSubscriptionId = listOf(removeAds1Month, removeAds2Months, removeAds6Months),
                listNoneConsumableId = listOf(removeAdsForever)
            )
    }

    override fun onStart() {
        super.onStart()
        billingRepository.createBillingClient(context)
        billingRepository.connectToGooglePlay()
    }

    override fun onDestroy() {
        billingRepository.onDisconnectBilling()
        super.onDestroy()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                removeAds1Month,
                removeAds2Months,
                removeAds6Months,
                removeAdsForever -> {
                    Log.d("MainActivity", "${call.method} ")
                    billingRepository.launchBillingFlow(
                        this@MainActivity,
                        call.method,
                        object : BillingEventListener {
                            override fun onListenPurchasesUpdated(isSuccess: Boolean) {
                                Log.d("MainActivity", "${call.method} => $isSuccess")
                                result.success(isSuccess)
                            }

                        })
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
