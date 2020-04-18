//
//  CategoriesViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/5/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

struct Categories{
    static var Names = String()
  //  static var cat: [String] = []
}

class CategoriesViewController: UIViewController, UITableViewDataSource{
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
   
    var categories = ["SOCIÉTÉ", "POLITIQUE", "CULTURE", "SPORT", "SAVOIR+"]
   // var categories = ["SOCIÉTÉ"]
    



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
       // print("categories1: \(categories[section])")
        Categories.Names = categories[section]
        return categories[section]
    }
//    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
//        var tempIndex:Int = 0
//        for str in categories {
//            if str == title {
//                print("tempIndex: \(tempIndex)")
//                return tempIndex
//            }
//            tempIndex += 1
//        }
//        return 0
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryRow
        
        print("categories: \(categories[indexPath.row])")
        print(tableView.numberOfSections)
        
        return cell
    }
}
