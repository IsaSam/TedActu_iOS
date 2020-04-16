//
//  CategoriesViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/5/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource{
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
   
    var categories = ["SOCIÉTÉ", "POLITIQUE", "CULTURE", "SPORT", "SAVOIR+"]
    
//

//
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
            tableView.rowHeight = 170
            tableView.estimatedRowHeight = 180
        
            tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryRow
        
        return cell
    }
}
