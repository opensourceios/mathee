//
//  FindLargestViewController.swift
//  Mathee
//
//  Created by Gaurang Gunde on 4/19/24.
//  Copyright © 2024 Daniel Springer. All rights reserved.
//

import UIKit
 
class FindLargestViewController: UIViewController, UICollectionViewDelegate,
                          UICollectionViewDataSource {


    // MARK: Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var pageNumberLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var rightButton: UIButton!


    // MARK: Properties

    var myTitle: String!

    struct Page {
        let key: Int
        let value: [Int]
    }

    let pagesArrayOfDicts = [
        1: [1, 0, 1, 0, 1, 0,
            1, 1, 0, 1, 1, 1,
            1, 0, 1, 1]]

    var arrayOfPages = [Page]()
    var shuffledPagesByContent = [Page]()
    var shuffledPagesByOrder = [Page]()
    var userNumber = 0
    var currentPageReal = 0

    var currentPageDataSource: [Int] = []

    var myThemeColor: UIColor!

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

        if CommandLine.arguments.contains("--matheeScreenshots") {
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

        headerLabel.text = """
        Think of a number from 1 to 31

        Tell me whether you spot your number in the following \(pagesArrayOfDicts.count) lists
        """
        myCollectionView.isHidden = true
       

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

        headerLabel.text = """
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
        myCollectionView.isHidden = false
        
        var matrix = [[1, 0, 1, 0], [1, 0, 0, 1], [0, 1, 0, 1], [1, 0, 1, 0]]
        for r in Range(0...3) {
            for c in Range(0...3) {
                let cell = myCollectionView.cellForItem(at: IndexPath(row: r * 4 + c, section: 0)) as! SpotItCell
                let text = cell.myLabel.text
                let value = Int(text!) ?? 0
                matrix[r][c] = value
            }
        }
        
        var color: UIColor
        let (area, min_coord, max_coord) = max_area(matrix: matrix)
        for coord in Range(0...min_coord.count - 1){
            color = colorsArray[coord]
            for i in Range(min_coord[coord][0]...max_coord[coord][0]) {
                for j in Range(min_coord[coord][1]...max_coord[coord][1]) {
                    let cell_max = myCollectionView.cellForItem(at: IndexPath(row: (i * 4 + j), section: 0)) as! SpotItCell
                    cell_max.backgroundColor = color
                    cell_max.doGlowAnimation(withColor: color)
                }
            }
        }
        headerLabel.attributedText = attrifyString(
            preString: "Total Maximum Area:\n\n", toAttrify: "\(area)", postString: nil,
            color: myThemeColor)

        leftButton.isHidden = true
        middleButton.isHidden = false
        middleButton.doGlowAnimation(withColor: myThemeColor)
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        middleButton.setTitleNew(Const.doneMessage)
        middleButton.sizeToFit()
    }


    // MARK: Actions

    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func toggleRectangle() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: Collection Delegate

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return currentPageDataSource.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.spotItCell,
                                                      for: indexPath) as! SpotItCell

        cell.myLabel.text = "\(currentPageDataSource[indexPath.row])"
        cell.myLabel.textColor = .black
        cell.layer.cornerRadius = cell.frame.size.width / 2

        return cell
    }

    func max_area (matrix: [[Int]]) -> (Int, [[Int]], [[Int]]) {
        let rows = matrix.count
        let cols = matrix[0].count
        
        var maxArea = -1
        var min_coord = [[Int]]()
        var max_coord = [[Int]]()
        for x1 in Range(0...(rows - 1)) {
            for y1 in Range(0...(cols - 1)) {
                for x2 in Range(x1...(rows - 1)) {
                    for y2 in Range(y1...(cols - 1)) {
                        print(x1, y1, x2, y2)
                        let area = is_rectangle(matrix: matrix, x1: x1, y1: y1, x2: x2, y2: y2)
                        if area > maxArea {
                            maxArea = area
                            min_coord = [[x1, y1]]
                            max_coord = [[x2, y2]]
                        } else if area == maxArea {
                            min_coord.append([x1, y1])
                            max_coord.append([x2, y2])
                        }
                    }
                }
            }
        }
        
        print(maxArea)
        print(min_coord)
        print(max_coord)
        
        return (maxArea, min_coord, max_coord)
    }
    
    func is_rectangle (matrix: [[Int]], x1:Int, y1:Int, x2:Int, y2:Int) -> Int {
        var area = 0
        for i in Range(x1...x2) {
            for j in Range(y1...y2) {
                if matrix[i][j] == 0 {
                    return 0
                } else {
                    area = area + 1
                }
            }
        }
        
        return area
    }
}
