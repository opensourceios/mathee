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

    @IBOutlet weak var shabbosButton: UIButton!
    @IBOutlet weak var notShabbosButton: UIButton!
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!


    // MARK: Properties

    var currentNumber = 0
    var myTitle: String!
    var myThemeColor: UIColor!
    var points = 0


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = myTitle

        numberLabel.text = "\(currentNumber)"

        setThemeColorTo(myThemeColor: myThemeColor)
        showNextNumber()
        timerLabel.isUserInteractionEnabled = true
        let myGR = UITapGestureRecognizer(target: self, action: #selector(timerTapped))
        timerLabel.addGestureRecognizer(myGR)
        toggleUI(enable: false)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for button: UIButton in [shabbosButton, notShabbosButton] {
            button.configuration!.background.cornerRadius = 0
        }
    }


    // MARK: Helpers


    @objc func timerTapped() {

        toggleUI(enable: true)

        var runsLeft = 30

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runsLeft -= 1
            self.timerLabel.text = "\(runsLeft) seconds left"
            if runsLeft == 0 {
                timer.invalidate()
                self.toggleUI(enable: false)
                self.gameOver()
            }
        }
    }


    @objc func fireTimer() {
        print("Timer fired!")
    }

    @IBAction func selectionTapped(_ sender: UIButton) {
        let isShabbos = currentNumber % 7 == 0

        // shabbos tag is 0
        if isShabbos && sender.tag == 0 {
            print("correct! it's shabbos")
            addPoint()
        } else if !isShabbos && sender.tag == 1 {
            print("Correct! it's NOT shabbos")
            addPoint()
        } else if isShabbos && sender.tag == 1 {
            print("OOPS!! it IS shabbos")
        } else if !isShabbos && sender.tag == 0 {
            print("OOPS!! it's NOT shabbos")
        }

        showNextNumber()

    }


    func gameOver() {
        timerLabel.text = ""
        numberLabel.text = """
        Game Over
        You reached \(currentNumber)
        You scored \(points) points!
        """
    }


    func showNextNumber() {
        toggleUI(enable: false)
        currentNumber += 1
        numberLabel.text = "\(currentNumber)"
        toggleUI(enable: true)
    }


    func addPoint() {
        points+=1
        pointsLabel.text = "\(points) points"
    }


    func toggleUI(enable: Bool) {
        for button: UIButton in [shabbosButton, notShabbosButton, tutorialButton] {
            button.isEnabled = enable
        }
    }


}
