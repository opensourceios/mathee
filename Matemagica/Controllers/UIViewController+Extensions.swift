//
//  UIViewController+Extensions.swift
//  Matemagica
//
//  Created by Dani on 9/16/21.
//  Copyright © 2021 Dani Springer. All rights reserved.
//

import UIKit

extension UIViewController {
    func setThemeColorTo(myThemeColor: UIColor) {
        self.navigationController!.navigationBar.tintColor = myThemeColor
        UINavigationBar.appearance().tintColor = myThemeColor
        UIView.appearance(
            whenContainedInInstancesOf: [
                UIAlertController.self]).tintColor = myThemeColor
        UIView.appearance(
            whenContainedInInstancesOf: [
                UIToolbar.self]).tintColor = myThemeColor

        UIButton.appearance().tintColor = myThemeColor

        UISwitch.appearance().onTintColor = myThemeColor

        for state: UIControl.State in [.application, .highlighted, .normal, .selected] {
            UIBarButtonItem.appearance().setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: myThemeColor
            ], for: state)
        }
    }
}
