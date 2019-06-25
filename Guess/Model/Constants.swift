//
//  Constants.swift
//  Guess
//
//  Created by Daniel Springer on 11/26/18.
//  Copyright © 2019 Daniel Springer. All rights reserved.
//

import UIKit


struct Constants {


    struct StoryboardID {
        static let main = "Main"
        static let pagesVC = "PagesViewController"
        static let dtdtVC = "DTDTViewController"
        static let higherVC = "HigherLowerViewController"
        static let magicVC = "MagicViewController"
        static let queensVC = "QueensViewController"
        static let settingsVC = "SettingsViewController"
    }


    struct Misc {
        static let appVersion = "CFBundleShortVersionString"
        static let version = "Version"
        static let appName = "Guess"
        static let cancel = "Cancel"
        static let sendFeedback = "Contact Us"
        static let leaveReview = "Leave a Review"
        static let emailSample = "Hi. I have a question..."
        static let emailAddress = "***REMOVED***"
        static let reviewLink = "https://itunes.apple.com/app/id1406084758?action=write-review"
        static let showAppsButtonTitle = "More by Daniel Springer"
        static let customAppIconTitle = "Change App Icon"
        static let devID = "1402417666"
        static let didScrollOnceDown = "didScrollOnceDown"
        static let appsLink = "https://itunes.apple.com/developer/id1402417666"
        static let shareBodyMessage = """
        Amaze your friends when you guess any number they think of, by secretly using this app! \
        Check it out: https://itunes.apple.com/app/id1406084758
        """
        static let yesMessage = "Yes"
        static let noMessage = "No"
        static let okMessage = "OK"
        static let doneMessage = "Done"
        static let retryMessage = "Retry"
        static let endMessage = "End"
        static let oddMessage = "Odd"
        static let evenMessage = "Even"
        static let aboutMessage = "About"
        static let shareTitleMessage = "Tell a Friend"
    }


    struct UserDef {
        static let iconIsDark = "iconIsDark"
        static let light = "light"
        static let dark = "dark"
    }


}
