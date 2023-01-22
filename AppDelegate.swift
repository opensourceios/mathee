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

    // TODO: Shabbos
    // - Allow changing base from 7 to 2-9 (if even higher, adjust lvl intervals)
    // - Allow changing lives per level? (min 1 or infinite option?)
    // - Allow changing added values to each level?
    // - Allow changing timer (as of now always 30 seconds)
    // - Allow changing goal of 1000 points, and/or points given per guess (as of now 70)
    // - Update tutorial to reflect customizable values
    // - Update each level's UI to reflect customizable values
    // - Tell me which I got wrong on level ended?
    // - Show me next level's range

    // MARK: Properties

    var window: UIWindow?


    // MARK: Life Cycle

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

                if CommandLine.arguments.contains("--matheeScreenshots") {
                    // We are in testing mode, make arrangements
                    ud.set(true, forKey: Const.userSawShabbosTutorial)
                    ud.set("", forKey: Const.completedShabbosLevels)
                }

                ud.register(defaults: [
                    Const.userSawShabbosTutorial: false,
                    Const.completedShabbosLevels: ""
                ])

                return true
            }

}
