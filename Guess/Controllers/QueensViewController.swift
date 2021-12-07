//
//  QueensViewController.swift
//  Guess
//
//  Created by Daniel Springer on 11/27/18.
//  Copyright © 2021 Daniel Springer. All rights reserved.
//

import UIKit


class QueensViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var solutionLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    @IBOutlet weak var myTextView2: UITextView!


    // MARK: Properties

    var myTitle: String!
    var boardString = ""
    var shareButton = UIBarButtonItem()

    var textColor: UIColor! = UIColor.label

    let puzzleDescription = NSLocalizedString("""
    Have you heard of the 8 Queens Puzzle?

    The 8 Queens Puzzle is the problem of placing eight chess queens on an 8x8 chessboard so that \
    no two queens threaten each other. Thus, a solution requires that no two queens share the same \
    row, column, or diagonal.

    Go ahead, get a chessboard, and try solving this puzzle yourself!

    When you choose to, you can come here for a solution.

    Tap  to generate a new solution.

    Tap  to share your favorite solutions with friends and family.
    """, comment: "")

    var myThemeColor: UIColor!


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)
        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        let newSolutionButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(makeBoard))

        let spaceFlexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([spaceFlexible, newSolutionButton], animated: true)

        shareButton = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain,
            target: self,
            action: #selector(shareSolution))

        navigationItem.rightBarButtonItems = [shareButton]

        myTextView2.text = puzzleDescription

        myTextView2.layer.cornerRadius = 4

        myTextView2.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        let image = UIImage(systemName: "square.and.arrow.up")?.withTintColor(myThemeColor)
        let attachment = NSTextAttachment()
        attachment.image = image
        let attString = NSAttributedString(attachment: attachment)
        myTextView2.textStorage.insert(attString, at: 416)

        let image2 = UIImage(systemName: "plus")?.withTintColor(myThemeColor)
        let attachment2 = NSTextAttachment()
        attachment2.image = image2
        let attString2 = NSAttributedString(attachment: attachment2)
        myTextView2.textStorage.insert(attString2, at: 382)
        makeBoard()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myTextView2.flashScrollIndicators()
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
                        boardOfStrings[indexOfRow][indexOfCol] = randomQueen()
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


    func randomQueen() -> String {
        let queens = ["👸", "👸🏻", "👸🏼", "👸🏽", "👸🏾", "👸🏿"]
        return queens.randomElement()!
    }


    @objc func shareSolution() {

        let message = NSLocalizedString(
        """
        Here's my solution to the '8 Queens Puzzle':
        """, comment: "")
        +
        "\n\n\(solutionLabel.text!)"
        +
        NSLocalizedString(
        """

        (What's this?)

         The '8 Queens Puzzle' is the problem of placing eight chess queens on an 8×8 chessboard so \
         that no two queens threaten each other. Thus, a solution requires that no two queens share \
         the same row, column, or diagonal. See more solutions to this puzzle - and more games - \
         here: https://itunes.apple.com/app/id1406084758
        """, comment: "")
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityController.popoverPresentationController?.barButtonItem = shareButton
        activityController.completionWithItemsHandler = { (_, _: Bool, _: [Any]?, error: Error?) in
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


}
