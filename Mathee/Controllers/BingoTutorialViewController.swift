//
//  BingoTutorialViewController.swift
//  Mathee
//
//  Created by Daniel Springer on 10/31/22.
//  Copyright © 2023 Daniel Springer. All rights reserved.
//

import UIKit

class BingoTutorialViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var tutorialTextView: UITextView!


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tutorialTextView.text = """
        - Tap "\(Const.shabbosGameName)" if the shown number is a multiple of your chosen \
        base (currently: \(ud.integer(forKey: Const.shabbosBase))), otherwise, tap "Nope".

        - The goal is to reach \(Const.pointsGoal) points in \(Int(Const.timerSeconds)) \
        seconds (1 correct guess = \(Const.pointsPerTap) points, 1 correct \
        \(Const.shabbosGameName) guess = double points!)

        - Can you complete all \(Const.bingoLevelsCount) levels?

        (Tap "Help" on the top right of "\(Const.shabbosGameName)" to see this message \
        again later)
        """
    }


    // MARK: Helpers

    @IBAction func hidePressed(_ sender: Any) {
        dismiss(animated: true)
    }

}
