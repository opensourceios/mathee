//
//  Alert.swift
//  Math Magic
//
//  Created by Daniel Springer on 8/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


extension UIViewController {


    enum AlertReason {
        case unknown
        case textfieldEmpty
        case nan
    }


    func createAlert(alertReasonParam: AlertReason) -> UIAlertController {

        var alertTitle = ""
        var alertMessage = ""
        switch alertReasonParam {
            case .textfieldEmpty:
                alertTitle = "Textfield empty"
                alertMessage = "Please try again"
            case .nan:
                alertTitle = "An error occurred"
                alertMessage = """
                Oops!
                That number is too big. Please think of a smaller number and try again
                (Please don't enter text. Only enter numbers)
                """
            default:
                alertTitle = "Unknown error"
                alertMessage = """
            An unknown error occurred. Please try again later, or contact us at \(Const.Misc.emailAddress)
            """
        }

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            if let safeSelf = self as? FormulaViewController {
                safeSelf.myTextField.becomeFirstResponder()
            }
        }
        alert.addAction(alertAction)

        return alert
    }


}
