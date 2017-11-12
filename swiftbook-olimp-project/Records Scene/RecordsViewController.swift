//
//  RecordsViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/11/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation
import UIKit

class RecordsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
}
