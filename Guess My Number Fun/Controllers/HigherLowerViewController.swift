//
//  HigherLowerViewController.swift
//  Guess My Number Fun
//
//  Created by Dani Springer on 05/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import Foundation
import UIKit

class HigherLowerViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var myToolbar: UIToolbar!
    
    
    
    // MARK: Properties
    
    var high = 2000
    var low = 1
    var guess = 0
    var diff = 0
    var half_diff = 0
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.isHidden = true
        guessLabel.isHidden = true
        
        let okButton = UIBarButtonItem(title: "👌", style: .plain, target: self, action: #selector(showNextGuess))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }
    
    
    // MARK: Helpers
    
    @objc func showNextGuess() {
        
        diff = high - low
        half_diff = diff / 2
        guess = low + half_diff
        
        headerLabel.isHidden = true
        
        guessLabel.isHidden = false
        guessLabel.text = "Is it \(guess)?"
        
        let lowerButton = UIBarButtonItem(title: "👇", style: .plain, target: self, action: #selector(lower))
        let higherButton = UIBarButtonItem(title: "👆", style: .plain, target: self, action: #selector(higher))
        let yesButton = UIBarButtonItem(title: "🎉", style: .plain, target: self, action: #selector(correct))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([lowerButton, space, yesButton, space, higherButton], animated: true)
    }
    
    @objc func lower() {
        high = guess
        showNextGuess()
    }
    
    @objc func higher() {
        low = guess
        showNextGuess()
    }
    
    @objc func correct() {
        print("Correct!")
        myToolbar.isHidden = true
        guessLabel.text = "\(guess)... Nice choice!"
        doneButton.isHidden = false
    }
    
    // MARK: Action
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}





