package com.klmobile.iap

import android.app.Activity
import android.content.Context
import kotlinx.coroutines.flow.StateFlow

interface BillingRepository {
    val product: StateFlow<List<ProductDetailModel>>
    fun setProductIds(
        listConsumableId: List<String> = emptyList(),
        listNoneConsumableId: List<String> = emptyList(),
        listSubscriptionId: List<String> = emptyList(),
    ): BillingRepository
    fun createBillingClient(context: Context)
    fun connectToGooglePlay()
    fun queryPurchases()
    fun queryPurchases(typeIap: String)
    suspend fun queryProducts()
    suspend fun queryProducts(productType: String, productId: String)
    fun launchBillingFlow(activity: Activity, productId: String, billingEventListener: BillingEventListener? = null)
    fun queryUserHistory()
    suspend fun queryUserHistory(typeIap: String)
    fun onDisconnectBilling()
}