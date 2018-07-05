//
//  CardsViewController.swift
//  Guess My Number Fun
//
//  Created by Dani Springer on 04/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import Foundation
import UIKit

class CardsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardContentLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var myToolbar: UIToolbar!
    
    
    // MARK: Properties
    
    struct Card {
        let key: Int
        let value: [Int]
    }
    
    let cardsArrayOfDicts = [
        1: [1, 3, 5, 7, 9, 11,
         13, 15, 17, 19, 21, 23,
         25, 27, 29, 31, 33, 35,
         37, 39, 41, 43, 45, 47,
         49, 51, 53, 55, 57, 59,
         61, 63],
        2: [2, 3, 6, 7, 10, 11,
         14, 15, 18, 19, 22, 23,
         26, 27, 30, 31, 34, 35,
         38, 39, 42, 43, 46, 47,
         50, 51, 54, 55, 58, 59,
         62, 63],
        4: [4, 5, 6, 7, 12, 13,
         14, 15, 20, 21, 22, 23,
         28, 29, 30, 31, 36, 37,
         38, 39, 44, 45, 46, 47,
         52, 53, 54, 55, 60, 61,
         62, 63],
        8: [8, 9, 10, 11, 12, 13,
         14, 15, 24, 25, 26, 27,
         28, 29, 30, 31, 40, 41,
         42, 43, 44, 45, 46, 47,
         56, 57, 58, 59, 60, 61,
         62, 63],
        16: [16, 17, 18, 19, 20, 21,
         22, 23, 24, 25, 26, 27,
         28, 29, 30, 31, 48, 49,
         50, 51, 52, 53, 54, 55,
         56, 57, 58, 59, 60, 61,
         62, 63],
        32: [32, 33, 34, 35, 36, 37,
         38, 39, 40, 41, 42, 43,
         44, 45, 46, 47, 48, 49,
         50, 51, 52, 53, 54, 55,
         56, 57, 58, 59, 60, 61,
         62, 63]]
    
    var arrayOfCards = [Card]()
    
    var shuffledCardsByContent = [Card]()
    
    var shuffledCardsByOrder = [Card]()
    
    var userNumber = 0
    
    enum userOptions: String {
        case yes = "yes"
        case no = "no"
        case none = "none"
    }
    
    var userSelection = "nil"
    
    var currentCardFake = 1
    var currentCardReal = 0
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.isHidden = true
        doneButton.isHidden = true
        
        for card in cardsArrayOfDicts {
            arrayOfCards.append(Card(key: card.key, value: card.value))
        }
        
        for card in arrayOfCards {
            let shuffledCardContent = card.value.shuffled()
            shuffledCardsByContent.append(Card(key: card.key, value: shuffledCardContent))
        }
        
        shuffledCardsByOrder = shuffledCardsByContent.shuffled()
        
        
        cardNumberLabel.text = "Think of a number 1-63"
        cardContentLabel.text = ""
        
        // TODO OK
        let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(showNextCard))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([space, okButton], animated: true)
        
    }
    
    
    // Helpers
    
    
    @objc func showNextCard() {
        if currentCardFake > shuffledCardsByOrder.count {
            showResult()
            return
        }
        cardNumberLabel.text = "Is your number in card #\(currentCardFake)?"
        cardContentLabel.text = "\(shuffledCardsByOrder[currentCardReal].value)"
        
        let yesButton = UIBarButtonItem(title: "Yes", style: .plain, target: self, action: #selector(addValue))
        let noButton = UIBarButtonItem(title: "No", style: .plain, target: self, action: #selector(dontAddValue))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        myToolbar.setItems([yesButton, space, noButton], animated: true)
        
    }
    
    @objc func addValue() {
        // add value
        userNumber += shuffledCardsByOrder[currentCardReal].key
        currentCardFake += 1
        currentCardReal += 1
        showNextCard()
    }
    
    @objc func dontAddValue() {
        currentCardFake += 1
        currentCardReal += 1
        showNextCard()
    }
    
    @objc func showResult() {
        
        cardContentLabel.text = ""
        myToolbar.isHidden = true
        cardNumberLabel.text = "You thought:"
        resultLabel.text = "\(userNumber)"
        resultLabel.isHidden = false
        doneButton.isHidden = false
    }
    
    // MARK: Actions
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

//            // show alert
//
//            let myAlert = UIAlertController(title: "Is your number in card #\(currentCard)?", message: "\(card)", preferredStyle: .alert)
//            let yesOption = UIAlertAction(title: "Yes", style: .default, handler: {action in
//                self.addValue()
//            })
//            let noOption = UIAlertAction(title: "No", style: .default, handler: nil)
//            myAlert.addAction(yesOption)
//            myAlert.addAction(noOption)
//
//            DispatchQueue.main.async {
//                self.present(myAlert, animated: true)
//
//            }
