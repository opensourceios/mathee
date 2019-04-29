//
//  QueensViewController.swift
//  Guess
//
//  Created by Daniel Springer on 11/27/18.
//  Copyright © 2019 Daniel Springer. All rights reserved.
//

import UIKit
import StoreKit


class QueensViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var solutionLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var myTextView: UITextView!


    // MARK: Properties

    var hasSolutionToShare = false
    var boardString = ""
    var shareButton = UIBarButtonItem()
    let initialString = """
        Have you heard of the 8 Queens Puzzle?

        The 8 Queens Puzzle is the problem of placing eight chess queens on an 8×8 chessboard so that \
        no two queens threaten each other. Thus, a solution requires that no two queens share the \
        same row, column, or diagonal.

        Go ahead, get a chessboard, and try solving this puzzle yourself!

        When you choose to, you can come here for a solution.

        Tap 💡 to generate a solution.
        """
    let updatedString = """
        Have you heard of the 8 Queens Puzzle?

        The 8 Queens Puzzle is the problem of placing eight chess queens on an 8×8 chessboard so that \
        no two queens threaten each other. Thus, a solution requires that no two queens share the \
        same row, column, or diagonal.

        Go ahead, get a chessboard, and try solving this puzzle yourself!

        When you choose to, you can come here for a solution.

        Tap 💌 to share your favorite solutions with friends and family.

        Tap 💡 to generate a new solution.
        """


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Misc.fontSize),
                NSAttributedString.Key.foregroundColor: view.tintColor as Any
                ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Misc.fontSize),
                NSAttributedString.Key.foregroundColor: view.tintColor as Any
                ], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.Misc.fontSize),
                NSAttributedString.Key.foregroundColor: UIColor.gray
                ], for: .disabled)

        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        let refreshButton = UIBarButtonItem(title: "💡", style: .plain, target: self, action: #selector(makeBoard))
        let homeButton = UIBarButtonItem(title: "🏠", style: .plain, target: self, action: #selector(donePressed))
        let spaceFlexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([homeButton, spaceFlexible, refreshButton], animated: true)

        let textColor: UIColor = UserDefaults.standard.bool(forKey: Constants.UserDef.darkModeEnabled) ? .white : .black
        let myAttributes = [
            NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 24)!,
            NSAttributedString.Key.foregroundColor: textColor
        ]
        myTextView.attributedText = NSAttributedString(string: initialString, attributes: myAttributes)

        shareButton = UIBarButtonItem(title: "💌", style: .plain, target: self, action: #selector(shareSolution))
        //navigationController?.navigationItem.rightBarButtonItem = shareButton
        navigationItem.rightBarButtonItem = shareButton

        let darkMode = UserDefaults.standard.bool(forKey: Constants.UserDef.darkModeEnabled)

        view.backgroundColor = darkMode ? .black : .white
        solutionLabel.textColor = darkMode ? .white : .black
        myTextView.textColor = darkMode ? .white : .black
        myTextView.backgroundColor = darkMode ? .black : .white

    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !UserDefaults.standard.bool(forKey: Constants.Misc.didScrollOnceDown) {
            myTextView.scrollRangeToVisible(NSRange(location: myTextView.text.count - 1, length: 1))
            let darkMode = UserDefaults.standard.bool(forKey: Constants.UserDef.darkModeEnabled)
            myTextView.indicatorStyle = darkMode ? .white : .black
            myTextView.flashScrollIndicators()
            UserDefaults.standard.set(true, forKey: Constants.Misc.didScrollOnceDown)
        }

    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        myTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        let darkMode = UserDefaults.standard.bool(forKey: Constants.UserDef.darkModeEnabled)
        myTextView.indicatorStyle = darkMode ? .white : .black
        myTextView.flashScrollIndicators()

    }


    // MARK: Helpers

    func hasAllValidDiagonals(board: [[Int]]) -> Bool {

        guard (board[0][6] +
            board[1][7]) <= 1 else {
                return false
        }

        guard (board[0][5] +
            board[1][6] +
            board[2][7]) <= 1 else {
                return false
        }

        guard (board[0][4] +
            board[1][5] +
            board[2][6] +
            board[3][7]) <= 1 else {
                return false
        }

        guard (board[0][3] +
            board[1][4] +
            board[2][5] +
            board[3][6] +
            board[4][7]) <= 1 else {
                return false
        }

        guard (board[0][2] +
            board[1][3] +
            board[2][4] +
            board[3][5] +
            board[4][6] +
            board[5][7]) <= 1 else {
                return false
        }

        guard (board[0][1] +
            board[1][2] +
            board[2][3] +
            board[3][4] +
            board[4][5] +
            board[5][6] +
            board[6][7]) <= 1 else {
                return false
        }

        guard (board[0][0] +
            board[1][1] +
            board[2][2] +
            board[3][3] +
            board[4][4] +
            board[5][5] +
            board[6][6] +
            board[7][7]) <= 1 else {
                return false
        }

        guard (board[0][1] +
            board[1][0]) <= 1 else {
                return false
        }

        guard (board[0][2] +
            board[1][1] +
            board[2][0]) <= 1 else {
                return false
        }

        guard (board[0][3] +
            board[1][2] +
            board[2][1] +
            board[3][0]) <= 1 else {
                return false
        }

        guard (board[0][4] +
            board[1][3] +
            board[2][2] +
            board[3][1] +
            board[4][0]) <= 1 else {
                return false
        }

        guard (board[0][5] +
            board[1][4] +
            board[2][3] +
            board[3][2] +
            board[4][1] +
            board[5][0]) <= 1 else {
                return false
        }

        guard (board[0][6] +
            board[1][5] +
            board[2][4] +
            board[3][3] +
            board[4][2] +
            board[5][1] +
            board[6][0]) <= 1 else {
                return false
        }

        guard (board[0][7] +
            board[1][6] +
            board[2][5] +
            board[3][4] +
            board[4][3] +
            board[5][2] +
            board[6][1] +
            board[7][0]) <= 1 else {
                return false
        }

        guard (board[7][6] +
            board[6][7]) <= 1 else {
                return false
        }

        guard (board[7][5] +
            board[6][6] +
            board[5][7]) <= 1 else {
                return false
        }

        guard (board[7][4] +
            board[6][5] +
            board[5][6] +
            board[4][7]) <= 1 else {
                return false
        }

        guard (board[7][3] +
            board[6][4] +
            board[5][5] +
            board[4][6] +
            board[3][7]) <= 1 else {
                return false
        }

        guard (board[7][2] +
            board[6][3] +
            board[5][4] +
            board[4][5] +
            board[3][6] +
            board[2][7]) <= 1 else {
                return false
        }

        guard (board[7][1] +
            board[6][2] +
            board[5][3] +
            board[4][4] +
            board[3][5] +
            board[2][6] +
            board[1][7]) <= 1 else {
                return false
        }

        guard (board[7][1] +
            board[6][0]) <= 1 else {
                return false
        }

        guard (board[7][2] +
            board[6][1] +
            board[5][0]) <= 1 else {
                return false
        }

        guard (board[7][3] +
            board[6][2] +
            board[5][1] +
            board[4][0]) <= 1 else {
                return false
        }

        guard (board[7][4] +
            board[6][3] +
            board[5][2] +
            board[4][1] +
            board[3][0]) <= 1 else {
                return false
        }

        guard (board[7][5] +
            board[6][4] +
            board[5][3] +
            board[4][2] +
            board[3][1] +
            board[2][0]) <= 1 else {
                return false
        }

        guard (board[7][6] +
            board[6][5] +
            board[5][4] +
            board[4][3] +
            board[3][2] +
            board[2][1] +
            board[1][0]) <= 1 else {
                return false
        }

        return true
    }


    @objc func makeBoard() {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)

        var current = 0
        let limit = 1
        while current < limit {
            let positions = (0...7).shuffled()
            var index = 0
            var board = [[0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0],
                         [0, 0, 0, 0, 0, 0, 0, 0]]

            var boardOfStrings = [["", "", "", "", "", "", "", ""],
                                  ["", "", "", "", "", "", "", ""],
                                  ["", "", "", "", "", "", "", ""],
                                  ["", "", "", "", "", "", "", ""],
                                  ["", "", "", "", "", "", "", ""],
                                  ["", "", "", "", "", "", "", ""],
                                  ["", "", "", "", "", "", "", ""],
                                  ["", "", "", "", "", "", "", ""]]

            for row in 0...7 {
                board[row][positions[index]] = 1
                index += 1
            }

            for (indexOfRow, row) in board.enumerated() {
                for indexOfCol in row.indices {
                    if (indexOfRow + indexOfCol) % 2 == 0 {
                        boardOfStrings[indexOfRow][indexOfCol] = "⬜️"
                    } else {
                        boardOfStrings[indexOfRow][indexOfCol] = "⬛️"
                    }
                }
            }

            if self.hasAllValidDiagonals(board: board) {

                for (indexOfRow, row) in board.enumerated() {
                    for (indexOfCol, col) in row.enumerated() where col == 1 {
                        boardOfStrings[indexOfRow][indexOfCol] = "👸"
                    }
                }

                self.boardString = ""

                for (index, row) in boardOfStrings.enumerated() {
                    if index == boardOfStrings.count {
                        self.boardString.append("\(row.joined())")
                    } else {
                        self.boardString.append("\(row.joined())\n")
                    }
                }

                current += 1
            }
        }

        self.solutionLabel.text = boardString

        if !hasSolutionToShare {
            let textColor: UIColor = UserDefaults.standard.bool(
                forKey: Constants.UserDef.darkModeEnabled) ? .white : .black
            let myAttributes = [
                NSAttributedString.Key.font: UIFont(name: Constants.Misc.fontChalkduster, size: 24)!,
                NSAttributedString.Key.foregroundColor: textColor
            ]
            myTextView.attributedText = NSAttributedString(
                string: updatedString, attributes: myAttributes)
            hasSolutionToShare = true
        }

    }


    @objc func shareSolution() {
        AppData.getSoundEnabledSettings(sound: Constants.Sound.low)

        guard hasSolutionToShare else {
            let alert = createAlert(alertReasonParam: .hasNoSolution)
            present(alert, animated: true)
            return
        }

        let message = """
        Here's my solution to the '8 Queens Puzzle':\n\n\(solutionLabel.text!)\n\n(What's this?)\n\n \
        The '8 Queens Puzzle' is the problem of placing eight chess queens on an 8×8 chessboard so \
        that no two queens threaten each other. Thus, a solution requires that no two queens share \
        the same row, column, or diagonal. See more solutions to this puzzle - and more games - \
        here: https://itunes.apple.com/app/id1406084758
        """
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = shareButton
        activityController.completionWithItemsHandler = {
            (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
            guard error == nil else {
                let alert = self.createAlert(alertReasonParam: AlertReason.unknown)
                alert.view.layoutIfNeeded()
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }

                return
            }
        }
        DispatchQueue.main.async {
            self.present(activityController, animated: true)
        }

    }


    @objc func donePressed() {
        navigationController?.popToRootViewController(animated: true)
        AppData.getSoundEnabledSettings(sound: Constants.Sound.high)
        SKStoreReviewController.requestReview()
    }


}
