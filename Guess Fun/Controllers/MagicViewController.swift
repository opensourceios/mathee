//
//  MagicViewController.swift
//  Guess Fun
//
//  Created by Dani Springer on 05/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import UIKit
import StoreKit

class MagicViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!


    // MARK: Life Cicle

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

        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)

        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(play))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    // MARK: Helpers

    @objc func play() {
        headerLabel.text = "Let's call the number you thought \"A\".\nAdd 10 to A."

        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(combineFirst))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func combineFirst() {
        headerLabel.text = """
        Let's call the result of A + 10, "B".\nCombine the digits of B.\nFor example, \
        if B is 214, do 2 + 1 + 4, and you get 7.
        """

        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(subtract))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func subtract() {
        headerLabel.text = """
        Let's call the result of B's combined digits "C".\nDo B - C.\nFor example, \
        if you had 214 and got 7, do 214 - 7, and you get 207.
        """

        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(checkFirst))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func checkFirst() {

        headerLabel.text = "Let's call the result of B - C, \"D\".\nIs D a single digit?"
        let yesButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(showResultFirst))
        let noButton = UIBarButtonItem(title: "👎", style: .plain, target: self, action: #selector(combineSecond))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([yesButton, space, noButton], animated: true)
    }


    @objc func combineSecond() {
        headerLabel.text = "Combine the digits of D. For example, if D is 214, do 2 + 1 + 4, and you get 7."

        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(checkForever))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func checkForever() {
        headerLabel.text = "Is the new result a single digit?"

        let yesButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(showResultForever))
        let noButton = UIBarButtonItem(title: "👎", style: .plain, target: self, action: #selector(combineForever))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([yesButton, space, noButton], animated: true)

    }


    @objc func combineForever() {
        headerLabel.text = "Combine the result's digits. For example, if your result is 214, do 2 + 1 + 4, and get 7."

        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(checkForever))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }


    @objc func showResultFirst() {
        headerLabel.text = "D is 9"
        let okButton = UIBarButtonItem(title: "🎉", style: .plain, target: self, action: #selector(done))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton, space], animated: true)
    }


    @objc func showResultForever() {
        headerLabel.text = "It's 9"
        let okButton = UIBarButtonItem(title: "🎉", style: .plain, target: self, action: #selector(done))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton, space], animated: true)
    }


    @objc func done() {
        navigationController?.popToRootViewController(animated: true)
        SKStoreReviewController.requestReview()
    }

}
