//
//  UILabel+Extensions.swift
//  Matemagica
//
//  Created by dani on 10/16/22.
//  Copyright © 2022 Dani Springer. All rights reserved.
//

import UIKit

extension UILabel {
    func countAnimation(upto: Double) {
        let fromString = text?.replacingOccurrences(of: "Score: ", with: "")
        let from: Double = fromString?.replacingOccurrences(of: ",", with: ".")
            .components(separatedBy: CharacterSet.init(charactersIn: "-0123456789.").inverted)
            .first.flatMap { Double($0) } ?? 0.0
        //      let steps: Int = 50
        let duration = 0.4
        let diff = upto - from
        let rate = duration / diff
        for item in 0...Int(diff) {
            DispatchQueue.main.asyncAfter(deadline: .now() + rate * Double(item)) {
                self.text = "Score: \(Int(from + diff * (Double(item) / diff)))"
            }
        }
    }
}
