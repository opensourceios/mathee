//
//  ShabbosLevelsViewController.swift
//  Matemagica
//
//  Created by dani on 10/16/22.
//  Copyright © 2022 Dani Springer. All rights reserved.
//

import UIKit

class ShabbosLevelsViewController: UIViewController, UITableViewDelegate,
                                   UITableViewDataSource {

    var myThemeColor: UIColor!


    override func viewDidLoad() {
        super.viewDidLoad()

        setThemeColorTo(myThemeColor: myThemeColor)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.shabbosLevels.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: Const.shabbosLevelCell) as! LevelTableViewCell
        cell.levelNumberLabel.text = "⭐️ Level #\(indexPath.row + 1)"
        let myLevel = Const.shabbosLevels[indexPath.row]
        cell.timerDurationLabel.text = "⏱️ Time to complete: \(myLevel.timerSeconds) seconds"
        cell.numbersRangeLabel.text = "🧮 Numbers from \(myLevel.numberRange.startIndex) to \(myLevel.numberRange.endIndex)"

        for label: UILabel in [cell.levelNumberLabel, cell.timerDurationLabel,
                      cell.numbersRangeLabel] {
            label.textColor = .white
        }

        let highestAllowed = UserDefaults.standard.integer(
            forKey: Const.UserDef.highestCompletedLevelShabbos) + 1
        // +1 so user can try next level

        if indexPath.row > highestAllowed {
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = .systemGray
        } else {
            cell.backgroundColor = myThemeColor
        }

//        cell.accessoryType = checkmark for done levels? maybe use emojis instead
        
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shabbosVC = (presentingViewController as! ShabbosViewController)
        shabbosVC.levelNumberReal = indexPath.row
        let myLevel = Const.shabbosLevels[indexPath.row]
        shabbosVC.timeInSeconds = myLevel.timerSeconds
        shabbosVC.numbersRange = myLevel.numberRange
        _ = shabbosVC.view // so viewdidload is called
        dismiss(animated: true)
    }
    
}
