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
    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var gameOverNextLevelButton: UIButton!
    @IBOutlet weak var gameOverPlayAgainButton: UIButton!


    // MARK: Properties

    let timeLeftPre = "Time left: "
    let correctMessages = [
        "amazing",
        "astonishing",
        "awesome",
        "excellent",
        "fabulous",
        "fantastic",
        "great",
        "impressive",
        "magnificent",
        "marvelous",
        "outstanding",
        "perfect",
        "superb",
        "terrific",
        "wonderful"
    ]

    var currentNumber = 0
    var myThemeColor: UIColor!
    var myGameTimer: Timer!
    var myPreTimer: Timer!
    var numbersRange: ClosedRange<Int>!
    var numbersDistribution: GKShuffledDistribution!
    var levelNumberIndex: Int!
    var score = 0 {
        didSet {
            scoreLabel.countAnimation(upto: Double(score))
        }
    }

    /* TODO: todos
     - Make tutorial an actual view with easy to read text..
     - Ask for name and save "NAME completed LEVEL" to leaderboard
     - Allow choosing different multiples? maybe separate game for that?
     - Make spamming "no" not useful
     - Lives that take time to regenerate, and if out of lives you have to wait
     */


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if CommandLine.arguments.contains("--matemagicaScreenshots") {
            // We are in testing mode, make arrangements if needed
            UIView.setAnimationsEnabled(false)
        }

        self.title = "Shabbos: Level \(levelNumberIndex+1)"
        numberLabel.text = " "
        scoreLabel.text = "Score: 0"
        setThemeColorTo(myThemeColor: myThemeColor)
        timerProgress.progress = 0
        toggleUI(enable: false)

        numbersDistribution = GKShuffledDistribution(lowestValue: numbersRange.first!, highestValue: numbersRange.last!)

        timerLabel.text = "\(timeLeftPre)00:\(Int(Const.timerSeconds))"
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        shabbosButton.doGlowAnimation(withColor: myThemeColor)
        //        notShabbosButton.doGlowAnimation(withColor: myThemeColor)
        startPreTimer()
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        myPreTimer?.invalidate()
        myPreTimer = nil
        myGameTimer?.invalidate()
        myGameTimer = nil
    }


    // MARK: Helpers

    @IBAction func preLevelSelectionTapped(_ sender: UIButton) {
        // 0=again, 1=next
        ud.set(levelNumberIndex+sender.tag, forKey: Const.levelIndexKey)
        navigationController!.popViewController(animated: true)
    }


    func startPreTimer() {
        timerProgress.setProgress(1, animated: true)
        var runsLeft: Float = 2
        let messages = ["🔴🔴 Ready 🔴🔴", "🟡🟡 Set 🟡🟡", "🟢🟢 Go! 🟢🟢"]
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

        let totalRuns: Float = Const.timerSeconds
        var runsLeft: Float = Const.timerSeconds

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

        showNextNumber()
    }


    func shakeAndShow() {
        toggleUI(enable: false)
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                self.showNextNumber()
            }
        })
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: numberLabel.center.x - 8, y: numberLabel.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: numberLabel.center.x + 8, y: numberLabel.center.y))
        numberLabel.layer.add(animation, forKey: "position")

        CATransaction.commit()
    }


    @IBAction func selectionTapped(_ sender: UIButton) {

        guard myGameTimer != nil else {
            toggleUI(enable: false)
            return
        }

        let isShabbos = currentNumber % 7 == 0

        // shabbos tag is 0
        if isShabbos && sender.tag == 0 {
            self.showToast(message: "SHABBOS! 2x BONUS!", color: myThemeColor)
            score += Const.pointsPerTap * 2
            showNextNumber()
        } else if !isShabbos && sender.tag == 1 {
            self.showToast(message: "\(correctMessages.randomElement()!)!".uppercased(), color: .systemGreen)
            score += Const.pointsPerTap
            showNextNumber()
        } else if isShabbos && sender.tag == 1 {
            shakeAndShow()
            self.showToast(message: "Oops", color: .systemGray)
        } else if !isShabbos && sender.tag == 0 {
            shakeAndShow()
            self.showToast(message: "Oops", color: .systemGray)
        }
    }


    func gameOver() {
        DispatchQueue.main.async { [self] in
            let alert = createAlert(alertReasonParam: .timeIsUp, style: .alert)
            present(alert, animated: true)
            timerLabel.isHidden = true
            timerLabel.textColor = .label
            let points = score
            let pointPoints = points == 1 ? "point" : "points"
            numberLabel.attributedText = attrifyString(
                preString: "Your score:\n",
                toAttrify: "\(points)",
                postString: pointPoints,
                color: myThemeColor)
            timerProgress.isHidden = true
            scoreLabel.isHidden = true
            gameOverPlayAgainButton.isHidden = false
            gameOverNextLevelButton.isHidden = false
        }
    }


    func showNextNumber() {
        guard myGameTimer != nil else {
            toggleUI(enable: false)
            return
        }
        toggleUI(enable: false)
        currentNumber = numbersDistribution.nextInt()
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
