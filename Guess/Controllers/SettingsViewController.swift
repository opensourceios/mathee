//
//  SettingsViewController.swift
//  Guess
//
//  Created by Daniel Springer on 6/4/19.
//  Copyright © 2020 Dani Springer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!


    // MARK: Properties

    var myTitle: String!


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.myTitle

        mySwitch.isOn = UserDefaults.standard.bool(forKey: Constants.UserDef.iconIsDark)

    }


    // MARK: Helpers

    @IBAction func mySwitchToggled(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: Constants.UserDef.iconIsDark)
        setIcon()
    }


    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


    func setIcon() {
        let newIcon = UserDefaults.standard.bool(forKey: Constants.UserDef.iconIsDark) ?
            Constants.UserDef.dark : Constants.UserDef.light

        guard UIApplication.shared.supportsAlternateIcons else {
            print("NOTE: alternate icons not supported")
            return
        }

        UIApplication.shared.setAlternateIconName(newIcon) { error in
            if let error = error {
                print("App icon failed to change due to \(error.localizedDescription)")
            }
        }
    }
}
