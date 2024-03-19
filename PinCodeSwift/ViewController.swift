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

import UIKit
import IBMMobileFirstPlatformFoundation
import Intents
import IntentsUI

class ViewController: UIViewController, INUIAddVoiceShortcutViewControllerDelegate {
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var copyrightLbl: UILabel!
    static var balanceIntent = GetBalanceIntent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donateInteraction()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.copyrightLbl.text = "©\(appDelegate.currentYear) Persistent System"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getBalance(_ sender: UIButton) {
        let request = WLResourceRequest(url: URL(string: "/adapters/ResourceAdapter/balance"), method: WLHttpMethodGet)
        request?.send { (response, error) -> Void in
            if(error == nil){
                NSLog((response?.responseText)!)
                self.balanceLabel.text = "Balance = " + (response?.responseText)!
                
            }
            else{
                NSLog(error.debugDescription)
                self.balanceLabel.text = "Failed to get balance"
            }
        }
        
    }
    
    @IBAction func addShorcut(_ sender: UIButton) {
        if let shortcut = INShortcut(intent: ViewController.balanceIntent) {
            let addVoiceShortcutVC = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            addVoiceShortcutVC.delegate = self
            present(addVoiceShortcutVC, animated: true, completion: nil)
        }
    }
    
    func donateInteraction() {
        ViewController.balanceIntent.bankname = "MobileFirst Bank"
        ViewController.balanceIntent.suggestedInvocationPhrase = "Show account balance of Savings Account"
        let interaction = INInteraction(intent: ViewController.balanceIntent, response: nil)
        
        interaction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: %@", error)
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
    }
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?,
                                        error: Error?) {
        if let error = error as NSError? {
            print("error adding voice shortcut: %@", error)
            return
        }
        self.balanceLabel.text = "Successfully added to Siri"
        dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        self.balanceLabel.text = "Failed to add shorcut to Siri"
        dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didUpdate voiceShortcut: INVoiceShortcut?,
                                         error: Error?) {
        if let error = error as NSError? {
            print("error adding voice shortcut: %@", error)
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
         self.balanceLabel.text = "Failed to add shorcut to Siri"
        dismiss(animated: true, completion: nil)
    }
}





