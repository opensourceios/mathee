//
//  MenuViewController.swift
//  Mathee
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2023 Daniel Springer. All rights reserved.
//

import UIKit
import MessageUI


class MenuViewController: UIViewController, UITableViewDataSource,
                          UITableViewDelegate {


    // MARK: Outlets

    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var aboutButton: UIBarButtonItem!


    // MARK: Properties

    let menuCell = "MenuCell"

    let myThemeColor: UIColor = .systemBlue


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if CommandLine.arguments.contains("--matheeScreenshots") {
            // We are in testing mode, make arrangements if needed
            UIView.setAnimationsEnabled(false)
        }

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        navigationItem.largeTitleDisplayMode = .always
        navigationController!.navigationBar.prefersLargeTitles = true
        setThemeColorTo(myThemeColor: myThemeColor)

        if let selectedRow = myTableView.indexPathForSelectedRow {
            myTableView.deselectRow(at: selectedRow, animated: true)
        }

        myTableView.rowHeight = UITableView.automaticDimension

        aboutButton.menu = infoMenu()
        aboutButton.image = UIImage(systemName: "ellipsis.circle")

        myTableView.reloadData()
    }


    // MARK: Create menu

    func infoMenu() -> UIMenu {
        let shareApp = UIAction(title: Const.shareTitleMessage,
                                image: UIImage(systemName: "heart"),
                                state: .off) { _ in
            self.shareApp()
        }
        let review = UIAction(title: Const.leaveReview,
                              image: UIImage(systemName: "hand.thumbsup"), state: .off) { _ in
            self.requestReview()
        }
        let moreApps = UIAction(title: Const.showAppsButtonTitle,
                                image: UIImage(systemName: "apps.iphone"),
                                state: .off) { _ in
            self.showApps()
        }

        let emailAction = UIAction(title: Const.contact,
                                   image: UIImage(systemName: "envelope.badge"),
                                   state: .off) { _ in
            self.sendEmailTapped()
        }


        let version: String? = Bundle.main.infoDictionary![Const.appVersion] as? String
        var myTitle = Const.appName
        if let safeVersion = version {
            myTitle += " \(Const.version) \(safeVersion)"
        }

        let infoMenu = UIMenu(title: myTitle, image: nil, identifier: .none,
                              options: .displayInline,
                              children: [emailAction, review, shareApp, moreApps])
        return infoMenu
    }


    // MARK: Show Apps

    func showApps() {

        let myURL = URL(string: Const.appsLink)
        guard let safeURL = myURL else {
            let alert = createAlert(alertReasonParam: .unknown)
            present(alert, animated: true)
            return
        }
        UIApplication.shared.open(safeURL, options: [:], completionHandler: nil)
    }


    // MARK: TableView Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Const.dataSourceHome.count
    }


    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 0
    //    }


    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: menuCell)
        as! MainMenuTableViewCell
        cell.myLabel.text = Const.dataSourceHome[indexPath.row]["title"] as? String
        let aConfig = UIImage.SymbolConfiguration(weight: .medium)
        let aImage = UIImage(
            systemName: Const.dataSourceHome[indexPath.row]["icon"] as! String,
            withConfiguration: aConfig)
        cell.newImageView.image = aImage
        cell.newImageView.tintColor = .white
        cell.imageViewContainer
            .backgroundColor = Const.dataSourceHome[indexPath.row]["color"] as? UIColor
        cell.imageViewContainer.layer.cornerRadius = 8
        cell.accessoryType = .disclosureIndicator

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let cell = tableView.cellForRow(at: indexPath) as! MainMenuTableViewCell

        switch cell.myLabel!.text {
            case "Spot It":
                let controller = storyboard.instantiateViewController(
                    withIdentifier: "BookViewController") as! BookViewController
                controller.myTitle = cell.myLabel!.text
                controller
                    .myThemeColor = Const.dataSourceHome[indexPath.row]["color"] as? UIColor
                self.navigationController!.pushViewController(controller, animated: true)
            case "Guess It":
                let controller = storyboard.instantiateViewController(
                    withIdentifier: "FormulaViewController") as! FormulaViewController
                controller.myTitle = cell.myLabel!.text
                controller
                    .myThemeColor = Const.dataSourceHome[indexPath.row]["color"] as? UIColor
                self.navigationController!.pushViewController(controller, animated: true)
            case "Mystical Nine":
                let controller = storyboard.instantiateViewController(
                    withIdentifier: "MagicViewController") as! MagicViewController
                controller.myTitle = cell.myLabel!.text
                controller
                    .myThemeColor = Const.dataSourceHome[indexPath.row]["color"] as? UIColor
                self.navigationController!.pushViewController(controller, animated: true)
            case "Lower or Higher":
                let controller = storyboard.instantiateViewController(
                    withIdentifier: "HigherLowerViewController") as! HigherLowerViewController
                controller.myTitle = cell.myLabel!.text
                controller
                    .myThemeColor = Const.dataSourceHome[indexPath.row]["color"] as? UIColor
                self.navigationController!.pushViewController(controller, animated: true)
            case Const.shabbosGameName:
                let controller = storyboard.instantiateViewController(
                    withIdentifier: Const.BingoLevelsViewController)
                as! BingoLevelsViewController
                controller.myTitle = cell.myLabel!.text
                controller
                    .myThemeColor = Const.dataSourceHome[indexPath.row]["color"] as? UIColor
                self.navigationController!.pushViewController(controller, animated: true)
            default:
                fatalError()
        }
    }


    // MARK: Actions

    func shareApp() {
        let message = Const.appsLink
        let activityController = UIActivityViewController(activityItems: [message],
                                                          applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = aboutButton
        activityController
            .completionWithItemsHandler = { (_, _: Bool, _: [Any]?, error: Error?) in
                guard error == nil else {
                    let alert = self.createAlert(alertReasonParam: .unknown)
                    alert.view.layoutIfNeeded()
                    self.present(alert, animated: true)
                    return
                }
            }
        DispatchQueue.main.async {
            self.present(activityController, animated: true)
        }

    }


}


extension MenuViewController: MFMailComposeViewControllerDelegate {

    func sendEmailTapped() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }


    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the
        // --mailComposeDelegate-- property, NOT the --delegate-- property

        mailComposerVC.setToRecipients([Const.emailString])
        let version: String? = Bundle.main.infoDictionary![Const.appVersion] as? String
        var myTitle = Const.appName
        if let safeVersion = version {
            myTitle += " \(Const.version) \(safeVersion)"
        }
        mailComposerVC.setSubject(myTitle)
        mailComposerVC.setMessageBody("Hi, I have a question about your app.", isHTML: false)

        return mailComposerVC
    }


    func showSendMailErrorAlert() {
        let alert = createAlert(alertReasonParam: .emailError)
        present(alert, animated: true)
    }


    // MARK: MFMailComposeViewControllerDelegate

    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}


extension MenuViewController {


    func requestReview() {
        // Note: Replace the XXXXXXXXXX below with the App Store ID for your app
        //       You can find the App Store ID in your app's product URL
        guard let writeReviewURL = URL(string: Const.reviewLink)
        else {
            fatalError("expected valid URL")

        }
        UIApplication.shared.open(
            writeReviewURL,
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
