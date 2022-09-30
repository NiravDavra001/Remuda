//
//  IAPManager.swift
//  remuda
//
//  Created by Macmini on 29/06/21.
//

import Foundation
import StoreKit
import SwiftyStoreKit
protocol IAPPurchasedDelegate {
    func purchasedCallAPI()
}
///step1
enum ProductId:String, CaseIterable{
    case remuda_horse_basic                     =   "com.app.remuda_horse_basic"
    case remuda_horse_premium                   =   "com.app.remuda_horse_premium"
    case remuda_tack_basic                      =   "com.app.remuda_tack_basic"
    case remuda_tack_premium                    =   "com.app.remuda_tack_premium"
    case remuda_equipment_basic                 =   "com.app.remuda_equipment_basic"
    case remuda_equipment_premium               =   "com.app.remuda_equipment_premium"
}


class IAPManager: NSObject  {
    
    private override init() {}
    static let shared = IAPManager()
    var products = [SKProduct]()
    
    var delegate: IAPPurchasedDelegate?
    
    let paymentQueue = SKPaymentQueue.default()
    var onPaymentStatus:((Bool, String) -> ())?
    var productId: String = ""
    let secretKey = "c1e3276e48e9422db326726575d7a45e"
    let verifyReceiptURLType = AppleReceiptValidator.VerifyReceiptURLType.sandbox
    
    ///step2
    public func fetchProductIdentifiers(){
        let request = SKProductsRequest(productIdentifiers: Set(ProductId.allCases.compactMap({ $0.rawValue })))
        request.delegate = self
        request.start()
        SKPaymentQueue.default().add(self)
    }
    
    func verifyPurchaseResult(withPurchasedproduct id: String) {
        let appleValidator = AppleReceiptValidator(service: verifyReceiptURLType, sharedSecret: secretKey)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: id, inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\(id) is purchased: \(receiptItem)")
                    self.verifySubscriptionResult()
                    self.onPaymentStatus?(true, id)
                    break
                case .notPurchased:
                    
                    print("The user has never purchased \(id)")
                    break
                }
            case .error(let error):
                
                print("Receipt verification failed: \(id), \(error.localizedDescription)")
                break
            }
        }
    }
    
    func verifySubscriptionResult() {
        let appleValidator = AppleReceiptValidator(service: IAPManager.shared.verifyReceiptURLType, sharedSecret: IAPManager.shared.secretKey)
        let productArray = ProductId.allCases.compactMap({ $0.rawValue })//Get Product Ids array
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                for productId in productArray {
                    // Verify the purchase of a Subscription
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .autoRenewable, // or .nonRenewing (see below)
                        productId: productId,
                        inReceipt: receipt)
                    switch purchaseResult {
                    case .purchased(let expiryDate, let items):
                        print("\(productId) is valid until \(expiryDate)\n\(items)\n")
                        break
                    case .expired(let expiryDate, let items):
                        print("\(productId) is expired since \(expiryDate)\n\(items)\n")
                        break
                    case .notPurchased:
                        print("The user has never purchased \(productId)")
                        break
                    }
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
    }
    
}


// MARK: - SKProductsRequestDelegate
///step3
extension IAPManager: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        
        self.products = response.products
        for products in response.products {
            print("product added")
            print("Product Name : ",products.localizedTitle)
            print(products.productIdentifier)
            print(products.localizedDescription)
            print(products.price)
        }
    }
}

// MARK: - StoreKit API
extension IAPManager {
    ///step4
    public func purchase(productIdentifier: ProductId){
        self.productId = productIdentifier.rawValue
        guard SKPaymentQueue.canMakePayments() else {
            return
        }
        guard let storeKitProduct = products.first(where: { $0.productIdentifier == productIdentifier.rawValue }) else{
            return
        }
        let paymentRequest = SKPayment(product: storeKitProduct)
//        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    public func buyProduct(_ product: SKProduct) {
        print("Buying \(product.productIdentifier)...")
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    public class func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}


// MARK: - SKPaymentTransactionObserver
///step5
extension IAPManager: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchasing:
                print("purchasing...")
            case .purchased:
                print("purchased...")
                delegate?.purchasedCallAPI()
                 self.verifyPurchaseResult(withPurchasedproduct: self.productId)
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            case .failed:
                print("purchasing failed...")
            case .restored:
                print("purchasing restored...")
            case .deferred:
                print("purchasing deferred...")
            default:
                print("Something went wrong in purchasing...")
            }
        }
    }
}

///step5
extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred: return "purchasing deferred..."
        case .failed: return "purchasing failed..."
        case .purchased: return "purchased..."
        case .purchasing: return "purchasing..."
        case .restored: return "purchasing restored..."
        default: return "Something went wrong in purchasing..."
        }
    }
}

















