//
//  Alert.swift
//  Guess My Number Fun
//
//  Created by Dani Springer on 8/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    enum alertReason: String {
        case messageSaved = "messageSaved"
        case messageCanceled = "messageCanceled"
        case messageFailed = "messageFailed"
        case messageSent = "messageSent"
        case unknown = "unknown"
    }
    
    func createAlert(alertReasonParam: String) -> UIAlertController {
        
        var alertTitle = ""
        var alertMessage = ""
        switch alertReasonParam {
        case alertReason.messageSaved.rawValue:
            alertTitle = "Message saved"
            alertMessage = "Your message has been saved to drafts."
        case alertReason.messageCanceled.rawValue:
            alertTitle = "Action cancelled"
            alertMessage = "Your message has not been sent."
        case alertReason.messageFailed.rawValue:
            alertTitle = "Action failed"
            alertMessage = "Your message has not been sent. Please try again later, or contact us by visiting DaniSpringer.GitHub.io"
        case alertReason.messageSent.rawValue:
            alertTitle = "Success!"
            alertMessage = "Your message has been sent. You should hear from us within 24 working hours."
        default:
            alertTitle = "Unknown error"
            alertMessage = "An unknown error occurred. Please try again later, or contact us by visiting DaniSpringer.GitHub.io"
        }
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        
        return alert
    }
}
