//
//  Const.swift
//  Matemagica
//
//  Created by Daniel Springer on 11/26/18.
//  Copyright © 2021 Daniel Springer. All rights reserved.
//

import UIKit


struct Const {


    struct StoryboardID {
        static let main = "Main"
        static let bookVC = "BookViewController"
        static let formulaVC = "FormulaViewController"
        static let higherVC = "HigherLowerViewController"
        static let magicVC = "MagicViewController"
        static let queensVC = "QueensViewController"
    }


    struct Misc {
        static let appVersion = "CFBundleShortVersionString"
        static let version = NSLocalizedString("v.", comment: "")
        static let appName = NSLocalizedString("Matemagica", comment: "")
        static let cancel = NSLocalizedString("Cancel", comment: "")
        static let tutorial = "Tutorial"
        static let sendFeedback = NSLocalizedString("Contact Us", comment: "")
        static let leaveReview = NSLocalizedString("Leave a Review", comment: "")
        static let emailSample = NSLocalizedString("Hi. I have a question...", comment: "")
        static let emailAddress = "dani.springer@icloud.com"
        static let reviewLink = "https://apps.apple.com/app/id1406084758?action=write-review"
        static let showAppsButtonTitle = NSLocalizedString("More Apps", comment: "")
        static let devID = "1402417666"
        static let appsLink = "https://apps.apple.com/developer/id1402417666"
        static let shareBodyMessage = NSLocalizedString("""
        Amaze your friends when you guess any number they think of

        https://apps.apple.com/app/id1406084758
        """, comment: "")
        static let yesMessage = NSLocalizedString("Yes", comment: "")
        static let noMessage = NSLocalizedString("No", comment: "")
        static let okMessage = NSLocalizedString("OK", comment: "")
        static let doneMessage = NSLocalizedString("Done", comment: "")
        static let retryMessage = NSLocalizedString("Retry", comment: "")
        static let endMessage = NSLocalizedString("Return home", comment: "")
        static let playAgainMessage = NSLocalizedString("Play again", comment: "")
        static let oddMessage = NSLocalizedString("Odd", comment: "number")
        static let evenMessage = NSLocalizedString("Even", comment: "number")
        static let aboutMessage = NSLocalizedString("About", comment: "")
        static let shareTitleMessage = NSLocalizedString("Tell a Friend", comment: "")
    }


}
