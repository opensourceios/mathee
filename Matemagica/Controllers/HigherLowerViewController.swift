//
//  HigherLowerViewController.swift
//  Math Magic
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


class HigherLowerViewController: UIViewController {
    // TOOD: see all comments in this file

    // MARK: Outlets

    var myTitle: String!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var correctButton: UIButton!

    @IBOutlet weak var progressBar: UIProgressView!


    // MARK: Properties

    // later: let user pick how high the range is, and adjust tries needed accordingly, perhaps a picker showing options
    // for ranges and corresponding needed tries


    // maybe use binary: if < 512, than it doesn't need '512' KEY to reach total, if > 512, than '512' KEY
    // is definitely needed to reach total

    // replace swipes with buttons, swipes are not accessible
    var myArray = Array(1...1000)

    var triesLeft = 10
    let initialTriesPlusOne: Float = 11.0

    var guess = 0

    var thinkKnow = ""
    var swipeUpOrDown = ""
    var swipeUpOrDownAcc = ""

    var triedUpperboundOfTwoItemArr = false

    let myThemeColor: UIColor = .systemBlue
    let thinkEmojis = ["🤔", "🤨", "🧐", "🫣", "😅"]
    let knowEmojis = ["😎", "🤓", "🤗", "😊", "😇"]
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

        guessLabel.text = """
        Think of a number from \(myArray.first!) to \(myArray.last!)

        I will guess it in \(triesLeft) tries or less
        """

    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        progressBar.setProgress(1.0/initialTriesPlusOne, animated: true)
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
        correctButton.removeTarget(nil, action: nil, for: .allEvents)
        correctButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        correctButton.setTitle(Const.correctMessage, for: .normal)
        correctButton.isHidden = false

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
            fatalError()
        }

        thinkKnow = "\(thinkEmojis.randomElement()!) I think your number is:"
        swipeUpOrDown = "Swipe ⬆️ or ⬇️ so I try higher or lower"
        swipeUpOrDownAcc = "Swipe up or down so I try higher or lower"

        if myArray.count == 1 { // WE KNOW
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

        guessLabel.isHidden = false
        let myAttrString = attrifyString(
            preString: """


            Tries left: \(triesLeft)

            \(thinkKnow)


            """, toAttrify: "\(guess)\n", color: myThemeColor)
        myAttrString.append(NSAttributedString(string: """

        \(swipeUpOrDown)

        """))

        guessLabel.attributedText = myAttrString // animate this change

        guessLabel.accessibilityLabel = """
        Tries left: \(triesLeft). \(thinkKnow): \(guess). \(swipeUpOrDownAcc)
        """

        let myProgress: Float = (initialTriesPlusOne - Float(triesLeft) + 1.0) / initialTriesPlusOne // improve?
        progressBar.setProgress(myProgress, animated: true)
    }


    func weKnow(localGuess: Int) {
        self.view.removeGestureRecognizer(swipeUp)
        self.view.removeGestureRecognizer(swipeDown)

        guess = localGuess
        thinkKnow = "\(knowEmojis.randomElement()!) I know your number. It is:"
        swipeUpOrDown = " "
        swipeUpOrDownAcc = ""
    }


    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//            print("guess was: \(guess)")
            switch swipeGesture.direction {
                case .down:
                    // high = guess
                    if guess == myArray.first! {
                        // user swiped the wrong way
                        return
                    }
                    myArray = Array(myArray.first!...myArray.middle().first!-1)
                case .up:
                    // low = guess
                    if guess == myArray.last! {
                        // user swiped the wrong way
                        myArray = Array(myArray.first!...myArray.middle().first!-1)
                        return
                    }
                    myArray = Array(myArray.middle().first!+1...myArray.last!)

                default:
                    break
            }

            if myArray.count == 2 {
//                print("myArray: \(myArray)")
            }
//            print("arrayFirst now is: \(myArray.first!)")
//            print("arrayLast now is: \(myArray.last!)")
            showNextGuess()
        }
    }


    // MARK: Action

    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }

}
