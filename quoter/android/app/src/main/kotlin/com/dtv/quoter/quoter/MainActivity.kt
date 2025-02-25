package com.dtv.quoter.quoter

import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.util.Log
import androidx.core.content.FileProvider
import androidx.lifecycle.lifecycleScope
import com.klmobile.iap.BillingEventListener
import com.klmobile.iap.BillingRepository
import com.klmobile.iap.BillingRepositoryImpl
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {

    companion object {
        private const val CHANNEL = "com.quoter"
        private const val shareFile = "shareFile";
        private const val openUrl = "openUrl";
        private const val removeAdsForever = "remove_ads_forever";
        private const val removeAds1Month = "remove_ads_1_month";
        private const val removeAds2Months = "remove_ads_2_month";
        private const val removeAds6Months = "remove_ads_6_month";
        private const val removeAds1Week = "remove_ads_1_week";
        private const val removeAds2Weeks = "remove_ads_2_week";
        private const val removeAds3Weeks = "remove_ads_3_week";
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

    private fun openUrl(url: String) {
        val urlIntent = Intent(
            Intent.ACTION_VIEW,
            Uri.parse( url)
        )
        urlIntent.`package` = "com.android.chrome"
        startActivity(urlIntent)
    }

    private fun shareFile(filePath: String) {

        // Load the Bitmap from the file
        val bitmap = BitmapFactory.decodeFile(filePath)

        // Save the Bitmap to a temporary file
        val tempFile = File(context.cacheDir, "shared_image.png")
        FileOutputStream(tempFile).use { out ->
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, out)
        }

        // Get the URI for the temporary file
        val uri: Uri = FileProvider.getUriForFile(
            context,
            "${context.packageName}.provider",
            tempFile
        )

        // Create and launch the share intent
        val shareIntent: Intent = Intent().apply {
            action = Intent.ACTION_SEND
            putExtra(Intent.EXTRA_STREAM, uri)
            type = "image/png"
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }

        context.startActivity(Intent.createChooser(shareIntent, "Share Image"))
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
                removeAds1Week,
                removeAds2Weeks,
                removeAds3Weeks,
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
                    val url = call.arguments as String
                    openUrl(url)
                }

                shareFile -> {
                    val filePath = call.arguments  as String
                    shareFile(filePath)

                }
            }
        }
    }
}
