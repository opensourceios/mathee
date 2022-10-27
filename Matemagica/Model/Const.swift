//
//  Const.swift
//  Math Magic
//
//  Created by Daniel Springer on 11/26/18.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit

// swiftlint:disable:next identifier_name
let ud = UserDefaults.standard

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
    static let ShabbosLevelsViewController = "ShabbosLevelsViewController"
    static let shabbosViewController = "ShabbosViewController"
    static let shabbosLevelCell = "levelCell"
    static let optedOutOfShabbosHelp = "optedOutOfShabbosHelp"
    static let levelIndexKey = "levelIndexKey"


    static let dataSourceHome = [
        ["icon": "7.circle",
         "color": UIColor.systemPurple,
         "title": "Shabbos",
         "id": "ShabbosViewController"],

        ["icon": "plus.slash.minus",
         "color": UIColor.systemOrange,
         "title": "Guess it",
         "id": "FormulaViewController"],

        ["icon": "arrow.up.arrow.down",
         "color": UIColor.systemRed,
         "title": "Lower or higher",
         "id": "HigherLowerViewController"],

        ["icon": "book",
         "color": UIColor.systemMint,
         "title": "Spot it",
         "id": "BookViewController"],

        ["icon": "wand.and.stars",
         "color": UIColor.systemGreen,
         "title": "Mystical 9",
         "id": "MagicViewController"]
    ]


    struct Level {
        var numberRange: ClosedRange<Int>
    }

    static let pointsPerTap = 70
    static let goal = 1000
    static let timerSeconds: Float = 30

    // WHAT IS X?
    // X = seconds needed to reach goal
    // goal = 1000 points               //1000
    // seconds-a-tap = 3
    // average pts a correct tap = 80
    // avg accuracy a tap = 80%
    // avg pts a tap = average per correct * accuracy
    // X = goal / avg-pts-a-tap * seconds-a-tap
    // X = 1000 / 64 * 3

    static let shabbosLevelsCount = 100
    static let rangeAddedPerLevel = 20

}
