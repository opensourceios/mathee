//
//  ShabbosLevelsViewController.swift
//  Matemagica
//
//  Created by dani on 10/16/22.
//  Copyright © 2022 Dani Springer. All rights reserved.
//

import UIKit

class ShabbosLevelsViewController: UITableViewController {

    var myThemeColor: UIColor!
    var myTitle: String!


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)
    }


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

//        cell.accessoryType = checkmark for done levels? maybe use emojis instead

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let shabbosVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
            withIdentifier: Const.shabbosViewController) as! ShabbosViewController
        shabbosVC.levelNumberReal = indexPath.row
        let myLevel = Const.shabbosLevels[indexPath.row]
        shabbosVC.timeInSeconds = myLevel.timerSeconds
        shabbosVC.numbersRange = myLevel.numberRange
        shabbosVC.myThemeColor = myThemeColor
        self.navigationController!.pushViewController(shabbosVC, animated: true)
    }

}
