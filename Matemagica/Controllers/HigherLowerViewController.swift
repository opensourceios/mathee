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

    @IBOutlet weak var progressBar: UIProgressView!


    // MARK: Properties

    // later: let user pick how high the range is, and adjust tries needed accordingly, perhaps a picker showing options
    // for ranges and corresponding needed tries


    // TODO: maybe use binary: if < 512, than it doesn't need '512' KEY to reach total, if > 512, than '512' KEY
    // is definitely needed to reach total
    var myArray = Array(1...1000)

    var triesLeft = 10

    let myThemeColor: UIColor = .systemBlue
    let emojis = ["🤔", "🤨", "🧐", "😎", "🤓", "🫣", "😅", "🤗"]
    var swipeUp: UISwipeGestureRecognizer!
    var swipeDown: UISwipeGestureRecognizer!


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
        correctButton.setTitle(Const.okMessage, for: .normal)
        correctButton.sizeToFit()

        progressBar.setProgress(0, animated: false)

    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        progressBar.setProgress(1/11, animated: true)
    }


    // MARK: Helpers

    @objc func start() {
//        high =
//        low =
//        guess =
//        diff =
//        halfDiff =
//        tries =
        showNextGuess()

        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }


    @objc func showNextGuess() {
        triesLeft -= 1
        guard triesLeft >= 0 else {
            let alert = createAlert(alertReasonParam: .unknown)
            present(alert, animated: true)
            return
        }
        guessLabel.isHidden = false
        let myAttrString = attrifyString(
            preString: """


            Tries left: \(triesLeft)

            \(emojis.randomElement()!) I think your number is:


            """, toAttrify: "myArray.middle!\n", color: myThemeColor)
        myAttrString.append(NSAttributedString(string: """


        Swipe ⬆️ or ⬇️ so I try higher or lower
        """))

        guessLabel.attributedText = myAttrString
        guessLabel.accessibilityLabel = """
        Tries left: \(triesLeft). Is your number GUESS?
        Swipe up or down so I try higher or lower
        """


//        if app knows the answer {
//            self.view.removeGestureRecognizer(swipeUp)
//            self.view.removeGestureRecognizer(swipeDown)
//            let myAttrString = attrifyString(
//                preString: "You thought:\n", toAttrify: "\(guess)", color: myThemeColor)
//            myAttrString.append(attrifyString(
//                preString: "\n\nTries used:\n", toAttrify: "\(tries)", color: myThemeColor))
//            myAttrString.append(NSAttributedString(string: "\n\n"))
//
//            guessLabel.attributedText = myAttrString
//            correctButton.removeTarget(nil, action: nil, for: .allEvents)
//            correctButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
//            correctButton.setTitle(Const.correctMessage, for: .normal)
//            correctButton.isHidden = false
//        } else if app does not know the answer {
            correctButton.removeTarget(nil, action: nil, for: .allEvents)
            correctButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
            correctButton.setTitle(Const.correctMessage, for: .normal)
            correctButton.isHidden = false
//        }
        let myProgress: Float = (Float(11 - triesLeft) + 1.0) / 11.0
        progressBar.setProgress(myProgress, animated: true)
    }


    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
                case .down:
                    // high = guess
                    break
                case .up:
                    // low = guess
                    break
                default:
                    break
            }
            showNextGuess()
        }
    }


    // MARK: Action

    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }

}
