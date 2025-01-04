package com.klmobile.iap


interface BillingEventListener {
    fun onListenPurchasesUpdated(isSuccess: Boolean)
}