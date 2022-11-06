//
//  BookViewController.swift
//  Math Magic
//
//  Created by Daniel Springer on 04/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


class BookViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    // MARK: Outlets

    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var myCollectionView: UICollectionView!


    // MARK: Properties

    var myTitle: String!

    struct Page {
        let key: Int
        let value: [Int]
    }

    let pagesArrayOfDicts = [
        1: [1, 3, 5, 7, 9, 11,
            13, 15, 17, 19, 21, 23,
            25, 27, 29, 31],
        2: [2, 3, 6, 7, 10, 11,
            14, 15, 18, 19, 22, 23,
            26, 27, 30, 31],
        4: [4, 5, 6, 7, 12, 13,
            14, 15, 20, 21, 22, 23,
            28, 29, 30, 31],
        8: [8, 9, 10, 11, 12, 13,
            14, 15, 24, 25, 26, 27,
            28, 29, 30, 31],
        16: [16, 17, 18, 19, 20, 21,
             22, 23, 24, 25, 26, 27,
             28, 29, 30, 31]]

    var arrayOfPages = [Page]()
    var shuffledPagesByContent = [Page]()
    var shuffledPagesByOrder = [Page]()
    var userNumber = 0
    var currentPageReal = 0

    var currentPageDataSource: [Int] = []

    var myThemeColor: UIColor!

    let possibleDigits = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let colorsArray: [UIColor] = [
        .systemOrange,
        .systemTeal,
        .systemGreen,
        .systemBlue,
        .systemIndigo,
        .systemPurple
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
        Think of a number from 1 to 31

        Tell me whether you spot your number in the following \(pagesArrayOfDicts.count) lists
        """
        myCollectionView.isHidden = true

        progressBar.setProgress(0, animated: false)

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        leftButton.isHidden = true
        middleButton.isHidden = false
        middleButton.doGlowAnimation(withColor: myThemeColor)
        rightButton.isHidden = true

        middleButton.setTitleNew(Const.okMessage)
        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        middleButton.setTitleNew(Const.okMessage)
        middleButton.sizeToFit()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        progressBar.setProgress(1/8, animated: true)
    }


    // Helpers

    @objc func start() {
        myCollectionView.isHidden = false
        showNextPage()
    }


    func showNextPage() {
        if currentPageReal+1 > shuffledPagesByOrder.count {
            showResult()
            return
        }

        pageNumberLabel.text = """
        Is your number in list \(currentPageReal+1) of \(pagesArrayOfDicts.count)?
        """

        currentPageDataSource = shuffledPagesByOrder[currentPageReal].value
        myCollectionView.reloadData()

        leftButton.isHidden = false
        leftButton.doGlowAnimation(withColor: myThemeColor)
        middleButton.isHidden = true
        rightButton.isHidden = false
        rightButton.doGlowAnimation(withColor: myThemeColor)

        leftButton.setTitleNew(Const.noMessage)
        rightButton.setTitleNew(Const.yesMessage)

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
        myCollectionView.isHidden = true

        pageNumberLabel.attributedText = attrifyString(
            preString: "You thought:\n\n", toAttrify: "\(userNumber)", postString: nil, color: myThemeColor)

        leftButton.isHidden = true
        middleButton.isHidden = false
        middleButton.doGlowAnimation(withColor: myThemeColor)
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        middleButton.setTitleNew(Const.correctMessage)
        middleButton.sizeToFit()
        progressBar.setProgress(1, animated: true)
    }


    // MARK: Actions

    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }


    // MARK: Collection Delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentPageDataSource.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.spotItCell,
                                                      for: indexPath) as! SpotItCell

        cell.myLabel.text = "\(currentPageDataSource[indexPath.row])"
        cell.backgroundColor = colorsArray[currentPageReal]
        cell.myLabel.textColor = .white
        cell.layer.cornerRadius = cell.frame.size.width / 2

        return cell
    }

}
