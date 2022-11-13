//
//  AppDelegate.swift
//  Math Magic
//
//  Created by Daniel Springer on 01/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {


    // MARK: Properties

    var window: UIWindow?


    // MARK: Life Cycle

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [
            UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {

                if CommandLine.arguments.contains("--matemagicaScreenshots") {
                    // We are in testing mode, make arrangements
                    ud.set(true, forKey: Const.userSawShabbosTutorial)
                }

                ud.register(defaults: [
                    Const.userSawShabbosTutorial: false,
                    Const.completedShabbosLevels: ""
                ])

                return true
            }

}
