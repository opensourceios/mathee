//
//  BookViewController.swift
//  Math Magic
//
//  Created by Daniel Springer on 04/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


class BookViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var pageContentLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!


    // MARK: Properties

    var myTitle: String!

    struct Page {
        let key: Int
        let value: [Int]
    }

    let pagesArrayOfDicts = [
        1: [1, 3, 5, 7, 9, 11,
            13, 15, 17, 19, 21, 23,
            25, 27, 29, 31, 33, 35,
            37, 39, 41, 43, 45, 47,
            49, 51, 53, 55, 57, 59,
            61, 63],
        2: [2, 3, 6, 7, 10, 11,
            14, 15, 18, 19, 22, 23,
            26, 27, 30, 31, 34, 35,
            38, 39, 42, 43, 46, 47,
            50, 51, 54, 55, 58, 59,
            62, 63],
        4: [4, 5, 6, 7, 12, 13,
            14, 15, 20, 21, 22, 23,
            28, 29, 30, 31, 36, 37,
            38, 39, 44, 45, 46, 47,
            52, 53, 54, 55, 60, 61,
            62, 63],
        8: [8, 9, 10, 11, 12, 13,
            14, 15, 24, 25, 26, 27,
            28, 29, 30, 31, 40, 41,
            42, 43, 44, 45, 46, 47,
            56, 57, 58, 59, 60, 61,
            62, 63],
        16: [16, 17, 18, 19, 20, 21,
             22, 23, 24, 25, 26, 27,
             28, 29, 30, 31, 48, 49,
             50, 51, 52, 53, 54, 55,
             56, 57, 58, 59, 60, 61,
             62, 63],
        32: [32, 33, 34, 35, 36, 37,
             38, 39, 40, 41, 42, 43,
             44, 45, 46, 47, 48, 49,
             50, 51, 52, 53, 54, 55,
             56, 57, 58, 59, 60, 61,
             62, 63]]

    var arrayOfPages = [Page]()
    var shuffledPagesByContent = [Page]()
    var shuffledPagesByOrder = [Page]()
    var userNumber = 0
    var currentPageReal = 0
    let myThemeColor = UIColor.systemOrange

    let possibleDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let colorsArray: [UIColor] = [
        .systemCyan,
        .systemBlue,
        .systemMint,
        .systemBrown,
        .systemGreen,
        .magenta,
        .systemOrange,
        .systemPurple,
        .systemRed,
        .systemTeal
    ]


    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if CommandLine.arguments.contains("--matemagicaScreenshots") {
            // We are in testing mode, make arrangements if needed
            UIView.setAnimationsEnabled(false)
        }

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)

        for page in pagesArrayOfDicts {
            arrayOfPages.append(Page(key: page.key, value: page.value))
        }


        for page in arrayOfPages {
            let shuffledPageContent = page.value.shuffled()
            shuffledPagesByContent.append(Page(key: page.key, value: shuffledPageContent))
        }

        shuffledPagesByOrder = shuffledPagesByContent.shuffled()

        pageNumberLabel.text = """
        Think of a number 1-63

        Look for your number in the next 6 lists, and tell the app if you spot it.

        Can *you* figure out how the app guesses your number?
        """
        pageContentLabel.text = ""

        progressBar.setProgress(0, animated: false)

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        leftButton.isHidden = true
        middleButton.isHidden = false
        rightButton.isHidden = true

        middleButton.setTitle(Const.okMessage, for: .normal)
        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        middleButton.setTitle(Const.okMessage, for: .normal)
        middleButton.sizeToFit()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        progressBar.setProgress(1/8, animated: true)
    }


    // Helpers

    @objc func start() {
        showNextPage()
    }


    func showNextPage() {
        if currentPageReal+1 > shuffledPagesByOrder.count {
            showResult()
            return
        }

        pageNumberLabel.text = """
        Is your number in list #\(currentPageReal+1)?
        """

        let noColorText = "\(prettifyPage(page: shuffledPagesByOrder[currentPageReal].value))"
        let coloredText = colorfy(label: noColorText)

        pageContentLabel.attributedText = coloredText

        leftButton.isHidden = false
        middleButton.isHidden = true
        rightButton.isHidden = false

        leftButton.setTitle(Const.noMessage, for: .normal)
        rightButton.setTitle(Const.yesMessage, for: .normal)

        leftButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)

        leftButton.addTarget(self, action: #selector(dontAddValue), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(addValue), for: .touchUpInside)
        leftButton.sizeToFit()
        rightButton.sizeToFit()
        progressBar.setProgress(progressBar.progress+1/8, animated: true)
    }


    @objc func addValue() {
        userNumber += shuffledPagesByOrder[currentPageReal].key
        currentPageReal += 1
        showNextPage()
    }


    @objc func dontAddValue() {
        currentPageReal += 1
        showNextPage()
    }


    @objc func showResult() {
        pageContentLabel.text = ""

        pageNumberLabel.attributedText = attrifyString(
            preString: "You thought:\n\n", toAttrify: "\(userNumber)", color: myThemeColor)

        leftButton.isHidden = true
        middleButton.isHidden = false
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        middleButton.setTitle(Const.correctMessage, for: .normal)
        middleButton.sizeToFit()
        progressBar.setProgress(1, animated: true)
    }


    func prettifyPage(page: [Int]) -> String {
        var newPage = ""
        for number in page {
            var tempNumber = "\(number)"
            if tempNumber.count == 1 {
                tempNumber = "  \(tempNumber)"
            }
            newPage.append("  \(tempNumber)  |")
        }
        return newPage
    }


    func colorfy(label: String) -> NSMutableAttributedString {
        let aNSAttrString = NSMutableAttributedString(string: "")
        for letter in label.unicodeScalars {
            let myLetter: NSAttributedString
            if CharacterSet.decimalDigits.contains(letter) {
                myLetter = NSAttributedString(
                    string: "\(letter)",
                    attributes: [NSAttributedString.Key.foregroundColor: colorsArray[ Int("\(letter)")!]])
            } else {
                myLetter = NSAttributedString(string: "\(letter)")
            }

            aNSAttrString.append(myLetter)
        }
        return aNSAttrString
    }


    // MARK: Actions

    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }


}
