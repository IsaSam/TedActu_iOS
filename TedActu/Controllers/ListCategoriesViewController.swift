//
//  ListCategoriesViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 5/3/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class ListCategoriesViewController: UIViewController {
    
    var myImages: [UIImage] = [
        UIImage(named: "Politique_BG_Blanc.jpg")!,
        UIImage(named: "Savoir+_BG_Blanc.jpg")!,
        UIImage(named: "Societe_BG_Blanc.jpg")!,
        UIImage(named: "Sport_BG_Blanc.jpg")!,
        UIImage(named: "Culture_BG_Blanc.jpg")!,
        UIImage(named: "Anket_BG_Blanc.jpg")!
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ListCategoriesViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCategoriesCell", for: indexPath) as! ListCategoriesTableViewCell
    
        cell.imageListCategories?.image = myImages[indexPath.row]
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        MyVariables.rowSelect = row
        tableView.deselectRow(at: indexPath, animated: true) // to remove
    }

  
}
