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
    @IBOutlet weak var timerProgress: UIProgressView!


    // MARK: Properties

    var currentNumber = 0
    var myTitle: String!
    var myThemeColor: UIColor!
    var myGR: UIGestureRecognizer!


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = myTitle

        numberLabel.text = " "

        setThemeColorTo(myThemeColor: myThemeColor)
        timerLabel.isUserInteractionEnabled = true
        myGR = UITapGestureRecognizer(target: self, action: #selector(timerTapped))
        timerLabel.addGestureRecognizer(myGR)
        timerProgress.progress = 0
        toggleUI(enable: false)

    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        shabbosButton.doGlowAnimation(withColor: myThemeColor)
        //        notShabbosButton.doGlowAnimation(withColor: myThemeColor)
    }


    // MARK: Helpers

    @objc func timerTapped() {
        timerLabel.isUserInteractionEnabled = false
        timerLabel.removeGestureRecognizer(myGR)
        self.timerProgress.setProgress(1, animated: true)
        toggleUI(enable: true)

        let totalRuns: Float = 30
        var runsLeft: Float = 30
        timerLabel.text = "00:\(Int(runsLeft))"
        showNextNumber()

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            runsLeft -= 1
            self.timerProgress.setProgress(runsLeft/totalRuns, animated: true)
            let preStr = Int(runsLeft) < 10 ? "00:0" : "00:"
            self.timerLabel.text = "\(preStr)\(Int(runsLeft))"
            if runsLeft == 0 {
                self.toggleUI(enable: false)
                timer.invalidate()
                self.gameOver()
            }
        }
    }


    @objc func fireTimer() {
        print("Timer fired")
    }


    @IBAction func selectionTapped(_ sender: UIButton) {
        let isShabbos = currentNumber % 7 == 0

        // shabbos tag is 0
        if isShabbos && sender.tag == 0 {
            // TODO: show popup/sound/animation with "reason"
            // TODO: add random option for lvl2
            // TODO: animate label changes?
            //print("correct! it's shabbos")
            showNextNumber()
        } else if !isShabbos && sender.tag == 1 {
            //print("Correct! it's NOT shabbos")
            showNextNumber()
        } else if isShabbos && sender.tag == 1 {
            //print("OOPS!! it IS shabbos")
        } else if !isShabbos && sender.tag == 0 {
            //print("OOPS!! it's NOT shabbos")
        }
    }


    func gameOver() {
        timerLabel.text = "Time is up ⏰"
        let points = currentNumber-1
        let pointPoints = points == 1 ? "point" : "points"
        numberLabel.text = """
        Your score: \(points) \(pointPoints)
        """
    }


    func showNextNumber() {
        toggleUI(enable: false)
        currentNumber += 1
        numberLabel.text = """
        Is day number
        \(currentNumber)
        Shabbos?
        """
        toggleUI(enable: true)
    }


    func toggleUI(enable: Bool) {
        DispatchQueue.main.async {
            for button: UIButton in [self.shabbosButton, self.notShabbosButton] {
                button.isHidden = !enable
            }
        }
    }


}
