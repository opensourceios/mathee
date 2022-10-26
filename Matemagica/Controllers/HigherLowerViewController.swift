//
//  HigherLowerViewController.swift
//  Math Magic
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


class HigherLowerViewController: UIViewController {

    // MARK: Outlets

    var myTitle: String!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var lowerButton: UIButton!
    @IBOutlet weak var higherButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!


    // MARK: Properties

    var myArray = Array(1...1000)

    var triesLeft = 10
    let initialTriesPlusOne: Float = 11.0

    var guess = 0

    var thinkKnow = ""

    var triedUpperboundOfTwoItemArr = false

    var myThemeColor: UIColor!
    let thinkEmojis = ["🤔", "🤨", "🧐"]
    let knowEmojis = ["😎", "🥳", "😏"]


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if CommandLine.arguments.contains("--matemagicaScreenshots") {
            // We are in testing mode, make arrangements if needed
            UIView.setAnimationsEnabled(false)
        }

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)

        correctButton.removeTarget(nil, action: nil, for: .allEvents)
        correctButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        correctButton.setTitleNew(Const.okMessage)

        progressBar.setProgress(0, animated: false)

        guessLabel.text = """
        Think of a number, anywhere from \(myArray.first!), alllll the way to \(myArray.last!)

        I *will* guess it, and in \(triesLeft) tries - or less
        """
        toggleButtons(enable: false)
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        progressBar.setProgress(1.0/initialTriesPlusOne, animated: true)
        correctButton.doGlowAnimation(withColor: myThemeColor)
    }


    // MARK: Helpers

    @objc func start() {
        showNextGuess()
        correctButton.removeTarget(nil, action: nil, for: .allEvents)
        correctButton.addTarget(self, action: #selector(correctPressed), for: .touchUpInside)
        correctButton.setTitleNew(Const.correctMessage)
        toggleButtons(enable: true)
    }


    @objc func showNextGuess() {
        triesLeft -= 1
        guard triesLeft >= 0 else {
            let alert = createAlert(alertReasonParam: .unknown, style: .alert)
            present(alert, animated: true)
            return
        }

        thinkKnow = """
        \(thinkEmojis.randomElement()!)
        I think your number is:
        """

        if myArray.count == 1 {
            weKnow(localGuess: myArray.first!)
        } else if myArray.count == 2 {
            if triedUpperboundOfTwoItemArr {
                weKnow(localGuess: myArray.last!)
            } else {
                guess = myArray.first!
                triedUpperboundOfTwoItemArr = true
            }
        } else {
            guess = myArray.middle().first!
        }

        if guess == myArray.first! {
            lowerButton.isEnabled = false
        } else if guess == myArray.last! {
            higherButton.isEnabled = false
        }

        let tryTries = triesLeft == 1 ? "try" : "tries"

        let triesLeftNumOrNone = triesLeft > 0 ? "\(triesLeft)" : "no"

        let myAttrString = attrifyString(
            preString: """


            I have \(triesLeftNumOrNone) \(tryTries) left

            \(thinkKnow)


            """, toAttrify: "\(guess)\n", postString: nil, color: myThemeColor)
        myAttrString.append(NSAttributedString(string: """
        """))

        guessLabel.attributedText = myAttrString

        guessLabel.accessibilityLabel = """
        Tries left: \(triesLeft). \(thinkKnow): \(guess). Tap Higher, Lower, or Correct.
        """

        let myProgress: Float = (initialTriesPlusOne - Float(triesLeft) + 1.0) / initialTriesPlusOne
        progressBar.setProgress(myProgress, animated: true)
    }

    func toggleButtons(enable: Bool) {
        for button in [lowerButton, higherButton] {
            button?.isEnabled = enable
            if enable {
                button?.doGlowAnimation(withColor: myThemeColor)
            } else {
                button?.layer.removeAnimation(forKey: "shadowGlowingAnimation")
            }
        }
    }


    func weKnow(localGuess: Int) {
        toggleButtons(enable: false)
        guess = localGuess
        thinkKnow = """
        \(knowEmojis.randomElement()!)
        I know your number. It is:
        """
    }


    @IBAction func lowerOrHigherTapped(sender: UIButton) {
        switch sender.tag {
            case -1: // lower
                myArray = Array(myArray.first!...myArray.middle().first!-1)
            case 1: // higher
                myArray = Array(myArray.middle().first!+1...myArray.last!)
            default:
                let alert = createAlert(alertReasonParam: .unknown, style: .alert)
                present(alert, animated: true)
        }
        showNextGuess()
    }


    // MARK: Action

    @objc func correctPressed() {
        correctButton.removeTarget(nil, action: nil, for: .allEvents)
        correctButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        correctButton.setTitleNew(Const.doneMessage)
        toggleButtons(enable: false)
        thinkKnow = """
        \(knowEmojis.randomElement()!)
        Knew it all along
        """

        let myAttrString = attrifyString(
            preString: """


            Tries used: \(Int(initialTriesPlusOne)-1-triesLeft)

            \(thinkKnow)


            """, toAttrify: "\(guess)\n", postString: nil, color: myThemeColor)
        myAttrString.append(NSAttributedString(string: """
        """))

        guessLabel.attributedText = myAttrString

        guessLabel.accessibilityLabel = """
        Tries used: \(Int(initialTriesPlusOne)-1-triesLeft).
        \(thinkKnow).
        Your number was: \(guess).
        """

        let myProgress: Float = (initialTriesPlusOne - Float(triesLeft) + 1.0) / initialTriesPlusOne
        progressBar.setProgress(myProgress, animated: true)
    }


    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }

}
