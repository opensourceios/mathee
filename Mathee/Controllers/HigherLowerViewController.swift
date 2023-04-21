//
//  HigherLowerViewController.swift
//  Mathee
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2023 Daniel Springer. All rights reserved.
//

import UIKit


class HigherLowerViewController: UIViewController {

    // MARK: Outlets

    var myTitle: String!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var lowerButton: UIButton!
    @IBOutlet weak var higherButton: UIButton!


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

        if CommandLine.arguments.contains("--matheeScreenshots") {
            // We are in testing mode, make arrangements if needed
            UIView.setAnimationsEnabled(false)
        }

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)

        correctButton.removeTarget(nil, action: nil, for: .allEvents)
        correctButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        correctButton.setTitleNew(Const.okMessage)

        guessLabel.text = """
        Think of a number, anywhere from \(myArray.first!), alllll the way to \(myArray.last!)

        I will guess it in \(triesLeft) tries - or less
        """
        setButtonsUsable(false)
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        correctButton.doGlowAnimation(withColor: myThemeColor)
    }


    // MARK: Helpers

    @objc func start() {
        showNextGuess()
        correctButton.removeTarget(nil, action: nil, for: .allEvents)
        correctButton.addTarget(self, action: #selector(correctPressed), for: .touchUpInside)
        correctButton.setTitleNew(Const.correctMessage)
        setButtonsUsable(true)
    }


    @objc func showNextGuess() {
        triesLeft -= 1
        guard triesLeft >= 0 else {
            let alert = createAlert(alertReasonParam: .unknown)
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
            lowerButton.isHidden = true
        } else if guess == myArray.last! {
            higherButton.isHidden = true
        }

        let myAttrString = attrifyString(
            preString: """

            \(thinkKnow)


            """, toAttrify: "\(guess)\n", postString: nil, color: myThemeColor)
        myAttrString.append(NSAttributedString(string: """
        """))

        guessLabel.attributedText = myAttrString

        guessLabel.accessibilityLabel = """
        Tries left: \(triesLeft). \(thinkKnow): \(guess). Tap Higher, Lower, or Correct.
        """

    }


    func setButtonsUsable(_ enable: Bool) {
        for button in [lowerButton, higherButton] {
            button?.isHidden = !enable
            if enable {
                button?.doGlowAnimation(withColor: myThemeColor)
            } else {
                button?.layer.removeAnimation(forKey: "shadowGlowingAnimation")
            }
        }
    }


    func weKnow(localGuess: Int) {
        setButtonsUsable(false)
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
                let alert = createAlert(alertReasonParam: .unknown)
                present(alert, animated: true)
        }
        showNextGuess()
    }


    // MARK: Action

    @objc func correctPressed() {
        correctButton.removeTarget(nil, action: nil, for: .allEvents)
        correctButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        correctButton.setTitleNew(Const.doneMessage)
        setButtonsUsable(false)
        thinkKnow = """
        \(knowEmojis.randomElement()!)
        Knew it all along
        """

        let tryTries = Int(initialTriesPlusOne)-1-triesLeft == 1 ? "try" : "tries"
        let myAttrString = attrifyString(
            preString: """


            That took me \(Int(initialTriesPlusOne)-1-triesLeft) \(tryTries)

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
    }


    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }

}
