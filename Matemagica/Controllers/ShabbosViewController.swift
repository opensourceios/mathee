//
//  ShabbosViewController.swift
//  Matemagica
//
//  Created by dani on 10/6/22.
//  Copyright © 2022 Dani Springer. All rights reserved.
//

import UIKit
import GameKit

class ShabbosViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var numberLabel: UILabel!

    @IBOutlet weak var shabbosButton: UIButton!
    @IBOutlet weak var notShabbosButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerProgress: UIProgressView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!


    // MARK: Properties

    let timeLeftPre = "Time left: "

    var currentNumber = 0
    var myTitle: String!
    var myThemeColor: UIColor!
    var myGameTimer: Timer!
    var myPreTimer: Timer!
    var timeInSeconds: Float!
    var numbersRange: ClosedRange<Int>!
    var distribution: GKShuffledDistribution!
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
        timerProgress.progress = 0
        toggleUI(enable: false)


        levelLabel.text = "Level \(levelNumberReal+1)".uppercased()

        distribution = GKShuffledDistribution(lowestValue: numbersRange.first!, highestValue: numbersRange.last!)

        timerLabel.text = "\(timeLeftPre)00:\(Int(timeInSeconds))"
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        shabbosButton.doGlowAnimation(withColor: myThemeColor)
        //        notShabbosButton.doGlowAnimation(withColor: myThemeColor)
        startPreTimer()
    }


    // MARK: Helpers

    func startPreTimer() {
        var runsLeft: Float = 2
        let messages = ["Ready", "Set", "Go!"]
        var messageIndex = 0
        showToast(message: messages[messageIndex], color: .systemBlue)
        messageIndex += 1

        myPreTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            runsLeft -= 1
            self.showToast(message: messages[messageIndex], color: .systemBlue)
            messageIndex += 1
            if runsLeft == 0 {
                timer.invalidate()
                self.myPreTimer.invalidate()
                self.myPreTimer = nil
                self.startGameTimer()
            }
        }
    }


    func startGameTimer() {
        toggleUI(enable: true)
        timerProgress.setProgress(1, animated: true)

        let totalRuns: Float = timeInSeconds
        var runsLeft: Float = timeInSeconds
        showNextNumber()

        myGameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            runsLeft -= 1
            self.timerProgress.setProgress(runsLeft/totalRuns, animated: true)
            let preStr = Int(runsLeft) < 10 ? "00:0" : "00:"
            self.timerLabel.text = "\(self.timeLeftPre)\(preStr)\(Int(runsLeft))"
            if runsLeft <= 10 {
                self.timerLabel.textColor = .red
            }
            if runsLeft == 0 {
                self.toggleUI(enable: false)
                timer.invalidate()
                self.myGameTimer.invalidate()
                self.myGameTimer = nil
                self.gameOver()
            }
        }
    }


    func shakeAndShow() {
        toggleUI(enable: false)
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.showNextNumber()
        })
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: numberLabel.center.x - 10, y: numberLabel.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: numberLabel.center.x + 10, y: numberLabel.center.y))
        numberLabel.layer.add(animation, forKey: "position")
        CATransaction.commit()
    }


    // TODO: todos
    // play sound on correct tap?
    // lose some points if Nope incorrectly tapped?
    // How to make points total less in higher levels which have higher numbers?

    @IBAction func selectionTapped(_ sender: UIButton) {

        guard myGameTimer != nil else {
            toggleUI(enable: false)
            return
        }

        let isShabbos = currentNumber % 7 == 0

        // shabbos tag is 0
        if isShabbos && sender.tag == 0 {
            self.showToast(message: "Correct! x2 points!".uppercased(), color: .systemGreen)
            score += currentNumber*2
            showNextNumber()
        } else if !isShabbos && sender.tag == 1 {
            self.showToast(message: "Correct!".uppercased(), color: .systemGreen)
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
        var pointPoints = points == 1 ? "point" : "points"
        pointPoints.append("\n\n\n\nChoose a level to play again")
        numberLabel.attributedText = attrifyString(
            preString: "Your score:\n",
            toAttrify: "\(points)",
            postString: pointPoints,
            color: myThemeColor)
        timerProgress.isHidden = true
    }


    func showNextNumber() {
        toggleUI(enable: false)
        currentNumber = distribution.nextInt()
        let myAttrText = attrifyString(
            preString: "Will day number\n", toAttrify: "\(currentNumber)",
            postString: "be Shabbos?", color: myThemeColor)
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
