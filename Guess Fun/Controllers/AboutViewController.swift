//
//  AboutViewController.swift
//  Guess Fun
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
        
        let bigSize: CGFloat = 20
        let smallSize: CGFloat = 14
        
        if let myFont = UIFont(name: "Chalkduster", size: bigSize) {
            UIBarButtonItem.appearance().setTitleTextAttributes(
                [
                    NSAttributedString.Key.font : myFont,
                    NSAttributedString.Key.foregroundColor : view.tintColor,
                    ], for: .normal)
            UIBarButtonItem.appearance().setTitleTextAttributes(
                [
                    NSAttributedString.Key.font : myFont,
                    NSAttributedString.Key.foregroundColor : view.tintColor,
                    ], for: .selected)
            UIBarButtonItem.appearance().setTitleTextAttributes(
                [
                    NSAttributedString.Key.font : myFont,
                    NSAttributedString.Key.foregroundColor : view.tintColor,
                    ], for: .highlighted)
            UIBarButtonItem.appearance().setTitleTextAttributes(
                [
                    NSAttributedString.Key.font : myFont,
                    NSAttributedString.Key.foregroundColor : UIColor.gray,
                    ], for: .disabled)

            
            versionButtonLabel.setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: smallSize) ?? myFont,
                    NSAttributedString.Key.foregroundColor: UIColor.darkText], for: .disabled)
            versionButtonLabel.isEnabled = false

        }
        
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] {
            versionButtonLabel.title = "Version \(version)"
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
        let message = "Check out Guess Fun: It's an app with 4 number guessing games. https://itunes.apple.com/app/id1406084758 - it's really cool!"
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view // for iPads not to crash
        activityController.completionWithItemsHandler = {
            (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
            guard error == nil else {
                let alert = self.createAlert(alertReasonParam: alertReason.unknown)
                self.present(alert, animated: true)
                return
            }
        }
        present(activityController, animated: true)
    }
}

extension AboutViewController: MFMailComposeViewControllerDelegate {
    
    @IBAction func launchEmail(sender: AnyObject) {
        
        var emailTitle = "Guess Fun"
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] {
            emailTitle += " \(version)"
        }
        let messageBody = "Hi. I have a question..."
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
                alert = self.createAlert(alertReasonParam: alertReason.messageFailed)
            case MFMailComposeResult.saved:
                alert = self.createAlert(alertReasonParam: alertReason.messageSaved)
            case MFMailComposeResult.sent:
                alert = self.createAlert(alertReasonParam: alertReason.messageSent)
            default:
                break
            }
            
            if let _ = alert.title {
                self.present(alert, animated: true)
            }
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
        UIApplication.shared.open(writeReviewURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
