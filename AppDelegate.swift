//
//  AppDelegate.swift
//  Guess
//
//  Created by Daniel Springer on 01/07/2018.
//  Copyright © 2019 Daniel Springer. All rights reserved.
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
        UserDefaults.standard.register(defaults:
            [Constants.Misc.didScrollOnceDown: false,
             Constants.UserDef.iconIsDark: false])

        return true
    }

}
