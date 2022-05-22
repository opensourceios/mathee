//
//  Const.swift
//  Math Magic
//
//  Created by Daniel Springer on 11/26/18.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


struct Const {

    struct StoryboardID {
        static let main = "Main"
        static let bookVC = "BookViewController"
        static let formulaVC = "FormulaViewController"
        static let higherVC = "HigherLowerViewController"
        static let magicVC = "MagicViewController"
    }

    enum TitleEnum: String, CaseIterable {
        // swiftlint:disable:next identifier_name
        case spotIt = "Spot it", guessIt = "Guess it", mystical_9 = "Mystical 9",
             lowerOrHigher = "Lower or higher"
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
        static let yesMessage = "Yes"
        static let noMessage = "No"
        static let okMessage = "OK"
        static let correctMessage = "Correct"
        static let higherMessage = "Higher"
        static let lowerMessage = "Lower"
        static let doneMessage = "Done"
        static let endMessage = "Return home"
        static let oddMessage = "Odd"
        static let evenMessage = "Even"
        static let aboutMessage = "About"
        static let shareTitleMessage = "Tell a friend"

        static let tintColorsArray: [UIColor] = [
            .systemOrange,
            .systemPurple,
            .systemRed,
            .systemBlue
        ]

        static let myImageSource = ["book",
                                    "plus.slash.minus",
                                    "wand.and.stars",
                                    "arrow.up.arrow.down"]


        static var titleArrFromEnum: [String] {
            var mySampleArray: [String] = []
            for item in Const.TitleEnum.allCases {
                mySampleArray.append(item.rawValue)
            }
            return mySampleArray
        }

    }

}
