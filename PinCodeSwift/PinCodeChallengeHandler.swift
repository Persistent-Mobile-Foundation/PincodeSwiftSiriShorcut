/**
* Copyright 2024 Persistent System.

*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import Foundation
import IBMMobileFirstPlatformFoundation

class PinCodeChallengeHandler : SecurityCheckChallengeHandler {

    //SecurityCheck name
    static let securityCheck = "PinCodeAttempts"

    //Register this class as a challenge handler
    static func registerSelf() {
        WLClient.sharedInstance().registerChallengeHandler(challengeHandler: PinCodeChallengeHandler(securityCheck: securityCheck))
    }

    override func handleChallenge(_ challenge: [AnyHashable: Any]!) {
        NSLog("%@",challenge)
        var errorMsg : String
        if challenge["errorMsg"] is NSNull {
            errorMsg = "This data requires a PIN code."
        }
        else{
            errorMsg = challenge["errorMsg"] as! String
        }
        let remainingAttempts = challenge["remainingAttempts"] as! Int

        showPopup(errorMsg,remainingAttempts: remainingAttempts)
    }

    override func handleFailure(_ failure: [AnyHashable: Any]!) {
        if let errorMsg = failure["failure"] as? String {
            showError(errorMsg)
        }
        else{
            showError("Unknown error")
        }
    }

    func showPopup(_ errorMsg: String, remainingAttempts: Int){
        let message = errorMsg + "\nRemaining attempts: " + String(remainingAttempts)

        let alert = UIAlertController(title: "Protected",
            message: message,
            preferredStyle: .alert)
        alert.addTextField { (textField) -> Void in
            textField.placeholder = "PIN CODE"
            textField.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let pinTextField = alert.textFields![0] as UITextField
            self.submitChallengeAnswer(["pin": pinTextField.text!])
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            self.cancel()
        }))

        DispatchQueue.main.async {
            let topController = UIApplication.shared.keyWindow!.rootViewController! as UIViewController
            topController.present(alert,
                animated: true,
                completion: nil)
        }


    }

    func showError(_ errorMsg: String){
        let alert = UIAlertController(title: "Error",
            message: errorMsg,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        DispatchQueue.main.async {
            let topController = UIApplication.shared.keyWindow!.rootViewController! as UIViewController
            topController.present(alert,
                animated: true,
                completion: nil)
        }
    }

    override func handleSuccess(_ success: [AnyHashable: Any]!) {
        NSLog("handleSuccess: %@",success)
    }

}
