//
//  IntentHandler.swift
//  BalanceIntent
//

//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is GetBalanceIntent else {
            fatalError("Unhandled intent type: \(intent)")
        }
        return GetBalanceIntentHandler()
    }
}
