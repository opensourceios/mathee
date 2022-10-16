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
    @IBOutlet var helpButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerProgress: UIProgressView!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!


    // MARK: Properties

    var currentNumber = 0
    var myTitle: String!
    var myThemeColor: UIColor!
    var myTimer: Timer!

    var timeInSeconds: Float!
    var numbersRange: ClosedRange<Int>!
    var levelNumberReal: Int!
    var score = 0 {
        didSet {
            scoreLabel.countAnimation(upto: Double(score))
        }
    }


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = myTitle
        numberLabel.text = " "
        scoreLabel.text = "Your score: 0"
        setThemeColorTo(myThemeColor: myThemeColor)
        timerProgress.progress = 1
        toggleUI(enable: false)

        helpButton.addTarget(self, action: #selector(showHelp),
                                 for: .touchUpInside)
        let helpItem = UIBarButtonItem(customView: helpButton)

        navigationItem.rightBarButtonItem = helpItem

        levelLabel.text = "Level #\(levelNumberReal+1)"
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        shabbosButton.doGlowAnimation(withColor: myThemeColor)
        //        notShabbosButton.doGlowAnimation(withColor: myThemeColor)
    }


    // MARK: Helpers

    @IBAction func timerTapped() {
        timerLabel.isHidden = false
        timerProgress.isHidden = false
        scoreLabel.isHidden = false
        startTimerButton.isHidden = true
        toggleUI(enable: true)

        let totalRuns: Float = timeInSeconds
        var runsLeft: Float = timeInSeconds
        timerLabel.text = "00:\(Int(runsLeft))"
        showNextNumber()

        myTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            runsLeft -= 1
            self.timerProgress.setProgress(runsLeft/totalRuns, animated: true)
            let preStr = Int(runsLeft) < 10 ? "00:0" : "00:"
            self.timerLabel.text = "\(preStr)\(Int(runsLeft))"
            if runsLeft <= 10 {
                self.timerLabel.textColor = .red
            }
            if runsLeft == 0 {
                self.toggleUI(enable: false)
                timer.invalidate()
                self.myTimer.invalidate()
                self.myTimer = nil
                self.gameOver()
            }
        }
    }


    @objc func showHelp() {
        print("\(#function) called")
    }


    func shakeAndShow() {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.showNextNumber()
        })
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: numberLabel.center.x - 10, y: numberLabel.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: numberLabel.center.x + 10, y: numberLabel.center.y))
        numberLabel.layer.add(animation, forKey: "position")
        CATransaction.commit()
    }


    // TODO: button: how to play: add instructions
    // disable buttons while wrong animation plays (or and if correct, until next number is shown, maybe enable ui in showNextNumber), make animation a bit longer
    @IBAction func selectionTapped(_ sender: UIButton) {

        guard myTimer != nil else {
            toggleUI(enable: false)
            return
        }

        let isShabbos = currentNumber % 7 == 0

        // shabbos tag is 0
        if isShabbos && sender.tag == 0 {
            self.showToast(message: "CORRECT!")
            // TODO: sound
            score += currentNumber
            showNextNumber()
        } else if !isShabbos && sender.tag == 1 {
            self.showToast(message: "CORRECT!")
            // TODO: sound
            score += currentNumber
            showNextNumber()
        } else if isShabbos && sender.tag == 1 {
            shakeAndShow()
            //self.showToast(message: "Oops, \(currentNumber) is Shabbos")
        } else if !isShabbos && sender.tag == 0 {
            shakeAndShow()
            //self.showToast(message: "Oops, \(currentNumber) is not Shabbos")
        }
    }


    func gameOver() {
        timerLabel.textColor = .label
        timerLabel.text = "Time is up ⏰"
        let points = score
        let pointPoints = points == 1 ? "point" : "points"
        numberLabel.attributedText = attrifyString(
            preString: "Your score:\n",
            toAttrify: "\(points)",
            postString: pointPoints,
            color: myThemeColor)
        timerProgress.isHidden = true
    }


    func showNextNumber() {
        toggleUI(enable: false)
        currentNumber = numbersRange.randomElement()!
        let myAttrText = attrifyString(
            preString: "Is day\n\n", toAttrify: "\(currentNumber)", postString: "Shabbos?", color: myThemeColor)
        numberLabel.attributedText = myAttrText
        self.toggleUI(enable: true)
    }


    func toggleUI(enable: Bool) {
        DispatchQueue.main.async {
            for button: UIButton in [self.shabbosButton, self.notShabbosButton] {
                button.isHidden = !enable
            }
        }
    }


}
