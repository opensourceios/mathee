//
//  Const.swift
//  Matemagica
//
//  Created by Daniel Springer on 11/26/18.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


struct Const {

    struct UserDef {
        static let sawTutorial = "sawTutorial"
    }


    struct StoryboardID {
        static let main = "Main"
        static let bookVC = "BookViewController"
        static let formulaVC = "FormulaViewController"
        static let higherVC = "HigherLowerViewController"
        static let magicVC = "MagicViewController"
        static let tutorialVC = "TutorialVC"
    }


    struct Misc {
        static let appVersion = "CFBundleShortVersionString"
        static let version = "v."
        static let appName = "Math Magic"
        static let cancel = "Cancel"
        static let sendFeedback = "Contact us"
        static let leaveReview = "Leave a review"
        static let emailSample = "Hi. I have a question..."
        static let emailAddress = "00.segue_affix@icloud.com"
        static let reviewLink = "https://apps.apple.com/app/id1406084758?action=write-review"
        static let showAppsButtonTitle = "More apps"
        static let devID = "1402417666"
        static let appsLink = "https://apps.apple.com/developer/id1402417666"
        static let shareBodyMessage = """
        Amaze your friends when you guess any number they think of

        https://apps.apple.com/app/id1406084758
        """
        static let yesMessage = "Yes"
        static let noMessage = "No"
        static let okMessage = "OK"
        static let correctMessage = "Correct"
        static let higherMessage = "Higher"
        static let lowerMessage = "Lower"
        static let doneMessage = "Done"
        static let retryMessage = "Retry"
        static let endMessage = "Return home"
        static let oddMessage = "Odd"
        static let evenMessage = "Even"
        static let aboutMessage = "About"
        static let shareTitleMessage = "Tell a friend"
        static let myDataSourceHomeMenu = ["Guess it BLAH BLAH BLAH",
                                           "Spot it BLAH BLAH BLAH",
                                           "Lower Or Higher BLAH",
                                           "Mystical 9 BLAH BLAH"]
        static let trick = "Trick"
    }


}