package com.klmobile.iap

import android.util.Log
import com.android.billingclient.api.BillingClient

fun Int.logErrorType() {
    when (this) {
        BillingClient.BillingResponseCode.DEVELOPER_ERROR, BillingClient.BillingResponseCode.BILLING_UNAVAILABLE -> Log.i(
            "HHHH",
            "Billing unavailable. Make sure your Google Play app is setup correctly"
        )

        BillingClient.BillingResponseCode.SERVICE_DISCONNECTED -> {
            Log.i(
                "HHHH",
                "Server disconnect"
            )
        }

        BillingClient.BillingResponseCode.OK -> Log.i("HHHHH", "Setup successful!")
        BillingClient.BillingResponseCode.USER_CANCELED -> Log.i(
            "HHHHH",
            "User has cancelled Purchase!"
        )

        BillingClient.BillingResponseCode.SERVICE_UNAVAILABLE -> Log.i("HHHHH", "No connect internet")
        BillingClient.BillingResponseCode.ITEM_UNAVAILABLE -> Log.i(
            "HHHHH",
            "Product is not available for purchase"
        )

        BillingClient.BillingResponseCode.ERROR -> Log.i("HHHHH", "fatal error during API action")
        BillingClient.BillingResponseCode.ITEM_ALREADY_OWNED -> Log.i(
            "HHHHH",
            "Failure to purchase since item is already owned"
        )

        BillingClient.BillingResponseCode.ITEM_NOT_OWNED -> Log.i(
            "HHHHH",
            "Failure to consume since item is not owned"
        )

        BillingClient.BillingResponseCode.FEATURE_NOT_SUPPORTED -> Log.i(
            "HHHHH",
            "Billing feature is not supported on your device"
        )

        else -> Log.i("HHHHH", "Billing unavailable. Please check your device")
    }
}