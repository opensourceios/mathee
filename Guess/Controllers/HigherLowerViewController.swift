//
//  HigherLowerViewController.swift
//  Guess
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2020 Daniel Springer. All rights reserved.
//

import UIKit
import StoreKit


class HigherLowerViewController: UIViewController {


    // MARK: Outlets

    var myTitle: String!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var trophyLabel: UILabel!


    // MARK: Properties

    var high = 1001
    var low = 0
    var guess = 0
    var diff = 0
    var halfDiff = 0
    var tries = 0


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.myTitle

        for state: UIControl.State in [.normal, .highlighted] {
            UIBarButtonItem.appearance().setTitleTextAttributes(
                [
                    NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)
                ], for: state)
        }

        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        trophyLabel.isHidden = true

        let okButton = UIBarButtonItem(
            title: Constants.Misc.okMessage,
            style: .plain, target: self,
            action: #selector(start))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)

    }


    // MARK: Helpers

    @objc func start() {
        showNextGuess()
    }

    @objc func showNextGuess() {
        tries += 1

        diff = high - low

        if diff == 3 {
            halfDiff = 2
        } else {
            halfDiff = diff / 2
        }

        guess = low + halfDiff

        guessLabel.isHidden = false
        guessLabel.text = "Is it \(guess)?"

        let lowerButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.down.circle"),
            style: .plain,
            target: self,
            action: #selector(lower))
        lowerButton.accessibilityLabel = "Go lower"

        let higherButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.circle"),
            style: .plain,
            target: self,
            action: #selector(higher))
        higherButton.accessibilityLabel = "Go higher"

        let yesButton = UIBarButtonItem(
            image: UIImage(systemName: "checkmark.circle"),
            style: .plain,
            target: self,
            action: #selector(correct))
        yesButton.accessibilityLabel = "Correct"

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        if halfDiff == 1 {
            guessLabel.text = "You thought: \(guess)"
            myToolbar.setItems([space, yesButton, space], animated: true)
        } else {
            myToolbar.setItems([lowerButton, space, yesButton, space, higherButton], animated: true)
        }

    }


    @objc func lower() {

        high = guess
        showNextGuess()
    }


    @objc func higher() {
        low = guess
        showNextGuess()
    }


    @objc func correct() {

        let trophies = ["👏💩👏", "🥉", "🥉🥉", "🥉🥉🥉", "🥈🥉🥉",
                        "🥈🥈🥉", "🥈🥈🥈", "🥇🥈🥈", "🥇🥇🥈", "🥇🥇🥇"]
        trophyLabel.text = ""
        trophyLabel.isHidden = false

        switch tries {
        case 1:
            guessLabel.text = "You thought: \(guess)\nThat took me 1 try."
            trophyLabel.text = trophies[tries - 1]
        case 2...10:
            guessLabel.text = "You thought: \(guess)\nThat took me \(tries) tries!"
            trophyLabel.text = trophies[tries - 1]
        default:
            guessLabel.text = "Oops! It took me more than 10 tries. Please let the developer know this happened."
            trophyLabel.text = "🏆"
        }

        let doneButton = UIBarButtonItem(
            title: Constants.Misc.endMessage,
            style: .plain,
            target: self,
            action: #selector(doneButtonPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, doneButton, space], animated: true)
    }


    // MARK: Action

    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }


}
