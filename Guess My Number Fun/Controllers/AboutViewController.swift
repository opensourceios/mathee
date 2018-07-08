//
//  AboutViewController.swift
//  Guess My Number Fun
//
//  Created by Dani Springer on 08/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class AboutViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var versionButtonLabel: UIBarButtonItem!
    
    
    
    // MARK: Properties
    
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myFont = UIFont(name: "Chalkduster", size: 20.0) {
            UIBarButtonItem.appearance().setTitleTextAttributes(
                [
                    NSAttributedStringKey.font : myFont,
                    NSAttributedStringKey.foregroundColor : view.tintColor,
                    ], for: .normal)
            versionButtonLabel.setTitleTextAttributes(
                [
                    NSAttributedStringKey.font: myFont,
                    NSAttributedStringKey.foregroundColor: UIColor.darkText], for: .disabled)
            versionButtonLabel.isEnabled = false

        }
        
        
        
        
        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        
    }
    
    // MARK: Helpers
    
    @IBAction func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonPressed() {
        let message = "Check out 'Guess My Number Fun': It's an app with 4 games in 1 place! https://itunes.apple.com/us/developer/daniel-springer/id1402417666?mt=8"
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view // for iPads not to crash
        activityController.completionWithItemsHandler = {
            (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
            guard error == nil else {
                let alert = self.createAlert(alertReasonParam: alertReason.unknown.rawValue)
                self.present(alert, animated: true)
                return
            }
        }
        present(activityController, animated: true)
    }
}

extension AboutViewController: MFMailComposeViewControllerDelegate {
    
    @IBAction func launchEmail(sender: AnyObject) {
        
        let emailTitle = "[02 Feedback]"
        let messageBody = "Hi. I have a feature request/bug report/question..."
        let toRecipents = ["musicbyds@icloud.com"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        
        self.present(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        var alert = UIAlertController()
        
        dismiss(animated: true, completion: {
            switch result {
            case MFMailComposeResult.failed:
                alert = self.createAlert(alertReasonParam: alertReason.messageFailed.rawValue)
            case MFMailComposeResult.saved:
                alert = self.createAlert(alertReasonParam: alertReason.messageSaved.rawValue)
            case MFMailComposeResult.sent:
                alert = self.createAlert(alertReasonParam: alertReason.messageSent.rawValue)
            case MFMailComposeResult.cancelled:
                alert = self.createAlert(alertReasonParam: alertReason.messageCanceled.rawValue)
            }
            self.present(alert, animated: true)
        })
    }
}

extension AboutViewController {
    
    @IBAction func requestReviewManually() {
        // Note: Replace the XXXXXXXXXX below with the App Store ID for your app
        //       You can find the App Store ID in your app's product URL
        guard let writeReviewURL = URL(string: "https://itunes.apple.com/app/id1406084758?action=write-review")
            else {
                fatalError("Expected a valid URL")
                
        }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
}
