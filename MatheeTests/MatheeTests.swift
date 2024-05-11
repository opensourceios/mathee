//
//  MatheeTests.swift
//  MatheeTests
//
//  Created by Gaurang Gunde on 5/10/24.
//  Copyright © 2024 Daniel Springer. All rights reserved.
//

import XCTest
@testable import Mathee

final class MatheeTests: XCTestCase {

    var largestAreController: FindLargestAreaViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        largestAreController = storyboard.instantiateViewController(
            withIdentifier: "FindLargestAreaViewController") as? FindLargestAreaViewController
        largestAreController.myTitle = "cell.myLabel!.text"
        largestAreController
            .myThemeColor = UIColor.red
    }

    override func tearDownWithError() throws {
        largestAreController = nil
    }
    
   
    func testMaxAreaWithOneArea() throws {
        let matrix = [[1,0], [0,0]]
        let (maxArea, min_coords, max_coords) = largestAreController.max_area(matrix: matrix)
        
        XCTAssertEqual(maxArea, 1)
        XCTAssertEqual(min_coords, [[0, 0]])
        XCTAssertEqual(max_coords, [[0, 0]])
    }
    
    func testMaxAreaWithSingleAnswer() throws {
        let matrix = [[1,1,1,0], [0,0,1,0], [0,0,0,0], [0,0,0,0]]
        let (maxArea, min_coords, max_coords) = largestAreController.max_area(matrix: matrix)
        
        XCTAssertEqual(maxArea, 3)
        XCTAssertEqual(min_coords, [[0, 0]])
        XCTAssertEqual(max_coords, [[0, 2]])
    }

    func testMaxAreaWithMultipleAnswers() throws {
        let matrix = [[1,1,1,1], [0,1,1,0], [0,0,0,0], [0,0,0,0]]
        let (maxArea, min_coords, max_coords) = largestAreController.max_area(matrix: matrix)
        
        XCTAssertEqual(maxArea, 4)
        XCTAssertEqual(min_coords, [[0, 0], [0, 1]])
        XCTAssertEqual(max_coords, [[0, 3], [1, 2]])
    }
    
    func testMaxAreaWithZeroAreaWithMultipleAnswers() throws {
        let matrix = [[0,0], [0,0]]
        let (maxArea, min_coords, max_coords) = largestAreController.max_area(matrix: matrix)
        
        XCTAssertEqual(maxArea, 0)
        XCTAssertEqual(min_coords, [[0, 0], [0, 0], [0, 0], [0, 0], [0, 1], [0, 1], [1, 0], [1, 0], [1, 1]])
        XCTAssertEqual(max_coords, [[0, 0], [0, 1], [1, 0], [1, 1], [0, 1], [1, 1], [1, 0], [1, 1], [1, 1]])
    }
    
    // Negative Test Case
    func testMaxAreaWithEmptyMatrix() throws {
        let matrix = [[Int]]()
        let (maxArea, min_coords, max_coords) = largestAreController.max_area(matrix: matrix)
        
        XCTAssertEqual(maxArea, -1)
        XCTAssertEqual(min_coords, [[]])
        XCTAssertEqual(max_coords, [[]])
    }
    
    
    func testIsRectangleWhenAreaIs4() throws {
        let matrix = [[1,1,1,1], [0,1,1,0], [0,0,0,0], [0,0,0,0]]
        let x1 = 0
        let x2 = 0
        let y1 = 0
        let y2 = 3
        
        let area = largestAreController.is_rectangle(matrix: matrix, x1: x1, y1: y1, x2: x2, y2: y2)
        
        XCTAssertEqual(area, 4)
    }
    
    func testIsRectangleWhenAreaIs0() throws {
        let matrix = [[0,0], [0,0]]
        let x1 = 0
        let x2 = 1
        let y1 = 0
        let y2 = 1
        
        let area = largestAreController.is_rectangle(matrix: matrix, x1: x1, y1: y1, x2: x2, y2: y2)
        
        XCTAssertEqual(area, 0)
    }
    
    // Negative Test Case
    func testIsRectangleWhenMatrixIsEmpty() throws {
        let matrix = [[Int]]()
        let x1 = 0
        let x2 = 0
        let y1 = 0
        let y2 = 0
        
        let area = largestAreController.is_rectangle(matrix: matrix, x1: x1, y1: y1, x2: x2, y2: y2)
        
        XCTAssertEqual(area, -1)
    }
    

}
