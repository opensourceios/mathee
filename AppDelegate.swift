//
//  AppDelegate.swift
//  Mathee
//
//  Created by Daniel Springer on 01/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    // TODO: Shabbos
    // - Tell me which I got wrong on level ended?
    // - Show me next level's range
    // - Allow changing base from 7 to 2-9 (or even higher?)
    // - Allow changing lives per level? (min 1 or infinite option?)
    // - Allow changing goal? (min 1x correct guess value)
    // - Allow changing timer?
    // - Allow changing added values to each level?
    // - Allow changing points per guess?
    // - Allow changing...?
    // - Update tutorial to reflect customizable values
    // - Update single levels UI to reflect customizable values

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
