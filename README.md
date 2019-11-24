# wallet
## App that tracks your purchases against a budget.
### Significantly updated version of [wallet](https://github.com/matisluzi/wallet), with new UI and added features.

## How to Install:
1. [Download Cydia Impactor](http://www.cydiaimpactor.com/).
2. Download the IPA file.
3. Connect your iPhone to your computer and open Cydia Impactor.
4. Drag-and-drop the IPA file to the Cydia Impactor window. It will ask for an Apple ID and a Password.
5. If you entered a correct account and password, wait until the app is installed on your iPhone.
6. Open the Settings app on your iPhone, go to General -> Profile & Device Management.
7. You will see the Apple ID that you entered into Cydia Impactor. Click on it and press "Trust".
8. You can now use the app until it expires in 7 days. (if you want it to not expire, do this process again before the 7 days are up)

## How to use other currencies
1. Open the file `wallet-new/viewcontroller.swift`
2. Find this line:<br />
  `var currency:String = "KM"`
3. Change KM to your preferred currency.
4. Compile and run.
