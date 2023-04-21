//
//  AppDelegate.swift
//  Mathee
//
//  Created by Daniel Springer on 01/07/2018.
//  Copyright © 2023 Daniel Springer. All rights reserved.
//

import UIKit


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties

    var window: UIWindow?
    // TODO:
    // let user choose base for Bingo
    // lock levels besides current

    // MARK: Life Cycle

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

                if CommandLine.arguments.contains("--matheeScreenshots") {
                    // We are in testing mode, make arrangements
                    ud.set(true, forKey: Const.userSawBingoTutorial)
                    ud.set("", forKey: Const.completedBingoLevels)
                }

                ud.register(defaults: [
                    Const.userSawBingoTutorial: false,
                    Const.completedBingoLevels: ""
                ])

                return true
            }

}
