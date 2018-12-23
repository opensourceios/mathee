//
//  QueensViewController.swift
//  Guess Fun
//
//  Created by Daniel Springer on 11/27/18.
//  Copyright © 2018 Daniel Springer. All rights reserved.
//

import UIKit
import StoreKit


class QueensViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var solutionLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var myTextView: UITextView!


    // MARK: Properties

    var boardString = ""
    var didscrollOnce = false
    var shareButton = UIBarButtonItem()


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor: view.tintColor
                ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor: view.tintColor
                ], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor: UIColor.gray
                ], for: .disabled)

        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        let refreshButton = UIBarButtonItem(title: "💡", style: .plain, target: self, action: #selector(makeBoard))
        shareButton = UIBarButtonItem(title: "🥰", style: .plain, target: self, action: #selector(shareSolution))
        let homeButton = UIBarButtonItem(title: "🏠", style: .plain, target: self, action: #selector(donePressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([shareButton, space, homeButton, space, refreshButton], animated: true)

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        makeBoard()
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !didscrollOnce {
            myTextView.scrollRangeToVisible(NSRange(location: myTextView.text.count - 1, length: 1))
            myTextView.flashScrollIndicators()
        }

        didscrollOnce = true
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        myTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
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

    }


    @objc func shareSolution() {
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
        SKStoreReviewController.requestReview()
    }


}
