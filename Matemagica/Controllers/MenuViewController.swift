//
//  MenuViewController.swift
//  Math Magic
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit
import MessageUI


class MenuViewController: UIViewController,
                          UITableViewDataSource,
                          UITableViewDelegate {


    // MARK: Outlets

    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var aboutButton: UIBarButtonItem!


    // MARK: Properties

    let myImageSource = ["plus.slash.minus",
                         "book",
                         "arrow.up.arrow.down",
                         "wand.and.stars"]

    let tintColorsArray: [UIColor] = [
        .systemPurple,
        .systemOrange,
        .systemBlue,
        .systemRed
    ]

    let menuCell = "MenuCell"

    let myThemeColor: UIColor = .systemBlue


    // MARK: Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.prefersLargeTitles = true
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
        let shareApp = UIAction(title: Const.Misc.shareTitleMessage, image: UIImage(systemName: "heart"),
                                state: .off) { _ in
            self.shareApp()
        }
        let contact = UIAction(title: Const.Misc.sendFeedback, image: UIImage(systemName: "envelope"),
                               state: .off) { _ in
            self.launchEmail()
        }
        let review = UIAction(title: Const.Misc.leaveReview,
                              image: UIImage(systemName: "hand.thumbsup"), state: .off) { _ in
            self.requestReview()
        }
        let moreApps = UIAction(title: Const.Misc.showAppsButtonTitle, image: UIImage(systemName: "apps.iphone"),
                                state: .off) { _ in
            self.showApps()
        }


        let version: String? = Bundle.main.infoDictionary![Const.Misc.appVersion] as? String
        var myTitle = Const.Misc.appName
        if let safeVersion = version {
            myTitle += " \(Const.Misc.version) \(safeVersion)"
        }

        let infoMenu = UIMenu(title: myTitle, image: nil, identifier: .none, options: .displayInline,
                              children: [contact, review, shareApp, moreApps])
        return infoMenu
    }


    // MARK: Show Apps

    func showApps() {

        let myURL = URL(string: Const.Misc.appsLink)

        guard let safeURL = myURL else {
            let alert = createAlert(alertReasonParam: .unknown)
            present(alert, animated: true)
            return
        }

        UIApplication.shared.open(safeURL, options: [:], completionHandler: nil)

    }


    // MARK: TableView Delegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.Misc.myDataSourceHomeMenu.count
    }


//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let sectionText = UILabel()
//        sectionText.frame = CGRect.init(x: 16, y: 16,
//                                        width: tableView.frame.width - 16,
//                                        height: 0)
//        sectionText.text = """
//        Select a Game To Get Started
//        """.uppercased()
//        sectionText.font = UIFont(name: "Rockwell-Bold", size: 24)
//        sectionText.textColor = UIColor.label
//        sectionText.lineBreakMode = .byWordWrapping
//        sectionText.numberOfLines = 0
//        sectionText.sizeToFit()
//
//        return sectionText
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 60 // my custom height
//    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: menuCell) as! MainMenuTableViewCell
        cell.myLabel.text = Const.Misc.myDataSourceHomeMenu[(indexPath as NSIndexPath).row]
        let aConfig = UIImage.SymbolConfiguration(weight: .bold)
        let aImage = UIImage(systemName: myImageSource[(indexPath as NSIndexPath).row], withConfiguration: aConfig)
        cell.newImageView.image = aImage
        cell.newImageView.tintColor = .white
        cell.imageViewContainer.backgroundColor = tintColorsArray[(indexPath as NSIndexPath).row]
        cell.imageViewContainer.layer.cornerRadius = 6
        cell.accessoryType = .disclosureIndicator

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: Const.StoryboardID.main, bundle: nil)

        let cell = tableView.cellForRow(at: indexPath) as? MainMenuTableViewCell

        switch cell?.myLabel?.text {
            case Const.Misc.myDataSourceHomeMenu[0]:
                let controller = storyboard.instantiateViewController(
                    withIdentifier: Const.StoryboardID.formulaVC) as? FormulaViewController
                if let toPresent = controller {
                    controller?.myTitle = Const.Misc.myDataSourceHomeMenu[indexPath.row]
                    self.navigationController?.pushViewController(toPresent, animated: true)
                }
            case Const.Misc.myDataSourceHomeMenu[1]:
                let controller = storyboard.instantiateViewController(
                    withIdentifier: Const.StoryboardID.bookVC) as? BookViewController
                if let toPresent = controller {
                    controller?.myTitle = Const.Misc.myDataSourceHomeMenu[indexPath.row]
                    self.navigationController?.pushViewController(toPresent, animated: true)
                }
            case Const.Misc.myDataSourceHomeMenu[2]:
                let controller = storyboard.instantiateViewController(
                    withIdentifier: Const.StoryboardID.higherVC) as? HigherLowerViewController
                if let toPresent = controller {
                    controller?.myTitle = Const.Misc.myDataSourceHomeMenu[indexPath.row]
                    self.navigationController?.pushViewController(toPresent, animated: true)
                }
            case Const.Misc.myDataSourceHomeMenu[3]:
                let controller = storyboard.instantiateViewController(
                    withIdentifier: Const.StoryboardID.magicVC) as? MagicViewController
                if let toPresent = controller {
                    controller?.myTitle = Const.Misc.myDataSourceHomeMenu[indexPath.row]
                    self.navigationController?.pushViewController(toPresent, animated: true)
                }
            default:
                let alert = createAlert(alertReasonParam: AlertReason.unknown)
                alert.view.layoutIfNeeded()
                present(alert, animated: true)
        }
    }


    // MARK: Actions

    func shareApp() {
        let message = Const.Misc.shareBodyMessage
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
        guard MFMailComposeViewController.canSendMail() else {
            let alert = createAlert(alertReasonParam: .unknown)
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }

            return
        }
        var emailTitle = Const.Misc.appName
        if let version = Bundle.main.infoDictionary![Const.Misc.appVersion] {
            emailTitle += " \(version)"
        }
        let messageBody = Const.Misc.emailSample
        let toRecipents = [Const.Misc.emailAddress]
        let mailComposer: MFMailComposeViewController = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailTitle)
        mailComposer.setMessageBody(messageBody, isHTML: false)
        mailComposer.setToRecipients(toRecipents)
        DispatchQueue.main.async {
            self.present(mailComposer, animated: true, completion: nil)
        }
    }


    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }


}


extension MenuViewController {


    func requestReview() {
        // Note: Replace the XXXXXXXXXX below with the App Store ID for your app
        //       You can find the App Store ID in your app's product URL
        guard let writeReviewURL = URL(string: Const.Misc.reviewLink)
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
