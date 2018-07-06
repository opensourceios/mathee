//
//  MenuViewController.swift
//  Guess My Number Fun
//
//  Created by Dani Springer on 05/07/2018.
//  Copyright © 2018 Dani Springer. All rights reserved.
//

import Foundation

import UIKit

class MenuViewController: UITableViewController {
    
    // MARK: Outlets
    
    @IBOutlet var myTableView: UITableView!
    
    
    
    // MARK: Properties
    
    let rowCount = CGFloat(4)
    var height = CGFloat(0)
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        tableView.separatorColor = UIColor.clear
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self.tableView, name: .UIContentSizeCategoryDidChange, object: nil)
    }
    
    // Helpers
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let navHeight = navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        height = view.frame.height - navHeight! - statusBarHeight
        return height / rowCount
    }
    
}
