//
//  HigherLowerViewController.swift
//  Matemagica
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


class HigherLowerViewController: UIViewController {


    // MARK: Outlets

    var myTitle: String!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!


    // MARK: Properties

    var high = 1001
    var low = 0
    var guess = 0
    var diff = 0
    var halfDiff = 0
    var tries = 0

    let myThemeColor: UIColor = .systemYellow


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)
        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        let okButton = UIBarButtonItem(
            title: Const.Misc.okMessage,
            style: .plain, target: self,
            action: #selector(start))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)

    }


    // MARK: Helpers

    @objc func start() {
        high = 1001
        low = 0
        guess = 0
        diff = 0
        halfDiff = 0
        tries = 0
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
        guessLabel.text = "Is it " + "\(guess)?"

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
            guessLabel.text = "You thought: " + "\(guess)"
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

        guessLabel.text = ""

        let doneButton = UIBarButtonItem(
            title: Const.Misc.endMessage,
            style: .done,
            target: self,
            action: #selector(doneButtonPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, doneButton], animated: true)
    }


    // MARK: Action

    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }

}
