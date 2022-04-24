//
//  MagicViewController.swift
//  Matemagica
//
//  Created by Daniel Springer on 05/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


class MagicViewController: UIViewController {


    // MARK: Outlets

    @IBOutlet weak var headerLabel: UILabel!

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!


    // MARK: Properties

    var myTitle: String!
    let myThemeColor: UIColor = .systemRed


    // MARK: Life Cicle

    override func viewDidLoad() {
        super.viewDidLoad()

        leftButton.isHidden = true
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        middleButton.setTitle(Const.Misc.okMessage, for: .normal)
        middleButton.sizeToFit()

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)

        headerLabel.text = """
        Think of a number.
        Prepare to be amazed.
        """
    }


    // MARK: Helpers

    @objc func play() {
        headerLabel.text = """
        Let's call the number you thought \"A\".
        Add 10 to A
        """

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(combineFirst), for: .touchUpInside)
        middleButton.setTitle(Const.Misc.okMessage, for: .normal)
        middleButton.sizeToFit()
    }


    @objc func combineFirst() {
        headerLabel.text = """
        Let's call the result of A + 10, "B".
        Combine the digits of B.
        For example, if B is 24, do 2 + 4, and you get 6
        """

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(subtract), for: .touchUpInside)
        middleButton.setTitle(Const.Misc.okMessage, for: .normal)
        middleButton.sizeToFit()
    }


    @objc func subtract() {
        headerLabel.text = """
        Let's call the result of B's combined digits "C".
        Do B - C.
        For example, if you had 24 and got 6, do 24 - 6, and you get 18
        """

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(checkFirst), for: .touchUpInside)
        middleButton.setTitle(Const.Misc.okMessage, for: .normal)
        middleButton.sizeToFit()
    }


    @objc func checkFirst() {
        headerLabel.text = """
        Let's call the result of B - C, \"D\".
        Is D a single digit?
        """
        let yesButton = UIBarButtonItem(
            title: Const.Misc.yesMessage,
            style: .plain,
            target: self,
            action: #selector(showResultFirst))
        let noButton = UIBarButtonItem(
            title: Const.Misc.noMessage,
            style: .plain,
            target: self,
            action: #selector(combineSecond))

        leftButton.isHidden = false
        middleButton.isHidden = true
        rightButton.isHidden = false

        leftButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        leftButton.addTarget(self, action: #selector(combineSecond), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(showResultFirst), for: .touchUpInside)
        rightButton.setTitle(Const.Misc.yesMessage, for: .normal)
        leftButton.setTitle(Const.Misc.noMessage, for: .normal)
        leftButton.sizeToFit()
        rightButton.sizeToFit()

    }


    @objc func combineSecond() {
        headerLabel.text =
        """
        Combine the digits of D. For example, if D is 24, do 2 + 4, and you get 6
        """

        leftButton.isHidden = true
        middleButton.isHidden = false
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(checkForever), for: .touchUpInside)
        middleButton.setTitle(Const.Misc.okMessage, for: .normal)
        middleButton.sizeToFit()
    }


    @objc func checkForever() {
        headerLabel.text = "Is the new result a single digit?"

        leftButton.isHidden = false
        middleButton.isHidden = true
        rightButton.isHidden = false

        leftButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        leftButton.addTarget(self, action: #selector(combineForever), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(showResultFinally), for: .touchUpInside)
        rightButton.setTitle(Const.Misc.yesMessage, for: .normal)
        leftButton.setTitle(Const.Misc.noMessage, for: .normal)
        leftButton.sizeToFit()
        rightButton.sizeToFit()
    }


    @objc func combineForever() {
        headerLabel.text =
        """
        Combine the result's digits. For example, if your result is 24, do 2 + 4, and get 6
        """

        leftButton.isHidden = true
        middleButton.isHidden = false
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(checkForever), for: .touchUpInside)
        middleButton.setTitle(Const.Misc.okMessage, for: .normal)
        middleButton.sizeToFit()
    }


    @objc func showResultFirst() {
        headerLabel.text = "D is 9"

        leftButton.isHidden = true
        middleButton.isHidden = false
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        middleButton.setTitle(Const.Misc.endMessage, for: .normal)
        middleButton.sizeToFit()
    }


    @objc func showResultFinally() {
        headerLabel.text = "It's 9"

        leftButton.isHidden = true
        middleButton.isHidden = false
        rightButton.isHidden = true

        middleButton.removeTarget(nil, action: nil, for: .allEvents)
        middleButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        middleButton.setTitle(Const.Misc.endMessage, for: .normal)
        middleButton.sizeToFit()
    }


    @objc func done() {
        navigationController?.popToRootViewController(animated: true)
    }

}
