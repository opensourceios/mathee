//
//  MenuViewController.swift
//  Guess
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2020 Daniel Springer. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit


class MenuViewController: UIViewController,
                          UITableViewDataSource,
                          UITableViewDelegate,
                          SKStoreProductViewControllerDelegate {


    // MARK: Outlets

    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var aboutButton: UIBarButtonItem!


    // MARK: Properties

    let myDataSource = ["The Magic Formula", "Book",
                        "The Chess Puzzle", "Higher Lower", "MatheMagic"]
    let myImageSource = ["plus.slash.minus", "book", "8.square",
                         "arrow.up.arrow.down", "wand.and.stars"]

    let menuCell = "MenuCell"


    // MARK: Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true

        if let selectedRow = myTableView.indexPathForSelectedRow {
            myTableView.deselectRow(at: selectedRow, animated: true)
        }

        myTableView.rowHeight = UITableView.automaticDimension
    }


    // MARK: Show Apps

    func showApps() {

        let myURL = URL(string: Constants.Misc.appsLink)

        guard let safeURL = myURL else {
            let alert = createAlert(alertReasonParam: .unknown)
            present(alert, animated: true)
            return
        }

        UIApplication.shared.open(safeURL, options: [:], completionHandler: nil)

    }


    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        dismiss(animated: true, completion: nil)
    }


    // MARK: TableView Delegate

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Amaze Your Friends"
        } else {
            fatalError()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDataSource.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: menuCell) as? MainMenuTableViewCell

        cell?.myLabel.text = myDataSource[(indexPath as NSIndexPath).row]
        cell?.myImage.image = UIImage(systemName: myImageSource[(indexPath as NSIndexPath).row])
        cell?.selectionStyle = .none

        return cell ?? UITableViewCell()
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)

        let cell = tableView.cellForRow(at: indexPath) as? MainMenuTableViewCell

        switch cell?.myLabel?.text {
        case myDataSource[0]:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.formulaVC) as? FormulaViewController
            if let toPresent = controller {
                controller?.myTitle = myDataSource[indexPath.row]
                self.navigationController?.pushViewController(toPresent, animated: true)
            }
        case myDataSource[1]:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.bookVC) as? BookViewController
            if let toPresent = controller {
                controller?.myTitle = myDataSource[indexPath.row]
                self.navigationController?.pushViewController(toPresent, animated: true)
            }
        case myDataSource[2]:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.queensVC) as? QueensViewController
            if let toPresent = controller {
                controller?.myTitle = myDataSource[indexPath.row]
                self.navigationController?.pushViewController(toPresent, animated: true)
            }
        case myDataSource[3]:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.higherVC) as? HigherLowerViewController
            if let toPresent = controller {
                controller?.myTitle = myDataSource[indexPath.row]
                self.navigationController?.pushViewController(toPresent, animated: true)
            }
        case myDataSource[4]:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.magicVC) as? MagicViewController
            if let toPresent = controller {
                controller?.myTitle = myDataSource[indexPath.row]
                self.navigationController?.pushViewController(toPresent, animated: true)
            }
        default:
            let alert = createAlert(alertReasonParam: AlertReason.unknown)
            alert.view.layoutIfNeeded()
            present(alert, animated: true)
        }
    }


    // MARK: Actions

    @IBAction func aboutButtonPressed() {

        let version: String? = Bundle.main.infoDictionary![Constants.Misc.appVersion] as? String
        let infoAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let version = version {
            infoAlert.message = "\(Constants.Misc.version) \(version)"
            infoAlert.title = Constants.Misc.appName
        }

        infoAlert.modalPresentationStyle = .popover

        let cancelAction = UIAlertAction(title: Constants.Misc.cancel, style: .cancel) { _ in
            self.dismiss(animated: true, completion: {
            })
        }

        let shareAppAction = UIAlertAction(title: Constants.Misc.shareTitleMessage, style: .default) { _ in
            self.shareApp()
        }

        let mailAction = UIAlertAction(title: Constants.Misc.sendFeedback, style: .default) { _ in
            self.launchEmail()
        }

        let reviewAction = UIAlertAction(title: Constants.Misc.leaveReview, style: .default) { _ in
            self.requestReviewManually()
        }

        let showAppsAction = UIAlertAction(title: Constants.Misc.showAppsButtonTitle, style: .default) { _ in
            self.showApps()
        }


        let changeAppIconAction = UIAlertAction(title: Constants.Misc.customAppIconTitle, style: .default) { _ in
            self.changeIconPressed()
        }

        for action in [mailAction, reviewAction, shareAppAction, changeAppIconAction,
                       showAppsAction, cancelAction] {
            infoAlert.addAction(action)
        }

        if let presenter = infoAlert.popoverPresentationController {
            presenter.barButtonItem = aboutButton
        }

        present(infoAlert, animated: true)

    }


    func changeIconPressed() {
        let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: Constants.StoryboardID.settingsVC)
        self.present(controller, animated: true)
    }


    func shareApp() {
        let message = Constants.Misc.shareBodyMessage
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = aboutButton
        activityController.completionWithItemsHandler = { (_, _: Bool, _: [Any]?, error: Error?) in
            guard error == nil else {
                let alert = self.createAlert(alertReasonParam: AlertReason.unknown)
                alert.view.layoutIfNeeded()
                self.present(alert, animated: true)
                return
            }
        }
        present(activityController, animated: true)
    }


}


extension MenuViewController: MFMailComposeViewControllerDelegate {


    // MARK: Helpers

    func launchEmail() {

        var emailTitle = Constants.Misc.appName
        if let version = Bundle.main.infoDictionary![Constants.Misc.appVersion] {
            emailTitle += " \(version)"
        }
        let messageBody = Constants.Misc.emailSample
        let toRecipents = [Constants.Misc.emailAddress]
        let mailComposer: MFMailComposeViewController = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailTitle)
        mailComposer.setMessageBody(messageBody, isHTML: false)
        mailComposer.setToRecipients(toRecipents)

        self.present(mailComposer, animated: true, completion: nil)
    }


    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        var alert = UIAlertController()

        dismiss(animated: true, completion: {
            switch result {
            case MFMailComposeResult.failed:
                alert = self.createAlert(alertReasonParam: AlertReason.messageFailed)
            case MFMailComposeResult.saved:
                alert = self.createAlert(alertReasonParam: AlertReason.messageSaved)
            case MFMailComposeResult.sent:
                alert = self.createAlert(alertReasonParam: AlertReason.messageSent)
            default:
                break
            }

            if alert.title != nil {
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
        guard let writeReviewURL = URL(string: Constants.Misc.reviewLink)
            else {
                fatalError("expected valid URL")

        }
        UIApplication.shared.open(writeReviewURL,
                                  options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]),
                                  completionHandler: nil)
    }
}


// Helper function inserted by Swift 4.2 migrator.

private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(
    _ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in
        (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
