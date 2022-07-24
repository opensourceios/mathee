//
//  Const.swift
//  Math Magic
//
//  Created by Daniel Springer on 11/26/18.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


struct Const {
    static let appVersion = "CFBundleShortVersionString"
    static let version = "v."
    static let appName = "Math Magic"
    static let cancel = "Cancel"
    static let sendFeedback = "Contact us"
    static let leaveReview = "Leave a review"
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
    static let spotItCell = "mycell"


    static let dataSourceHome = [
        ["sectionTitle": "Difficulty: Easy",
         "sections": [
            [
                "icon": "plus.slash.minus",
                "color": UIColor.systemPurple,
                "title": "Guess it",
                "id": "FormulaViewController"
            ],
            [
                "icon": "arrow.up.arrow.down",
                "color": UIColor.systemBlue,
                "title": "Lower or higher",
                "id": "HigherLowerViewController"]
         ]
        ],
        ["sectionTitle": "Difficulty: Medium",
         "sections": [
            [
                "icon": "book",
                "color": UIColor.systemOrange,
                "title": "Spot it",
                "id": "BookViewController"]
         ]
        ],
        ["sectionTitle": "Difficulty: Hard",
         "sections": [
            [
                "icon": "wand.and.stars",
                "color": UIColor.systemRed,
                "title": "Mystical 9",
                "id": "MagicViewController"]
         ]
        ]
    ]

}
