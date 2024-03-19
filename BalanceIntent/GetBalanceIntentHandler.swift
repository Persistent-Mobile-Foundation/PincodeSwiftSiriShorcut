//
//  GetBalanceIntentHandler.swift
//  BalanceIntent
//
//

//

import UIKit
import IBMMobileFirstPlatformFoundation

public class GetBalanceIntentHandler: NSObject, GetBalanceIntentHandling {
    var mfpBank = "MobileFirst Bank"
    
    public func handle(intent: GetBalanceIntent, completion: @escaping (GetBalanceIntentResponse) -> Void) {
        if intent.bankname == mfpBank {
            let request = WLResourceRequest(url: URL(string: "/adapters/ResourceAdapter/balance"), method: WLHttpMethodGet)
            request?.send { (response, error) -> Void in
                if(error == nil) {
                    completion(GetBalanceIntentResponse.success(balance: (response?.responseText)!))
                }
                else{
                    if(response != nil) {
                        // Custom error message
                        completion(GetBalanceIntentResponse.bankRetreivefailure(errorInfo: response?.error as? String ?? "" ))
                    } else {
                        //Default error message
                        completion(GetBalanceIntentResponse(code: .failure, userActivity: nil))
                    }
                }
            }
        } else {
            // Invalid Bank
            completion(GetBalanceIntentResponse(code: .invalidBank, userActivity: nil))
        }
    }
}
