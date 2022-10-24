//
//  ShabbosLevelsViewController.swift
//  Matemagica
//
//  Created by dani on 10/16/22.
//  Copyright © 2022 Dani Springer. All rights reserved.
//

import UIKit

class ShabbosLevelsViewController: UITableViewController {

    // MARK: Outlets

    @IBOutlet var helpButton: UIButton!


    // MARK: Properties

    var myThemeColor: UIColor!
    var myTitle: String!


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if CommandLine.arguments.contains("--matemagicaScreenshots") {
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


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if ud.bool(forKey: Const.firstTimePlayingShabbos) {
            showHelp()
        }

        restoreIfAny()
    }


    // MARK: Helpers

    func restoreIfAny() {
        guard let restoredLevelIndex: Int = ud.value(
                forKey: Const.levelIndexKey) as? Int else {
            return
        }
        ud.removeObject(forKey: Const.levelIndexKey)

        if restoredLevelIndex >= Const.shabbosLevels.count {
            let alert = createAlert(alertReasonParam: .lastLevelCompleted, style: .alert)
            present(alert, animated: true)
            return
        }
        showLevelFor(IndexPath(row: restoredLevelIndex, section: 0))
    }


    @objc func showHelp() {
        let alert = createAlert(alertReasonParam: .shabbosInstructions, style: .actionSheet)
        alert.popoverPresentationController?.sourceView = helpButton
        present(alert, animated: true)
        ud.set(false, forKey: Const.firstTimePlayingShabbos)
    }


    // MARK: Delegates

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.shabbosLevels.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: Const.shabbosLevelCell) as! LevelTableViewCell
        cell.selectionStyle = .none
        cell.levelNumberLabel.text = "⭐️ Level \(indexPath.row + 1)"
        let myLevel = Const.shabbosLevels[indexPath.row]
        cell.timerDurationLabel.text = "⏱️ Timer: \(Int(myLevel.timerSeconds)) seconds"
        cell.numbersRangeLabel.text = """
        🧮 Numbers between \(myLevel.numberRange.first!) and \(myLevel.numberRange.last!)
        """

        cell.fakeBackgroundView.backgroundColor = myThemeColor
        cell.fakeBackgroundView.layer.cornerRadius = 8

        return cell
    }


    func showLevelFor(_ indexPath: IndexPath) {
        let shabbosVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: Const.shabbosViewController) as! ShabbosViewController
        shabbosVC.levelNumberIndex = indexPath.row
        let myLevel = Const.shabbosLevels[indexPath.row]
        shabbosVC.timeInSeconds = myLevel.timerSeconds
        shabbosVC.numbersRange = myLevel.numberRange
        shabbosVC.myThemeColor = myThemeColor
        self.navigationController!.pushViewController(shabbosVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showLevelFor(indexPath)
    }

}
