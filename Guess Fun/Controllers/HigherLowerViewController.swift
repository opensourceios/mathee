//
//  HigherLowerViewController.swift
//  Guess Fun
//
//  Created by Dani Springer on 05/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import UIKit
import StoreKit

class HigherLowerViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    
    
    
    // MARK: Properties
    
    var high = 2000
    var low = 0
    var guess = 0
    var diff = 0
    var half_diff = 0
    var tries = 0
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor : view.tintColor,
                ], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40),
                NSAttributedString.Key.foregroundColor : view.tintColor,
                ], for: .selected)
                
        myToolbar.setBackgroundImage(UIImage(),
                                     forToolbarPosition: .any,
                                     barMetrics: .default)
        myToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        guessLabel.isHidden = true
        
        let okButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(showNextGuess))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }
    
    
    // MARK: Helpers
    
    @objc func showNextGuess() {
        
        diff = high - low
        
        if diff == 3 {
            half_diff = 2
        } else {
            half_diff = diff / 2
        }
        
        guess = low + half_diff
        
        headerLabel.isHidden = true
        
        guessLabel.isHidden = false
        guessLabel.text = "Is it \(guess)?"
        
        let lowerButton = UIBarButtonItem(title: "👇", style: .plain, target: self, action: #selector(lower))
        let higherButton = UIBarButtonItem(title: "👆", style: .plain, target: self, action: #selector(higher))
        let yesButton = UIBarButtonItem(title: "👍", style: .plain, target: self, action: #selector(correct))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        if half_diff == 1 {
            guessLabel.text = "You thought: \(guess)"
            tries -= 1 // so adding a guess in correct() doesn't incorrect it
            myToolbar.setItems([space, yesButton, space], animated: true)
        } else {
            myToolbar.setItems([lowerButton, space, yesButton, space, higherButton], animated: true)
        }
        
    }
    
    @objc func lower() {
        tries += 1
        high = guess
        showNextGuess()
    }
    
    @objc func higher() {
        tries += 1
        low = guess
        showNextGuess()
    }
    
    @objc func correct() {
        tries += 1

        if tries == 1 {
            guessLabel.text = "\(guess)... That was easy. It took me just one try!"
        } else if tries < 6 {
            guessLabel.text = "\(guess)... Not too hard. It only took me \(tries) tries!"
        } else if tries <= 10 {
            guessLabel.text = "\(guess)... Pretty, pretty, pretty good! That took me no less than \(tries) tries!"
        } else {
            guessLabel.text = "\(guess)... \(tries) tries! You won. You're a champion! (Please let the developer know with what number you got here! 🏆)"
        }
        
        let doneButton = UIBarButtonItem(title: "🎉", style: .plain, target: self, action: #selector(doneButtonPressed))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, doneButton, space], animated: true)
    }
    
    // MARK: Action
    
    @objc func doneButtonPressed() {
        
        SKStoreReviewController.requestReview()
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}





