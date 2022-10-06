//
//  ShabbosViewController.swift
//  Matemagica
//
//  Created by dani on 10/6/22.
//  Copyright © 2022 Dani Springer. All rights reserved.
//

import UIKit

class ShabbosViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var livesLeftLabel: UILabel!

    @IBOutlet weak var shabbosButton: UIButton!
    @IBOutlet weak var notShabbosButton: UIButton!
    @IBOutlet weak var tutorialButton: UIButton!


    // MARK: Properties

    var currentNumber = 0
    var myTitle: String!
    var myThemeColor: UIColor!
    var livesLeft = 5


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = myTitle

        numberLabel.text = "\(currentNumber)"
        livesLeftLabel.text = "Lives left: " + String(repeating: "❤️", count: livesLeft)

        setThemeColorTo(myThemeColor: myThemeColor)

        showNextNumber()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for button: UIButton in [shabbosButton, notShabbosButton] {
            button.configuration!.background.cornerRadius = 0
        }
    }


    // MARK: Helpers

    @IBAction func selectionTapped(_ sender: UIButton) {

    }


    func showNextNumber() {
        toggleUI(enable: false)
        currentNumber += 1
        numberLabel.text = "\(currentNumber)"
        toggleUI(enable: true)
    }


    func toggleUI(enable: Bool) {
        for button: UIButton in [shabbosButton, notShabbosButton, tutorialButton] {
            button.isEnabled = enable
        }
    }


}
