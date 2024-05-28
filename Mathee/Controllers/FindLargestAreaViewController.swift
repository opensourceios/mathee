//
//  FindLargestAreaViewController.swift
//  Mathee
//
//  Created by Gaurang Gunde on 4/19/24.
//  Copyright © 2024 Daniel Springer. All rights reserved.
//

import UIKit
 
class FindLargestAreaViewController: UIViewController, UICollectionViewDelegate,
                          UICollectionViewDataSource {


    // MARK: Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!



    // MARK: Properties

    var myTitle: String!
    var myThemeColor: UIColor!
    
    var setOfOnesAndZeros = [
        1, 0, 1, 0,
        1, 0, 1, 1,
        0, 1, 1, 1,
        1, 0, 1, 1
    ]

    let colorsArray: [UIColor] = [
        .systemOrange,
        .systemTeal,
        .systemGreen,
        .systemBlue,
        .systemIndigo,
        .systemPurple
    ]

    // Global Variables to store our answers
    var index = 0
    var min_coords = [[Int]]()
    var max_coords = [[Int]]()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if CommandLine.arguments.contains("--matheeScreenshots") {
            // We are in testing mode, make arrangements if needed
            UIView.setAnimationsEnabled(false)
        }

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)
        
        setOfOnesAndZeros = setOfOnesAndZeros.shuffled()
        
        myCollectionView.isHidden = true
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myCollectionView.isHidden = false
        showNextPage()
    }


    // Helpers

    func showNextPage() {
        headerLabel.text = """
        Find the largest area of rectangle formed by 1's
        """

        myCollectionView.reloadData()
        
        leftButton.isHidden = true
        rightButton.isHidden = true
        
        leftButton.setTitleNew(Const.emptyMessage)
        rightButton.setTitleNew(Const.emptyMessage)

        middleButton.isHidden = false
        middleButton.setTitleNew(Const.showAnswer)
        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(showResult), for: .touchUpInside)
        middleButton.sizeToFit()
    }

    // MARK: Actions

    @objc func showResult() {
        myCollectionView.isHidden = false
        
        let matrix = convert_cell_views_to_array()
        
        let (area, min_coords_returned, max_coords_returned) = max_area(matrix: matrix)
        
        // Set global data structures with answers
        min_coords = min_coords_returned
        max_coords = max_coords_returned
        
        // Display answer on the grid and text box
        headerLabel.attributedText = attrifyString(
            preString: "Largest Area:\n\n", toAttrify: "\(area)", postString: nil,
            color: myThemeColor)

        highlight_answer()
        
        // Prepare Exit Button
        leftButton.isHidden = false
        leftButton.removeTarget(nil, action: nil, for: .allEvents)
        leftButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        leftButton.setTitleNew(Const.exitMessage)
        leftButton.layer.removeAllAnimations()
        leftButton.sizeToFit()
        
        // Prepare Play Again Button
        middleButton.isHidden = false
        middleButton.doGlowAnimation(withColor: myThemeColor)
        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(playAgainButtonPressed), for: .touchUpInside)
        middleButton.setTitleNew(Const.playAgainMessage)
        middleButton.sizeToFit()
        
        // If more than one answer exists, show the rightmost button
        rightButton.isHidden = true
        if min_coords.count > 1 {
            rightButton.isHidden = false
            rightButton.removeTarget(nil, action: nil, for: .allEvents)
            rightButton.addTarget(self, action: #selector(cycleMaximumAreaOptions), for: .touchUpInside)
            rightButton.setTitleNew(Const.toggleAnswersMessage)
            rightButton.sizeToFit()
        }
    }


    @objc func playAgainButtonPressed() {
        navigationController?.popViewController(animated: true)
        
        // Recreate controller for storyboard because we want to play again
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(
            withIdentifier: "FindLargestAreaViewController") as! FindLargestAreaViewController
        controller.myTitle = self.myTitle
        controller
            .myThemeColor = self.myThemeColor
        
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func cycleMaximumAreaOptions() {
        // Cycle to next answer
        index = (index + 1) % min_coords.count

        clear_animations_and_color()
        highlight_answer()
    }
    
    // MARK: Collection Delegate

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return setOfOnesAndZeros.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.spotItCell,
                                                      for: indexPath) as! SpotItCell

        cell.myLabel.text = "\(setOfOnesAndZeros[indexPath.row])"
        cell.myLabel.textColor = .black
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1

        return cell
    }

    // MARK: Business Rules
    
    func convert_cell_views_to_array () -> [[Int]] {
        var matrix = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
        for r in Range(0...3) {
            for c in Range(0...3) {
                let cell = myCollectionView.cellForItem(at: IndexPath(row: r * matrix.count + c, section: 0)) as! SpotItCell
                let text = cell.myLabel.text
                let value = Int(text!) ?? 0
                matrix[r][c] = value
            }
        }
        
        return matrix
    }
    
    func max_area (matrix: [[Int]]) -> (Int, [[Int]], [[Int]]) {
        if matrix.isEmpty {
            return (-1, [[]], [[]])
        }
        
        let rows = matrix.count
        let cols = matrix[0].count
        
        var maxArea = -1
        var min_coords = [[Int]]()
        var max_coords = [[Int]]()
        for x1 in Range(0...(rows - 1)) {
            for y1 in Range(0...(cols - 1)) {
                for x2 in Range(x1...(rows - 1)) {
                    for y2 in Range(y1...(cols - 1)) {
                        let area = is_rectangle(matrix: matrix, x1: x1, y1: y1, x2: x2, y2: y2)
                        if area > maxArea {
                            maxArea = area
                            min_coords = [[x1, y1]]
                            max_coords = [[x2, y2]]
                        } else if area == maxArea {
                            // Keep track of alternate maximum area answers
                            min_coords.append([x1, y1])
                            max_coords.append([x2, y2])
                        }
                    }
                }
            }
        }
        
        return (maxArea, min_coords, max_coords)
    }
    
    func is_rectangle (matrix: [[Int]], x1:Int, y1:Int, x2:Int, y2:Int) -> Int {
        if matrix.isEmpty {
            return -1
        }
        
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
    
    func highlight_answer () {
        for i in Range(min_coords[index][0]...max_coords[index][0]) {
            for j in Range(min_coords[index][1]...max_coords[index][1]) {
                let cell_max = myCollectionView.cellForItem(at: IndexPath(row: (i * 4 + j), section: 0)) as! SpotItCell
                cell_max.backgroundColor = colorsArray[index]
                cell_max.doGlowAnimation(withColor: colorsArray[index])
            }
        }
    }
    
    func clear_animations_and_color () {
        for cell in myCollectionView.visibleCells {
            let cell_max = cell as! SpotItCell
            cell_max.backgroundColor = .white
            cell_max.layer.removeAllAnimations()
        }
    }
}
