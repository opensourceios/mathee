//
//  Const.swift
//  Mathee
//
//  Created by Daniel Springer on 11/26/18.
//  Copyright © 2023 Daniel Springer. All rights reserved.
//

import UIKit

// swiftlint:disable:next identifier_name
let ud = UserDefaults.standard

struct Const {
    static let appVersion = "CFBundleShortVersionString"
    static let version = "v."
    static let appName = "Mathee - Math Tricks & Games"
    static let contact = "Email Me"
    static let emailString = "00.segue_affix@icloud.com"
    static let cancel = "Cancel"
    static let leaveReview = "Leave a review"
    static let reviewLink = "https://apps.apple.com/app/id1406084758?action=write-review"
    static let showAppsButtonTitle = "More apps"
    static let appsLink = "https://apps.apple.com/developer/id1402417666"
    static let yesMessage = "Yes"
    static let noMessage = "No"
    static let okMessage = "OK"
    static let correctMessage = "Correct"
    static let doneMessage = "Done"
    static let endMessage = "Return home"
    static let oddMessage = "Odd"
    static let evenMessage = "Even"
    static let shareTitleMessage = "Tell a friend"
    static let spotItCell = "mycell"
    static let ShabbosLevelsViewController = "ShabbosLevelsViewController"
    static let shabbosViewController = "ShabbosViewController"
    static let shabbosTutorialViewController = "ShabbosTutorialViewController"
    static let shabbosLevelCell = "levelCell"
    static let userSawShabbosTutorial = "userSawShabbosTutorial"
    static let levelIndexKey = "levelIndexKey"
    static let completedShabbosLevels = "completedShabbosLevels"


    static let dataSourceHome = [

        ["icon": "magnifyingglass",
         "color": UIColor.systemMint,
         "title": "Spot it",
         "id": "BookViewController"],

        ["icon": "key",
         "color": UIColor.systemOrange,
         "title": "Guess it",
         "id": "FormulaViewController"],

        ["icon": "brain.head.profile",
         "color": UIColor.systemPurple,
         "title": "Shabbos",
         "id": "ShabbosViewController"],

        ["icon": "sparkles",
         "color": UIColor.systemGreen,
         "title": "Mystical Nine",
         "id": "MagicViewController"],

        ["icon": "arrow.up.arrow.down",
         "color": UIColor.systemRed,
         "title": "Lower or higher",
         "id": "HigherLowerViewController"]

    ]


    static let pointsPerTap = 70
    static let timerSeconds: Float = 30
    static let shabbosLevelsCount = 100
    static let rangeAddedPerLevel = 10
    static let livesPerLevel = 3

}
