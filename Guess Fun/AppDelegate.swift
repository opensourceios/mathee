//
//  AppDelegate.swift
//  Guess Fun
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

    private func application(application: UIApplication,
                             didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        UserDefaults.standard.register(defaults: [Constants.Misc.didScrollOnceDown: false])
        return true
    }


}
