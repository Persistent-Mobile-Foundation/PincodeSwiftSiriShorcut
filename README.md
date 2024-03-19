PMF Foundation
===
## PinCodeSwiftSiriShortcut
A sample application demonstrating use of the CredentialsValidation Security Check along with Apple's Siri Shortcut feature.

### Usage

1. Use either Maven, MobileFirst CLI or your IDE of choice to [build and deploy the available `ResourceAdapter` and `PinCodeAttempts` adapters](https://pmf.persistentproducts.com/tutorials/en/foundation/9.0/adapters/creating-adapters/).



2. From a command-line window, navigate to the project's root folder and run the commands:
 - `pod update` followed by `pod install` - to add the MobileFirst SDK.
 - `pmfdev app register` - to register the application.
 -  Register Siri Intent Extension, If it is not registered in the MFP Operations Console
 - `pmfdev app push` - to map the `accessRestricted` scope to the `PinCodeAttempts` security check.
 -  Map the `accessRestricted` scope to empty security check for Siri Intent Extension

3. Run the application in the iOS Simulator or physical device. Press the **Get Balance** button and enter "1234" to display the balance.

4. Press the **Add to Siri** button to add the Siri Shortcut and fetch the balance from Siri.

> **Tip:** you can update the bundled SDK by running the command `pod update` from the project's root folder.

### Supported Levels
Persistent Mobile Foundation 9.0


