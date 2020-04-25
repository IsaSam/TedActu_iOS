//
//  HomeCategoryTableView.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/25/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class HomeCategoryTableView: UITableView, UITableViewDataSource, UITableViewDelegate{
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SocieteCell") as! SocieteCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PolitiqueCell") as! PolitiqueCell
            return cell
        }
    }


}
