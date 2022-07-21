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

    var high = 1000
    var low = 0
    var guess = 0
    var diff = 0
    var halfDiff = 0
    var tries = 0

    let myThemeColor: UIColor = .systemBlue

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
//        high = 1000
//        low = 1
//        guess = 0
//        diff = 0
//        halfDiff = 0
//        tries = 0
        showNextGuess()

        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)

        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }


    @objc func showNextGuess() {
        tries += 1
        diff = high - low
        halfDiff = Int( (Double(diff) / 2.0).rounded(.up) )
        guess = low + halfDiff
        guessLabel.isHidden = false
        let myAttrString = attrifyString(
            preString: "\n\nTry #\(tries):\n\nIs your number...\n", toAttrify: "\(guess)\n", color: myThemeColor)
        myAttrString.append(NSAttributedString(string: """
        Swipe ⬆️ or ⬇️ so I try higher or lower
        """))

        guessLabel.attributedText = myAttrString
        guessLabel.accessibilityLabel = """
        Try number \(tries): Is your number \(guess)?
        Swipe up or down so I try higher or lower
        """


        if halfDiff == 1 {
            self.view.removeGestureRecognizer(swipeUp)
            self.view.removeGestureRecognizer(swipeDown)

            let myAttrString = attrifyString(
                preString: "You thought:\n", toAttrify: "\(guess)", color: myThemeColor)

            myAttrString.append(attrifyString(
                preString: "\n\nTries used:\n", toAttrify: "\(tries)", color: myThemeColor))

            myAttrString.append(NSAttributedString(string: "\n\n"))

            guessLabel.attributedText = myAttrString


            // correct button
            correctButton.removeTarget(nil, action: nil, for: .allEvents)
            correctButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
            correctButton.setTitle(Const.correctMessage, for: .normal)
            correctButton.isHidden = false
        } else {
            print("halfDiff is not 1. It is: \(halfDiff)")
            // all buttons
            correctButton.removeTarget(nil, action: nil, for: .allEvents)
            correctButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
            correctButton.setTitle(Const.correctMessage, for: .normal)
            correctButton.isHidden = false
        }
        let myProgress: Float = (Float(tries) + 1.0) / 11.0
        progressBar.setProgress(myProgress, animated: true)
    }


    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
                case .down:
                    print("Swiped down")
                    high = guess
                case .up:
                    print("Swiped up")
                    low = guess
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
