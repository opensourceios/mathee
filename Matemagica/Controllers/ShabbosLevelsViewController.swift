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


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setThemeColorTo(myThemeColor: myThemeColor)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true

        self.title = "Choose a level"
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.shabbosLevels.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: Const.shabbosLevelCell) as! LevelTableViewCell
        cell.selectionStyle = .none
        cell.levelNumberLabel.text = "⭐️ Level #\(indexPath.row + 1)"
        let myLevel = Const.shabbosLevels[indexPath.row]
        cell.timerDurationLabel.text = "⏱️ Time to complete: \(Int(myLevel.timerSeconds)) seconds"
        cell.numbersRangeLabel.text = """
        🧮 Numbers from \(myLevel.numberRange.first!) to \(myLevel.numberRange.last!)
        """

        cell.fakeBackgroundView.backgroundColor = myThemeColor
        cell.fakeBackgroundView.layer.cornerRadius = 8

//        cell.accessoryType = checkmark for done levels? maybe use emojis instead

        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


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
