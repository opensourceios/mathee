//
//  Alert.swift
//  Guess
//
//  Created by Daniel Springer on 8/07/2018.
//  Copyright © 2020 Daniel Springer. All rights reserved.
//

import UIKit


extension UIViewController {


    enum AlertReason {
        case messageSaved
        case messageCanceled
        case messageFailed
        case messageSent
        case hasNoSolution
        case unknown
    }


    func createAlert(alertReasonParam: AlertReason) -> UIAlertController {

        var alertTitle = ""
        var alertMessage = ""
        switch alertReasonParam {
        case .messageSaved:
            alertTitle = "Message saved"
            alertMessage = "Your message has been saved to drafts."
        case .messageCanceled:
            alertTitle = "Action cancelled"
            alertMessage = "Your message has not been sent."
        case .messageFailed:
            alertTitle = "Action failed"
            alertMessage = """
            Your message has not been sent. Please try again later, or contact us by leaving a review.
            """
        case .messageSent:
            alertTitle = "Success!"
            alertMessage = "Your message has been sent. You should hear from us within 24 hours."
        case .hasNoSolution:
            alertTitle = "Tap, Tap"
            alertMessage = """
            Great job, you have found the Share button!
            Tap the Plus button on the bottom right of the screen to create your first solution, \
            then tap the Share button again to share your solution with friends and family!
            """
        default:
            alertTitle = "Unknown error"
            alertMessage = """
            An unknown error occurred. Please try again later, or contact us at musicbyds@icloud.com
            """
        }

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)

        return alert
    }


}
