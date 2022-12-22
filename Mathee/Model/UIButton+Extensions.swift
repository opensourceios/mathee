//
//  UIButton+Extensions.swift
//  Mathee
//
//  Created by dani on 10/24/22.
//  Copyright © 2022 Dani Springer. All rights reserved.
//

import UIKit

extension UIButton {

    func setTitleNew(_ title: String) {

        let oldFont: UIFont = self.configuration!.attributedTitle!.font ??
        UIFont.preferredFont(forTextStyle: .largeTitle)

        self.configurationUpdateHandler = { button in
            button.configuration!.attributedTitle = AttributedString(
                title, attributes: AttributeContainer([.font: oldFont]))
        }
    }

}
