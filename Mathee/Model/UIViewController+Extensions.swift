//
//  UIViewController+Extensions.swift
//  Mathee
//
//  Created by Daniel Springer on 9/16/21.
//  Copyright © 2023 Daniel Springer. All rights reserved.
//

import UIKit

extension UIViewController {

    func setThemeColorTo(myThemeColor: UIColor) {
        UIProgressView.appearance().progressTintColor = myThemeColor
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


    func attrifyString(preString: String, toAttrify: String,
                       postString: String?, color: UIColor) -> NSMutableAttributedString {
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .title3)]
        let jumboAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 100, weight: .semibold),
            .foregroundColor: color]
        let attributedMessagePre = NSAttributedString(
            string: preString,
            attributes: regularAttributes)

        let attributedMessageJumbo = NSAttributedString(string: toAttrify,
                                                        attributes: jumboAttributes)

        let myAttributedText = NSMutableAttributedString()

        myAttributedText.append(attributedMessagePre)
        myAttributedText.append(attributedMessageJumbo)

        if postString != nil {
            let attributedMessagePost: NSAttributedString = NSAttributedString(
                string: "\n" + postString!, attributes: regularAttributes)
            myAttributedText.append(attributedMessagePost)
        }

        return myAttributedText
    }


    enum AlertReason {
        case unknown
        case textfieldEmpty
        case nan

        case emailError
    }


    func createAlert(alertReasonParam: AlertReason,
                     levelIndex: Int = 0, points: Int = 0,
                     secondsUsed: Int = 0, livesLeft: Int = 0) -> UIAlertController {

        var alertTitle = ""
        var alertMessage = ""
        switch alertReasonParam {
            case .emailError:
                alertTitle = "Email Not Sent"
                alertMessage = """
                Your device could not send e-mail. Please check e-mail configuration and \
                try again.
                """
            case .textfieldEmpty:
                alertTitle = "Textfield empty"
                alertMessage = "Please try again"
            case .nan:
                alertTitle = "Please enter numbers only"
                alertMessage = """
                Highest number allowed: \(UInt64.max/4)
                """
            default:
                alertTitle = "Unknown error"
                alertMessage = """
            An unknown error occurred. Please try again
            """
        }

        let alert = UIAlertController(title: alertTitle, message: alertMessage,
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            if let safeSelf = self as? FormulaViewController {
                safeSelf.myTextField.becomeFirstResponder()
            }
        }
        alert.addAction(alertAction)

        return alert
    }

}
