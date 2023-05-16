//
//  BingoLevelsViewController.swift
//  Mathee
//
//  Created by Daniel Springer on 10/16/22.
//  Copyright © 2023 Daniel Springer. All rights reserved.
//

import UIKit

class BingoLevelsViewController: UITableViewController, RemoteTableReloadDelegate {


    // MARK: Outlets

    @IBOutlet var helpButton: UIButton!


    // MARK: Properties

    var myThemeColor: UIColor!
    var myTitle: String!
    var completedLevelsArray: [Int]!


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if CommandLine.arguments.contains("--matheeScreenshots") {
            // We are in testing mode, make arrangements if needed
            UIView.setAnimationsEnabled(false)
        }

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)

        helpButton.addTarget(self, action: #selector(showHelp),
                             for: .touchUpInside)

        helpButton.setTitleNew("Help")
        let helpItem = UIBarButtonItem(customView: helpButton)

        navigationItem.rightBarButtonItem = helpItem
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let completedLevelsString: String = ud.string(
            forKey: Const.completedBingoLevels) ?? ""
        let completedLevelsArrayTemp = completedLevelsString.split(separator: ",")
        completedLevelsArray = completedLevelsArrayTemp.map { Int($0)! }
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        let shouldShowHelp = restoreAndShouldShowHelp()
        guard shouldShowHelp else {
            return
        }

        if !ud.bool(forKey: Const.userSawBingoTutorial) {
            showHelp()
            ud.set(true, forKey: Const.userSawBingoTutorial)
        }

    }


    // MARK: Helpers

    func restoreAndShouldShowHelp() -> Bool {
        guard let restoredLevelIndex: Int = ud.value(
            forKey: Const.levelIndexKey) as? Int else {
            return true
        }
        ud.removeObject(forKey: Const.levelIndexKey)

        if restoredLevelIndex >= Const.bingoLevelsCount {
            let alert = createAlert(alertReasonParam: .lastLevelCompleted)
            present(alert, animated: true)
            return false
        }
        showLevelFor(IndexPath(row: restoredLevelIndex, section: 0))
        return false
    }


    @objc func showHelp() {

        let tutorialVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: Const.bingoTutorialViewController)
        as! BingoTutorialViewController

        present(tutorialVC, animated: true)
    }


    // MARK: Delegates

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return Const.bingoLevelsCount
    }


    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let isLevelCompleted = completedLevelsArray.contains(indexPath.row)

        let cell = tableView.dequeueReusableCell(withIdentifier: Const.bingoLevelCell)
        as! LevelTableViewCell
        cell.selectionStyle = .none
        cell.levelNumberLabel.text = "⭐️ Level \(indexPath.row + 1)"
        if isLevelCompleted {
            cell.fakeBackgroundView.backgroundColor = .systemGreen
        } else {
            cell.fakeBackgroundView.backgroundColor = myThemeColor
        }
        let levelMaxNumber = Const.rangeAddedPerLevel * (indexPath.row + 1)
        cell.numbersRangeLabel.text = """
        Numbers 1-\(levelMaxNumber)
        """

        cell.fakeBackgroundView.layer.cornerRadius = 8

        return cell
    }


    func showLevelFor(_ indexPath: IndexPath) {
        let bingoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: Const.bingoViewController) as! BingoViewController
        bingoVC.levelNumberIndex = indexPath.row
        let levelMaxNumber = Const.rangeAddedPerLevel * (indexPath.row + 1)
        bingoVC.numbersRange = 1...levelMaxNumber
        bingoVC.myThemeColor = myThemeColor
        bingoVC.remoteDelegate = tableView.delegate as? any RemoteTableReloadDelegate
        self.navigationController!.pushViewController(bingoVC, animated: true)
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showLevelFor(indexPath)
    }


    // MARK: RemoteTableReloadDelegate

    func reload() {
        tableView.reloadData()
    }

}


protocol RemoteTableReloadDelegate: AnyObject {
    func reload()
}
