package com.klmobile.iap

import android.app.Activity
import android.content.Context
import android.util.Log
import com.android.billingclient.api.AcknowledgePurchaseParams
import com.android.billingclient.api.BillingClient
import com.android.billingclient.api.BillingClient.BillingResponseCode
import com.android.billingclient.api.BillingClientStateListener
import com.android.billingclient.api.BillingFlowParams
import com.android.billingclient.api.BillingResult
import com.android.billingclient.api.ConsumeParams
import com.android.billingclient.api.ProductDetails
import com.android.billingclient.api.Purchase
import com.android.billingclient.api.PurchasesUpdatedListener
import com.android.billingclient.api.QueryProductDetailsParams
import com.android.billingclient.api.QueryPurchaseHistoryParams
import com.android.billingclient.api.QueryPurchasesParams
import com.android.billingclient.api.queryProductDetails
import com.android.billingclient.api.queryPurchaseHistory
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject

class BillingRepositoryImpl(
    private val coroutineScope: CoroutineScope,
) : BillingRepository {
    private val _products = MutableStateFlow<List<ProductDetailModel>>(emptyList())
    override val product: StateFlow<List<ProductDetailModel>> = _products
    private val mapProductId: MutableMap<BillingType, List<String>> = mutableMapOf(
        BillingType.CONSUMABLE to listOf(),
        BillingType.NONE_CONSUMABLE to listOf(),
        BillingType.SUBSCRIPTION to listOf(),
    )
    private var billingClient: BillingClient? = null
    private val listProductDetails = mutableListOf<ProductDetails>()
    private var billingEventListener: BillingEventListener? = null
    private val TAG = "HHHH"

    companion object {
        @Volatile
        private var Instance: BillingRepository? = null
        fun getInstance(scope: CoroutineScope): BillingRepository {
            return Instance ?: synchronized(this) {
                Instance ?: BillingRepositoryImpl(scope).also {
                    Instance = it
                }
            }
        }

    }

    override fun setProductIds(
        listConsumableId: List<String>,
        listNoneConsumableId: List<String>,
        listSubscriptionId: List<String>,
    ): BillingRepository {
        this.mapProductId[BillingType.CONSUMABLE] = listConsumableId
        this.mapProductId[BillingType.NONE_CONSUMABLE] = listNoneConsumableId
        this.mapProductId[BillingType.SUBSCRIPTION] = listSubscriptionId
        return this
    }


    override fun createBillingClient(context: Context) {
        val purchasesUpdatedListener =
            PurchasesUpdatedListener { billingResult, purchases ->
                Log.i(TAG, "createBillingClient:  createBillingClient ready")
                billingEventListener?.onListenPurchasesUpdated(billingResult.responseCode == BillingResponseCode.OK
                        || billingResult.responseCode == BillingResponseCode.ITEM_ALREADY_OWNED)
                handelResponse(billingResult) {
                    coroutineScope.launch {
                        if (purchases?.isNotEmpty() == true) {
                            purchases.forEach { purchase ->
                                processPurchase(purchase)
                            }
                        } else {
                            Log.i(
                                TAG,
                                "createBillingClient: no such product ${billingResult.responseCode}  ${billingResult.debugMessage}"
                            )
                        }
                    }
                }
            }

        billingClient = BillingClient.newBuilder(context)
            .setListener(purchasesUpdatedListener)
            .enablePendingPurchases()
            .build()
    }

    override fun connectToGooglePlay() {
        billingClient?.startConnection(object : BillingClientStateListener {
            override fun onBillingSetupFinished(billingResult: BillingResult) {
                if (billingResult.responseCode == BillingResponseCode.OK) {
                    Log.i(TAG, "connectToGooglePlay:  connectToGooglePlay ready")
                    coroutineScope.launch {
                        queryProducts()
                        queryPurchases()
                    }
                } else {
                    billingResult.responseCode.logErrorType()
                }
            }

            override fun onBillingServiceDisconnected() {
                connectToGooglePlay()
            }
        })
    }

    override fun queryPurchases() {
        queryPurchases(BillingClient.ProductType.SUBS)
        queryPurchases(BillingClient.ProductType.INAPP)
    }

    override fun queryPurchases(typeIap: String) {
        if (billingClient?.isReady == false) {
            Log.i(TAG, "queryPurchases: Billing client not ready ")
            return;
        }
        val queryPurchasesParams = QueryPurchasesParams.newBuilder()
            .setProductType(typeIap)
            .build()
        billingClient?.queryPurchasesAsync(queryPurchasesParams) { billingResult, productDetailList ->
            handelResponse(billingResult) {
                coroutineScope.launch {
                    if (productDetailList.isNotEmpty()) {
                        productDetailList.forEach { purchase ->
                            processPurchase(purchase)
                        }
                    } else {
                        Log.i(
                            TAG,
                            "billingClient: no such product ${billingResult.responseCode}  ${billingResult.debugMessage}"
                        )
                    }
                }

            }
        }
    }

    override suspend fun queryProducts() = withContext(Dispatchers.IO) {
        mapProductId.forEach { (type, listId) ->
            when (type) {
                BillingType.CONSUMABLE,
                BillingType.NONE_CONSUMABLE -> queryProducts(
                    BillingClient.ProductType.INAPP,
                    listId
                )

                BillingType.SUBSCRIPTION -> queryProducts(BillingClient.ProductType.SUBS, listId)
            }
        }
    }

    private suspend fun queryProducts(productType: String, productIds: List<String>) {
        productIds.forEach { productId ->
            queryProducts(productType, productId)
        }
    }

    override suspend fun queryProducts(productType: String, productId: String) {
        val queryProductDetailsParams = QueryProductDetailsParams.newBuilder()
            .setProductList(
                listOf(
                    QueryProductDetailsParams.Product.newBuilder()
                        .setProductId(productId)
                        .setProductType(productType)
                        .build()
                )
            )
            .build()
        val productDetailsResult = billingClient?.queryProductDetails(queryProductDetailsParams)
        handelResponse(productDetailsResult?.billingResult) {
            if (productDetailsResult?.productDetailsList?.isNotEmpty() == true) {
                productDetailsResult.productDetailsList?.let { productDetails ->
                    listProductDetails.addAll(productDetails)
                    _products.value = listProductDetails.map { productDetail ->
                        ProductDetailModel(
                            id = productDetail.productId,
                            name = productDetail.name,
                            type = productDetail.productType,
                            description = productDetail.description
                        )
                    }
                }
                Log.i(
                    TAG,
                    "queryProducts:  product ${product.value} ${productDetailsResult.productDetailsList}"
                )
            } else {
                Log.i(
                    TAG,
                    "queryProducts: no such product ${productDetailsResult?.productDetailsList?.size}  ${listProductDetails}"
                )
            }
        }
    }

    override fun launchBillingFlow(
        activity: Activity,
        productId: String,
        billingEventListener: BillingEventListener?
    ) {
        this.billingEventListener = billingEventListener
        val productDetails = listProductDetails.find { it.productId == productId }
        val productDetailsParams = productDetails?.let {
            val builder = BillingFlowParams.ProductDetailsParams.newBuilder().setProductDetails(it)
            if (mapProductId[BillingType.SUBSCRIPTION]?.contains(it.productId) == true) {
                builder.setOfferToken(it.subscriptionOfferDetails?.firstOrNull()?.offerToken.orEmpty())
            }
            builder.build()
        }
        val billingFlowParams = BillingFlowParams.newBuilder()
            .setProductDetailsParamsList(listOfNotNull(productDetailsParams))
            .build()

        if (billingClient?.isReady == false) {
            Log.i(TAG, "launchBillingFlow:  Billing client not ready")
        }
        val billingResult = billingClient?.launchBillingFlow(activity, billingFlowParams)
        handelResponse(billingResult) {
            Log.i(TAG, "launchBillingFlow: sfdkdsfjdsk")
        }
    }

    override fun queryUserHistory() {
        coroutineScope.launch {
            queryUserHistory(BillingClient.ProductType.SUBS)
            queryUserHistory(BillingClient.ProductType.INAPP)
        }
    }

    override suspend fun queryUserHistory(typeIap: String) {
        val params = QueryPurchaseHistoryParams.newBuilder()
            .setProductType(typeIap)
            .build()
        val purchaseHistoryResult = billingClient?.queryPurchaseHistory(params)
        when (val responseCode = purchaseHistoryResult?.billingResult?.responseCode) {
            BillingResponseCode.OK -> {
                val historyResult = purchaseHistoryResult.purchaseHistoryRecordList

                historyResult?.forEach { history ->
                    Log.i(TAG, "queryUserHistory: ${history.purchaseToken} ${history.originalJson}")
                    history.products.forEach { product ->
                        Log.i(TAG, "queryUserHistory: $product")
                    }
                }
            }

            else -> {
                responseCode?.logErrorType()
            }
        }
    }

    override fun onDisconnectBilling() {
        if (billingClient?.isReady == true) {
            billingClient?.endConnection()
            coroutineScope.cancel()
        }
    }

    private fun handelResponse(billingResult: BillingResult?, onHandel: (() -> Unit)? = null) {
        when (val responseCode = billingResult?.responseCode) {
            BillingResponseCode.OK -> {
                onHandel?.invoke()
                responseCode.logErrorType()
            }

            else -> {
                responseCode?.logErrorType()
            }
        }
    }

    private suspend fun processPurchase(purchase: Purchase) {
        val productId = JSONObject(purchase.originalJson).getString("productId")
        if (mapProductId[BillingType.CONSUMABLE]?.contains(productId) == true) {
            handelPurchase(purchase)
        } else {
            acknowledgePurchase(purchase)
        }
    }

    //consumable Product
    private fun handelPurchase(purchase: Purchase) {
        if (purchase.purchaseState == Purchase.PurchaseState.PURCHASED) {
            if (!purchase.isAcknowledged) {
                val consumeParams = ConsumeParams.newBuilder()
                    .setPurchaseToken(purchase.purchaseToken)
                    .build()
                billingClient?.consumeAsync(consumeParams) { billingResult, _ ->
                    handelResponse(billingResult)
                }
            }
        }
    }

    //Non consumable Product & subscription
    private suspend fun acknowledgePurchase(purchase: Purchase) = withContext(Dispatchers.IO) {
        if (purchase.purchaseState == Purchase.PurchaseState.PURCHASED) {
            if (!purchase.isAcknowledged) {
                val acknowledgePurchaseParams = AcknowledgePurchaseParams.newBuilder()
                    .setPurchaseToken(purchase.purchaseToken)
                    .build()
                billingClient?.acknowledgePurchase(acknowledgePurchaseParams) { billingResult ->
                    handelResponse(billingResult)
                }
            } else {
//            save purchase to backend
            }
        }
    }


}