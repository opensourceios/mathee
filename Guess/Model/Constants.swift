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
    }


    struct Misc {
        static let fontChalkduster = "Chalkduster"
        static let fontSize: CGFloat = 40
        static let appVersion = "CFBundleShortVersionString"
        static let version = "Version"
        static let appName = "Guess"
        static let cancel = "Cancel"
        static let shareApp = "Tell a Friend"
        static let sendFeedback = "Contact Us"
        static let leaveReview = "Leave a review"
        static let emailSample = "Hi. I have a question..."
        static let emailAddress = "musicbyds@icloud.com"
        static let reviewLink = "https://itunes.apple.com/app/id1406084758?action=write-review"
        static let showAppsButtonTitle = "More by Daniel Springer"
        static let devID = "1402417666"
        static let didScrollOnceDown = "didScrollOnceDown"
        static let appsLink = "https://itunes.apple.com/developer/id1402417666"
    }


    struct Sound {
        static let high = "high.caf"
        static let low = "low.caf"
        static let chime = "chime.caf"
    }


    struct UserDef {
        static let soundEnabled = "soundEnabled"
        static let darkModeEnabled = "darkModeEnabled"
    }


}
