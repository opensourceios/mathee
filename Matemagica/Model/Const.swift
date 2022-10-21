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
    static let ShabbosLevelsViewController = "ShabbosLevelsViewController"
    static let shabbosViewController = "ShabbosViewController"
    static let shabbosLevelCell = "levelCell"
    static let firstTimePlayingShabbos = "firstTimePlayingShabbos"


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
        var timerSeconds: Float
    }

    static let shabbosLevels: [Level] = [
        Level(numberRange: 1...030, timerSeconds: 60),
        Level(numberRange: 1...035, timerSeconds: 60),
        Level(numberRange: 1...050, timerSeconds: 50),
        Level(numberRange: 1...060, timerSeconds: 45),
        Level(numberRange: 1...060, timerSeconds: 30),
        Level(numberRange: 1...080, timerSeconds: 30),
        Level(numberRange: 1...080, timerSeconds: 25),
        Level(numberRange: 1...090, timerSeconds: 25),
        Level(numberRange: 1...090, timerSeconds: 20),
        Level(numberRange: 1...100, timerSeconds: 20)
    ]

}
