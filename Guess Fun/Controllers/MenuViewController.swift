//
//  MenuViewController.swift
//  Guess Fun
//
//  Created by Dani Springer on 05/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import UIKit
import SystemConfiguration
import MessageUI
import StoreKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Outlets
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var aboutButton: UIBarButtonItem!
    
    
    // MARK: Properties
    
    var fullHeight: CGFloat!
    let fontSetter: CGFloat = 10
    let cellsContent = ["📗", "✖️➗➕➖", "👆👇" , "🕘"]
    let menuCell = "MenuCell"
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myFont = UIFont(name: Constants.misc.fontChalkduster, size: 14.0) {
            aboutButton.setTitleTextAttributes([NSAttributedString.Key.font: myFont], for: .normal)
            aboutButton.setTitleTextAttributes([NSAttributedString.Key.font: myFont], for: .highlighted)
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self.myTableView,
                                               selector: #selector(myTableView.reloadData),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
        
        myTableView.separatorColor = UIColor.clear
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        
        if let selectedRow = myTableView.indexPathForSelectedRow {
        myTableView.deselectRow(at: selectedRow, animated: true)
        }
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self.myTableView, name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    
    // TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsContent.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: menuCell)!
        
        cell.textLabel?.text = cellsContent[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: myTableView.frame.height / fontSetter)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)
        
        switch indexPath.row {
        case 0:
            let controller = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.pagesVC) as! PagesViewController
            self.navigationController?.pushViewController(controller, animated: true)
        case 1:
            let controller = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.dtdtVC) as! DTDTViewController
            self.navigationController?.pushViewController(controller, animated: true)
        case 2:
            let controller = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.higherVC) as! HigherLowerViewController
            self.navigationController?.pushViewController(controller, animated: true)
        case 3:
            let controller = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.magicVC) as! MagicViewController
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            print("An error has occured!")
            let alert = createAlert(alertReasonParam: alertReason.unknown)
            alert.view.layoutIfNeeded()
            present(alert, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        updateRowHeight(indexPath: indexPath)
        
        return myTableView.frame.height / CGFloat(cellsContent.count)
    }
    
    
    func updateRowHeight(indexPath: IndexPath) {
        
        myTableView.cellForRow(at: indexPath)?.textLabel?.font = UIFont.systemFont(ofSize: myTableView.frame.height / fontSetter)
    }
    
    
    // MARK: Actions
   
    @IBAction func rightBarButtonPressed() {
        
        let version: String? = Bundle.main.infoDictionary![Constants.misc.appVersion] as? String
        let infoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let version = version {
            infoAlert.message = "\(Constants.misc.version) \(version)"
            infoAlert.title = Constants.misc.appName
        }
        
        infoAlert.modalPresentationStyle = .popover
        
        let cancelAction = UIAlertAction(title: Constants.misc.cancel, style: .cancel) {
            _ in
            self.dismiss(animated: true, completion: {
                SKStoreReviewController.requestReview()
            })
        }
        
        let shareAppAction = UIAlertAction(title: Constants.misc.shareApp, style: .default) {
            _ in
            self.shareApp()
        }
        
        let mailAction = UIAlertAction(title: Constants.misc.sendFeedback, style: .default) {
            _ in
            self.launchEmail()
        }
        
        let reviewAction = UIAlertAction(title: Constants.misc.leaveReview, style: .default) {
            _ in
            self.requestReviewManually()
        }
        
        for action in [mailAction, reviewAction, shareAppAction, cancelAction] {
            infoAlert.addAction(action)
        }
        
        if let presenter = infoAlert.popoverPresentationController {
            presenter.barButtonItem = aboutButton
        }
        
        present(infoAlert, animated: true)

    }
    
    
    func shareApp() {
        let message = "Check out Guess Fun: It's an app with 4 number guessing games. https://itunes.apple.com/app/id1406084758 - it's really cool!"
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = aboutButton // for iPads not to crash
        activityController.completionWithItemsHandler = {
            (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
            guard error == nil else {
                let alert = self.createAlert(alertReasonParam: alertReason.unknown)
                alert.view.layoutIfNeeded()
                self.present(alert, animated: true)
                return
            }
        }
        present(activityController, animated: true)
    }

}


extension MenuViewController: MFMailComposeViewControllerDelegate {
    
    
    func launchEmail() {
        
        var emailTitle = Constants.misc.appName
        if let version = Bundle.main.infoDictionary![Constants.misc.appVersion] {
            emailTitle += " \(version)"
        }
        let messageBody = Constants.misc.emailSample
        let toRecipents = [Constants.misc.emailAddress]
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
                alert.view.layoutIfNeeded()
                self.present(alert, animated: true)
            }
        })
    }
    
}


extension MenuViewController {
    
    
    func requestReviewManually() {
        // Note: Replace the XXXXXXXXXX below with the App Store ID for your app
        //       You can find the App Store ID in your app's product URL
        guard let writeReviewURL = URL(string: Constants.misc.reviewLink)
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
