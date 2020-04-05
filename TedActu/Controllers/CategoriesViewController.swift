//
//  CategoriesViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/5/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource{
    
    var categories = ["SOCIÉTÉ", "POLITIQUE", "CULTURE", "SPORT", "SAVOIR+"]
    
//

//
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        return cell
    }
}
