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
    @IBOutlet weak var myBarButtonItem: UIBarButtonItem!


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        mySwitch.isOn = UserDefaults.standard.bool(forKey: Constants.UserDef.iconIsDark)
        updateTheme()

        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)
            ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)
            ], for: .highlighted)

        myBarButtonItem.title = Constants.Misc.doneMessage

    }


    // MARK: Helpers

    func updateTheme() {
        let darkMode = traitCollection.userInterfaceStyle == .dark

        let textColor: UIColor = darkMode ? .white : .black
        let backgroundColor: UIColor = darkMode ? .black : .white
        view.backgroundColor = backgroundColor
        myToolbar.barTintColor = backgroundColor
        myLabel.textColor = textColor
    }


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
            } else {
                print("app icon should now be updated")
            }
        }
    }
}
