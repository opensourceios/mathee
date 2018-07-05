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
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let navHeight = navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        height = view.frame.height - navHeight! - statusBarHeight
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        myTableView.reloadData()
    }
    
    // Helpers
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height / rowCount
    }
    
}
