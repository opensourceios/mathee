//
//  MenuViewController.swift
//  Guess My Number Fun
//
//  Created by Dani Springer on 05/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import Foundation

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Outlets
    
    @IBOutlet var myTableView: UITableView!
    
    
    
    // MARK: Properties
    
    let rowCount = CGFloat(4)
    var height = CGFloat(0)
    
    let cellsContent = ["📗", "✖️➗➕➖", "👆👇" , "🕘"]
    
    
    // MARK: Life Cycle
    

    
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
        print("cellForRowAt called")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell")!
        
        cell.textLabel?.text = cellsContent[(indexPath as NSIndexPath).row]
        
        var fontSize = CGFloat(0)
        if (self.view.frame.size.width > self.view.frame.size.height) {
            print("Hello Landscape")
            fontSize = 30
        } else {
            print("Hello Portrait")
            fontSize = 50
        }
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let info = memeList[(indexPath as NSIndexPath).row]
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let detailVC = storyboard.instantiateViewController(withIdentifier: "MemeDetail") as! MemeDetailViewController
//        detailVC.preLoadImage = info.alteredImage
//        self.navigationController?.pushViewController(detailVC, animated: true)
//    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt called")

        var fontSize = CGFloat(0)
        if (self.view.frame.size.width > self.view.frame.size.height) {
            print("Hello Landscape")
            fontSize = 30
        } else {
            print("Hello Portrait")
            fontSize = 50
        }
        
        myTableView.cellForRow(at: indexPath)?.textLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        //myTableView.visibleCells[(indexPath as NSIndexPath).row].textLabel?.font = UIFont.systemFont(ofSize: fontSize)
        
        let navHeight = navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        height = view.frame.height - navHeight! - statusBarHeight
        return height / rowCount
    }
    
    
}
