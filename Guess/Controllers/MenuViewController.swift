//
//  MenuViewController.swift
//  Guess
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2019 Daniel Springer. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit
import AVKit


class MenuViewController: UIViewController,
                          UITableViewDataSource,
                          UITableViewDelegate,
                          SKStoreProductViewControllerDelegate {


    // MARK: Outlets

    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet weak var soundButton: UIBarButtonItem!
    @IBOutlet weak var themeButton: UIBarButtonItem!


    // MARK: Properties

    var fullHeight: CGFloat!
    let fontSetter: CGFloat = 10

    enum CellsDataEnum: String, CaseIterable {
        case dtdt = "➗"
        case pages = "📗"
        case queens = "👸"
        case higher = "👆"
        case magic = "🕘"
    }

    let menuCell = "MenuCell"


    // MARK: Life Cycle


    override func viewDidLoad() {
        super.viewDidLoad()

        let soundEnabled = UserDefaults.standard.bool(forKey: Constants.UserDef.soundEnabled)
        soundButton.title = soundEnabled ? "🔈" : "🔇"

        myTableView.separatorColor = UIColor.clear

        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        if let selectedRow = myTableView.indexPathForSelectedRow {
            myTableView.deselectRow(at: selectedRow, animated: true)
        }

        updateTheme()


        for state: UIControl.State in [.disabled, .focused, .highlighted, .normal] {
            for button: UIBarButtonItem in [soundButton, themeButton, aboutButton] {
                button.setTitleTextAttributes(
                    [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Misc.fontSize)],
                                              for: state)
            }
        }

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 1)
        ]

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


    // TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellsDataEnum.allCases.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: menuCell)!

        cell.textLabel?.text = CellsDataEnum.allCases[(indexPath as NSIndexPath).row].rawValue

        cell.textLabel?.font = UIFont.systemFont(ofSize: myTableView.frame.height / fontSetter)

        cell.selectionStyle = .none

        let darkMode = UserDefaults.standard.bool(forKey: Constants.UserDef.darkModeEnabled)

        cell.backgroundColor = darkMode ? .black : .white

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: Constants.StoryboardID.main, bundle: nil)

        let cell = tableView.cellForRow(at: indexPath)

        switch cell?.textLabel?.text {
        case CellsDataEnum.pages.rawValue:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.pagesVC) as? PagesViewController
            if let toPresent = controller {
                self.navigationController?.pushViewController(toPresent, animated: true)
                AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
            }
        case CellsDataEnum.dtdt.rawValue:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.dtdtVC) as? DTDTViewController
            if let toPresent = controller {
                self.navigationController?.pushViewController(toPresent, animated: true)
                AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
            }
        case CellsDataEnum.higher.rawValue:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.higherVC) as? HigherLowerViewController
            if let toPresent = controller {
                self.navigationController?.pushViewController(toPresent, animated: true)
                AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
            }
        case CellsDataEnum.magic.rawValue:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.magicVC) as? MagicViewController
            if let toPresent = controller {
                self.navigationController?.pushViewController(toPresent, animated: true)
                AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
            }
        case CellsDataEnum.queens.rawValue:
            let controller = storyboard.instantiateViewController(
                withIdentifier: Constants.StoryboardID.queensVC) as? QueensViewController
            if let toPresent = controller {
                self.navigationController?.pushViewController(toPresent, animated: true)
                AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
            }
        default:
            print("An error has occured!")
            let alert = createAlert(alertReasonParam: AlertReason.unknown)
            alert.view.layoutIfNeeded()
            present(alert, animated: true)
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        updateRowHeight(indexPath: indexPath)
        return myTableView.frame.height / CGFloat(CellsDataEnum.allCases.count)
    }


    func updateRowHeight(indexPath: IndexPath) {
        myTableView.cellForRow(at: indexPath)?.textLabel?.font = UIFont.systemFont(
            ofSize: myTableView.frame.height / fontSetter)
    }


    // MARK: Actions

    @IBAction func aboutButtonPressed() {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)

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

        let shareAppAction = UIAlertAction(title: Constants.Misc.shareApp, style: .default) { _ in
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

        for action in [mailAction, reviewAction, shareAppAction,
                       showAppsAction, cancelAction] {
            infoAlert.addAction(action)
        }

        if let presenter = infoAlert.popoverPresentationController {
            presenter.barButtonItem = aboutButton
        }

        present(infoAlert, animated: true)

    }


    @IBAction func soundButtonPressed(_ sender: Any) {
        soundToggled()
    }


    func soundToggled() {
        let oldValue = UserDefaults.standard.bool(forKey: Constants.UserDef.soundEnabled)
        UserDefaults.standard.set(!oldValue, forKey: Constants.UserDef.soundEnabled)
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
        soundButton.title = !oldValue ? "🔈" : "🔇"
    }


    @IBAction func darkModeButtonPressed(_ sender: Any) {
        darkModeToggled()
    }


    func darkModeToggled() {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
        let oldValue = UserDefaults.standard.bool(forKey: Constants.UserDef.darkModeEnabled)
        UserDefaults.standard.set(!oldValue, forKey: Constants.UserDef.darkModeEnabled)
        updateTheme()
    }


    func updateTheme() {
        let darkMode = UserDefaults.standard.bool(forKey: Constants.UserDef.darkModeEnabled)
        view.backgroundColor = darkMode ? .black : .white
        myTableView.backgroundColor = darkMode ? .black : .white
        myTableView.tintColor = .red
        themeButton.title = darkMode ? "☀️" : "🌙"
        myTableView.reloadData()

    }


    func shareApp() {
        let message = """
        Amaze your friends when you guess any number they think of, by secretly using this app! \
        Check it out: https://itunes.apple.com/app/id1406084758
        """
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = aboutButton
        activityController.completionWithItemsHandler = {
            (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
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
                fatalError("Expected a valid URL")

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
