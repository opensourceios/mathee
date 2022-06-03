//
//  FormulaViewController.swift
//  Math Magic
//
//  Created by Daniel Springer on 01/07/2018.
//  Copyright © 2022 Daniel Springer. All rights reserved.
//

import UIKit


class FormulaViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!

    @IBOutlet weak var textfieldBottomConstraint: NSLayoutConstraint!


    // MARK: Properties

    var total = 0
    var isBeforeFirstEvenQuestion = true
    var myTitle: String!
    let myThemeColor: UIColor = .systemPurple

    var dispatchQueue: DispatchQueue?
    var dispatchWorkItem: DispatchWorkItem?

    var hasShownHelpButton = false

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if CommandLine.arguments.contains("--matemagicaScreenshots") {
            // We are in testing mode, make arrangements if needed
            UIView.setAnimationsEnabled(false)
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardNotification(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)

        self.title = self.myTitle
        setThemeColorTo(myThemeColor: myThemeColor)

        myTextField.borderStyle = .roundedRect
        myTextField.keyboardType = .numberPad
        myTextField.delegate = self
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        progressBar.setProgress(0.0, animated: false)
        start()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressBar.setProgress(0.1, animated: true)
    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }


    // Helpers

    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration: TimeInterval = (userInfo[
            UIResponder.keyboardAnimationDurationUserInfoKey
        ] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)

        if endFrameY >= UIScreen.main.bounds.size.height {
            self.textfieldBottomConstraint.constant = 0.0
        } else {
            self.textfieldBottomConstraint.constant = endFrame?.size.height ?? 0.0
        }

        UIView.animate(
            withDuration: duration,
            delay: TimeInterval(0),
            options: animationCurve,
            animations: { self.view.layoutIfNeeded() },
            completion: nil)
    }


    @objc func start() {
        total = 0
        isBeforeFirstEvenQuestion = true
        myTextField.text = ""
        messageLabel.text = """
        Think of a number
        """

        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(timesThree), for: .touchUpInside)
        rightButton.setTitle(Const.okMessage, for: .normal)
        leftButton.isHidden = true
        rightButton.sizeToFit()

        myTextField.isHidden = true
        showAnswerButton.isHidden = true
        infoButton.isHidden = true
    }


    @objc func timesThree() {
        messageLabel.text = "Multiply it by 3"
        rightButton.setTitle(Const.okMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(oddOrEven), for: .touchUpInside)
        rightButton.sizeToFit()
        if isBeforeFirstEvenQuestion {
            progressBar.setProgress(0.2, animated: true)
        } else {
            progressBar.setProgress(0.6, animated: true)
        }
    }


    @objc func oddOrEven() {
        messageLabel.text = "Is the result odd or even?"
        leftButton.isHidden = false
        leftButton.setTitle(Const.oddMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        leftButton.addTarget(self, action: #selector(addOne), for: .touchUpInside)
        rightButton.setTitle(Const.evenMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(divideByTwo), for: .touchUpInside)
        rightButton.sizeToFit()
        leftButton.sizeToFit()
        if isBeforeFirstEvenQuestion {
            progressBar.setProgress(0.3, animated: true)
        } else {
            progressBar.setProgress(0.7, animated: true)
        }

    }


    @objc func addOne() {
        // tell user to add one
        messageLabel.text = "Add 1 to the result"
        leftButton.isHidden = true
        rightButton.setTitle(Const.okMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(divideByTwo), for: .touchUpInside)
        rightButton.sizeToFit()

        if isBeforeFirstEvenQuestion {
            total += 1
            progressBar.setProgress(0.4, animated: true)
        } else {
            total += 2
            progressBar.setProgress(0.8, animated: true)
        }
    }


    @objc func divideByTwo() {
        messageLabel.text = "Divide the result by 2"
        leftButton.isHidden = true
        if isBeforeFirstEvenQuestion {
            rightButton.setTitle(Const.okMessage, for: .normal)
            rightButton.removeTarget(nil, action: nil, for: .allEvents)
            rightButton.addTarget(self, action: #selector(timesThree), for: .touchUpInside)
            isBeforeFirstEvenQuestion = false
            progressBar.setProgress(0.5, animated: true)
        } else {
            rightButton.setTitle(Const.okMessage, for: .normal)
            rightButton.removeTarget(nil, action: nil, for: .allEvents)
            rightButton.addTarget(self, action: #selector(divideByNine), for: .touchUpInside)
            progressBar.setProgress(0.9, animated: true)
        }
        rightButton.sizeToFit()

    }


    @objc func divideByNine() {
        // tell user to divide by nine
        messageLabel.text = """
        How many times does 9 fit in your result?
        """

        rightButton.isHidden = true
        // ask current result to user
        myTextField.isHidden = false
        showAnswerButton.isHidden = false
        someOnClickButtonStart()

        myTextField.becomeFirstResponder()
    }


    func someOnClickButtonStart() {
        self.dispatchQueue = DispatchQueue.global(qos: .background) // create queue
        self.dispatchWorkItem = DispatchWorkItem { // create work item
            // async code goes here
            DispatchQueue.main.async {
                UIView.transition(with: self.infoButton, duration: 0.4,
                                  options: .transitionCrossDissolve,
                                  animations: {
                    self.infoButton.isHidden = false
                    self.hasShownHelpButton = true
                })
            }
        }
        let seconds = hasShownHelpButton ? 0 : 6
        if self.dispatchWorkItem != nil {
            self.dispatchQueue?.asyncAfter(
                deadline: .now() + .seconds(seconds),
                execute: self.dispatchWorkItem!
            ) // schedule work item
        }
    }


    func someOnClickButtonCancel() {
        if let dispatchWorkItem = self.dispatchWorkItem {
            dispatchWorkItem.cancel() // cancel work item
        }
    }


    @objc func checkResult() {
        someOnClickButtonCancel()
        leftButton.isHidden = true
        guard let text = myTextField.text else {
            let alert = createAlert(alertReasonParam: .unknown)
            present(alert, animated: true)
            return
        }

        guard !text.isEmpty else {
            let alert = createAlert(alertReasonParam: .textfieldEmpty)
            present(alert, animated: true)
            return
        }

        let trimmedText = text.trimmingCharacters(in: .whitespaces)

        guard let number = Int(trimmedText),
              !number.multipliedReportingOverflow(by: 4).overflow else { // max allowed: 2305843009213693951
            let alert = createAlert(alertReasonParam: .nan)
            present(alert, animated: true)
            return
        }

        total += number * 4
        showResult()
    }


    @objc func showResult() {
        myTextField.isHidden = true
        showAnswerButton.isHidden = true
        infoButton.isHidden = true

        //        let regularAttributes: [NSAttributedString.Key: Any] = [
        //            .font: UIFont.preferredFont(forTextStyle: .body)]
        //        let jumboAttributes: [NSAttributedString.Key: Any] = [
        //            .font: UIFont.systemFont(ofSize: 100, weight: .semibold),
        //            .foregroundColor: myThemeColor]
        //        let attributedMessagePre = NSAttributedString(
        //            string: "You thought:\n\n",
        //            attributes: regularAttributes)
        //
        //        let attributedMessageJumbo = NSAttributedString(string: "\(total)", attributes: jumboAttributes)
        //
        //        let myAttributedText = NSMutableAttributedString()
        //
        //        myAttributedText.append(attributedMessagePre)
        //        myAttributedText.append(attributedMessageJumbo)

        messageLabel.attributedText = attrifyString(
            preString: "You thought:\n\n", toAttrify: "\(total)", color: myThemeColor)

        leftButton.isHidden = true
        rightButton.setTitle(Const.correctMessage, for: .normal)
        rightButton.removeTarget(nil, action: nil, for: .allEvents)
        rightButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        rightButton.sizeToFit()
        rightButton.isHidden = false
        progressBar.setProgress(1, animated: true)
    }


    @IBAction func okButtonKeyboardPressed() {
        myTextField.resignFirstResponder()
        checkResult()
    }


    @IBAction func helpPressed(_ sender: Any) {
        let alert = UIAlertController(
            title: "More Info",
            message:
            """
           Divide your result by 9, and type how many times 9 fits in it.
           Ignore leftover numbers. For example: if your result is 12, type 1 (ignoring the leftover 3)
           If your result is less than 9, type 0.
           """,
            preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: Const.okMessage, style: .cancel) { _ in
            self.myTextField.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    @objc func doneButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        okButtonKeyboardPressed()
        return true
    }

}
