//
//  Alert.swift
//  Matemagica
//
//  Created by Daniel Springer on 8/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


extension UIViewController {


    enum AlertReason {
        case unknown
        case iap
    }


    func createAlert(alertReasonParam: AlertReason) -> UIAlertController {

        var alertTitle = ""
        var alertMessage = ""
        switch alertReasonParam {
            case .iap:
                alertTitle = "Purchase Or Restore failed"
                alertMessage = """
                Please send me a screenshot of this error at dani.springer@icloud.com and contact Apple for support
                """
            default:
                alertTitle = "Unknown error"
                alertMessage = """
            An unknown error occurred. Please try again later, or contact us at dani.springer@icloud.com
            """
        }

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)

        return alert
    }


}
