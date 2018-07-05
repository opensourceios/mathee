//
//  MagicViewController.swift
//  Guess My Number Fun
//
//  Created by Dani Springer on 05/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import Foundation
import UIKit

class MagicViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var myToolbar: UIToolbar!
    
    
    
    // MARK: Properties
    
    
    
    
    // MARK: Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let okButton = UIBarButtonItem(title: "👌", style: .plain, target: self, action: #selector(play))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }
    
    
    // MARK: Helpers
    
    @objc func play() {
        headerLabel.text = "Add 10"
        
        let okButton = UIBarButtonItem(title: "👌", style: .plain, target: self, action: #selector(combineInitial))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }
    
    
    @objc func combineInitial() {
        headerLabel.text = "Combine the result's digits. For example, if your number is now 214, do 2 + 1 + 4, and you have a new result of 7."
        
        let okButton = UIBarButtonItem(title: "👌", style: .plain, target: self, action: #selector(subtract))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }
    
    
    @objc func subtract() {
        headerLabel.text = "Subtract the new result from the old one. For example, if you had 214 and got 7, do 214 - 7, and you have a new result of 207."
        
        let okButton = UIBarButtonItem(title: "👌", style: .plain, target: self, action: #selector(check))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }
    
    
    @objc func check() {
        headerLabel.text = "Is the result a single digit?"
        let yesButton = UIBarButtonItem(title: "Yes", style: .plain, target: self, action: #selector(showResult))
        let noButton = UIBarButtonItem(title: "No", style: .plain, target: self, action: #selector(combineRepeated))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([yesButton, space, noButton], animated: true)
    }
    
    
    @objc func combineRepeated() {
        headerLabel.text = "Combine the result's digits. For example, if your number is now 214, do 2 + 1 + 4, and you have a new result of 7."
        
        let okButton = UIBarButtonItem(title: "👌", style: .plain, target: self, action: #selector(check))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
    }
    
    
    @objc func showResult() {
        headerLabel.text = "9"
        let okButton = UIBarButtonItem(title: "🎉", style: .plain, target: self, action: #selector(done))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton, space], animated: true)
    }
    
    @objc func done() {
        navigationController?.popToRootViewController(animated: true)
    }
}
