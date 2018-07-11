//
//  MenuViewController.swift
//  Guess Fun
//
//  Created by Dani Springer on 05/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Outlets
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var aboutButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    
    // MARK: Properties
    
    let rowCount = CGFloat(4)
    var height = CGFloat(0)
    
    let cellsContent = ["📗", "✖️➗➕➖", "👆👇" , "🕘"]
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myFont = UIFont(name: "Chalkduster", size: 14.0) {
            for button in [aboutButton, shareButton] {
                button?.setTitleTextAttributes([NSAttributedStringKey.font: myFont], for: .normal)
                button?.setTitleTextAttributes([NSAttributedStringKey.font: myFont], for: .selected)
                button?.setTitleTextAttributes([NSAttributedStringKey.font: myFont], for: .highlighted)
            }
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self.myTableView,
                                               selector: #selector(myTableView.reloadData),
                                               name: .UIContentSizeCategoryDidChange,
                                               object: nil)

        
        let navHeight = navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        height = view.frame.height - navHeight! - statusBarHeight
        
        myTableView.separatorColor = UIColor.clear
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        
        if let selectedRow = myTableView.indexPathForSelectedRow {
        myTableView.deselectRow(at: selectedRow, animated: true)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.width == 812 {
            // is iphone x
            print(myTableView.visibleCells[0].frame.height)
            myTableView.contentOffset.y = myTableView.visibleCells[0].frame.height / 4 //50
        }
    }

    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self.myTableView, name: .UIContentSizeCategoryDidChange, object: nil)
    }
    
    // Helpers
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsContent.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")!
        
        cell.textLabel?.text = cellsContent[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 60)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch indexPath.row {
        case 0:
            let controller = storyboard.instantiateViewController(withIdentifier: "PagesViewController") as! PagesViewController
            self.navigationController?.pushViewController(controller, animated: true)
        case 1:
            let controller = storyboard.instantiateViewController(withIdentifier: "DTDTViewController") as! DTDTViewController
            self.navigationController?.pushViewController(controller, animated: true)
        case 2:
            let controller = storyboard.instantiateViewController(withIdentifier: "HigherLowerViewController") as! HigherLowerViewController
            self.navigationController?.pushViewController(controller, animated: true)
        case 3:
            let controller = storyboard.instantiateViewController(withIdentifier: "MagicViewController") as! MagicViewController
            self.navigationController?.pushViewController(controller, animated: true)
        default:
            print("An error has occured!")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        updateRowHeight(indexPath: indexPath)
        
        //myTableView.visibleCells[(indexPath as NSIndexPath).row].textLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        let navHeight = navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        height = view.frame.height - navHeight! - statusBarHeight
        return height / rowCount
    }
    
    func updateRowHeight(indexPath: IndexPath) {
        
        var fontSize = CGFloat(0)
        if (self.view.frame.size.width > self.view.frame.size.height) {
            fontSize = 40
        } else {
            fontSize = 60
        }
        
        myTableView.cellForRow(at: indexPath)?.textLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    @IBAction func rightBarButtonPressed() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let message = "Check out 'Guess Fun': It's an app with 4 games in 1 place! https://itunes.apple.com/us/developer/daniel-springer/id1402417666?mt=8"
        let activityController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view // for iPads not to crash
        activityController.completionWithItemsHandler = {
            (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
            guard error == nil else {
                let alert = self.createAlert(alertReasonParam: alertReason.unknown.rawValue)
                self.present(alert, animated: true)
                return
            }
        }
        present(activityController, animated: true)
    }
    
    
    
    
}
