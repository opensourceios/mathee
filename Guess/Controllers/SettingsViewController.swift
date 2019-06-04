//
//  SettingsViewController.swift
//  Guess
//
//  Created by Daniel Springer on 6/4/19.
//  Copyright © 2019 Dani Springer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myToolbar: UIToolbar!

    // MARK: Properties

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        mySwitch.isOn = UserDefaults.standard.bool(forKey: Constants.UserDef.iconIsDark)
        let darkMode = UserDefaults.standard.bool(forKey: Constants.UserDef.darkModeEnabled)
        view.backgroundColor = darkMode ? .black : .white
        myToolbar.barTintColor = darkMode ? .black : .white
        myLabel.textColor = darkMode ? .white : .black

        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Misc.fontSize)
            ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Misc.fontSize)
            ], for: .highlighted)

    }


    // MARK: Helpers

    @IBAction func mySwitchToggled(_ sender: UISwitch) {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
        UserDefaults.standard.set(sender.isOn, forKey: Constants.UserDef.iconIsDark)
        setIcon()
    }


    @IBAction func doneButtonPressed(_ sender: Any) {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
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
            } else {
                print("app icon should now be updated")
            }
        }
    }
}
