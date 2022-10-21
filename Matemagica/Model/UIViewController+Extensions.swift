//
//  UIViewController+Extensions.swift
//  Math Magic
//
//  Created by Daniel Springer on 9/16/21.
//  Copyright © 2022 Daniel Springer. All rights reserved.
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

        let attributedMessageJumbo = NSAttributedString(string: toAttrify, attributes: jumboAttributes)

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
        case shabbosInstructions
    }


    func createAlert(alertReasonParam: AlertReason, style: UIAlertController.Style) -> UIAlertController {

        var alertTitle = ""
        var alertMessage = ""
        switch alertReasonParam {
            case .textfieldEmpty:
                alertTitle = "Textfield empty"
                alertMessage = "Please try again"
            case .nan:
                alertTitle = "Please enter numbers only"
                alertMessage = """
                Highest number allowed: \(UInt64.max/4)
                """
            case .shabbosInstructions:
                alertTitle = "How To Play"
                alertMessage = """
                Tap "Shabbos" if the shown number is a multiple of 7, otherwise tap "Nope"
                """
            default:
                alertTitle = "Unknown error"
                alertMessage = """
            An unknown error occurred. Please try again
            """
        }

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: style)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            if let safeSelf = self as? FormulaViewController {
                safeSelf.myTextField.becomeFirstResponder()
            }
        }
        alert.addAction(alertAction)

        return alert
    }


    // self.showToast(message: "Your Toast Message")
    func showToast(message: String, color: UIColor) {
        let myWidth: CGFloat = 256
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - (myWidth/2),
                                               y: self.view.frame.size.height-200,
                                               width: myWidth, height: 48))
        toastLabel.backgroundColor = color
        toastLabel.textColor = .label
        toastLabel.font = .preferredFont(forTextStyle: .body)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2, delay: 0.1, options: .curveLinear, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in // completed in
            toastLabel.removeFromSuperview()
        })
    }

}
