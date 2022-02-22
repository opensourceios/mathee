//
//  StoreViewController.swift
//  Matemagica
//
//  Created by dani on 2/21/22.
//  Copyright © 2022 Dani Springer. All rights reserved.
//

import UIKit
import StoreKit

class StoreViewController: UIViewController, SKPaymentTransactionObserver {

    // MARK: Outlets

    @IBOutlet weak var largeTitleLabel: UILabel!
    @IBOutlet weak var paragraphLabel: UILabel!


    // MARK: Properties

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        SKPaymentQueue.default().add(self)
        updateUI()
    }


    // MARK: Helpers

    func updateUI() {
        DispatchQueue.main.async {
            let isSupporter = UserDefaults.standard.bool(forKey: Const.Misc.isSupporter)
            self.largeTitleLabel.text = isSupporter ? "Status: Supporter 🥳" : "Become a Supporter"
            self.paragraphLabel.text = isSupporter ? """
            Thank you for being a Supporter. 😎

            The app's homepage will now show your status. ☕️☺️
            """ : """
            Buy me a cup of tea ☕️

            Becoming a Supporter will add a lil' badge to the app's homepage, so everyone looking will know your status

            Oh, and I LOVE tea, so thank you 🥰
            """
        }
    }


    @IBAction func buyPressed(_ sender: Any) {
        if SKPaymentQueue.canMakePayments() {
            let transactionRequest = SKMutablePayment()
            transactionRequest.productIdentifier = Const.Misc.iAPID
            SKPaymentQueue.default().add(transactionRequest)
        } else {
            print("User cannot make purchase") // TODO: alert?
        }
    }


    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

        for transaction in transactions {
            if transaction.transactionState == .purchased {
                UserDefaults.standard.set(true, forKey: Const.Misc.isSupporter)
                updateUI()
            } else if transaction.transactionState == .failed {
                print("failed")
                // TODO: alert user?
            }
        }

        // TODO: remove me!
        UserDefaults.standard.set(true, forKey: Const.Misc.isSupporter)
        updateUI()

    }

}
