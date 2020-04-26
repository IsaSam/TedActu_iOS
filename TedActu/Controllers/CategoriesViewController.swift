//
//  CategoriesViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/5/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit
import YYHRequest

struct Categories{
    static var Names = String()
    static var catID: String?
    static var catID2: String?
    static var posts: [[String: Any]] = []
    static var posts2: [[String: Any]] = []
}

class CategoriesViewController: UIViewController, UITableViewDataSource{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var loadNumber = 1
    var imgURLShare1: String?
//    var categories = ["SOCIÉTÉ", "POLITIQUE", "CULTURE", "SPORT", "SAVOIR+"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
            tableView.rowHeight = 170
            tableView.estimatedRowHeight = 180
        
            tableView.dataSource = self
        
        getPostCategory()
        getPostCategory2()

    }
    
    //---- GET POST BY CATEGORIES
    
    
    private func getPostCategory(){
    //    self.activityIndicatory.startAnimating()
    //    self.activityIndicatory.isHidden = false
        
        TedActuAPIManager.shared.get(url: "http://ted.policite.org/wp-json/wp/v2/posts?page=\(loadNumber)&categories=22&_embed") { (result, error) in
            if error != nil{
                // print(error!)
                let errorAlertController = UIAlertController(title: "Cannot Get Data", message: "The Internet connections appears to be offline", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
                print(error!)
                
                return
            }
                print("result1: \(result!)")
            Categories.posts = result!
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
    //                self.activityIndicatory.stopAnimating()
    //                self.activityIndicatory.isHidden = true
                }
            
            //====================
        }
//        self.refreshControl.endRefreshing()
    }
    private func getPostCategory2(){
        //    self.activityIndicatory.startAnimating()
        //    self.activityIndicatory.isHidden = false
            
            TedActuAPIManager.shared.get(url: "http://ted.policite.org/wp-json/wp/v2/posts?page=\(loadNumber)&categories=16&_embed") { (result, error) in
                if error != nil{
                    // print(error!)
                    let errorAlertController = UIAlertController(title: "Cannot Get Data", message: "The Internet connections appears to be offline", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                    errorAlertController.addAction(cancelAction)
                    self.present(errorAlertController, animated: true)
                    print(error!)
                    
                    return
                }
                    print("result2: \(result!)")
                Categories.posts2 = result!
                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
        //                self.activityIndicatory.stopAnimating()
        //                self.activityIndicatory.isHidden = true
                    }
                
                //====================
            }
    //        self.refreshControl.endRefreshing()
        }
    
    func loadMorePosts(){
//        self.activityIndicatory.startAnimating()
//        self.activityIndicatory.isHidden = false
        loadNumber = loadNumber + 1
        TedActuAPIManager.shared.get(url: "http://ted.policite.org/wp-json/wp/v2/posts?page=\(loadNumber)&categories=22&_embed") { (result, error) in

            if error != nil{
                // print(error!)
                let errorAlertController = UIAlertController(title: "Cannot Get Data", message: "The Internet connections appears to be offline", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Retry", style: .cancel)
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
                print(error!)
                
                return
            }
            
            do{
                
                ////
                if YYHRequest(url: NSURL(string: self.imgURLShare1!)! as URL) != nil {
            
                    if result != nil{
                        do{
                            for item in result!
                                
                            {
                                
                                Categories.posts.append(item)
                            }
                            DispatchQueue.main.async {
                                self.tableView?.reloadData()
//                                self.activityIndicatory.stopAnimating()
//                                self.activityIndicatory.isHidden = true
                            }
                        }
                    }else{
                        print("nil")
//                            self.activityIndicatory.stopAnimating()
//                            self.activityIndicatory.isHidden = true
                        let errorAlertController = UIAlertController(title: "Désolé, Fin des articles!", message: "Remonter la liste", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                        errorAlertController.addAction(cancelAction)
                        self.present(errorAlertController, animated: true)
                        
                    }

                }else{
                    print("===========================================")
                    print("body nil")

            }

                }
            
        }
    }
    
    // END CATEGORIES
    
    func numberOfSections(in tableView: UITableView) -> Int {
  //      return categories.count
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//       // print("categories1: \(categories[section])")
//        Categories.Names = categories[section]
//        return categories[section]
//    }
    
    
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
        return 2
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryRow
        
//        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CategoryRow
        
//        print("categories: \(categories[indexPath.row])")
        print(tableView.numberOfSections)
        
        //////
        let row = indexPath.row
        
        if row == 0 {
  //          Categories.catID = "22"
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryRow
            cell.labelHeader1.text = "SOCIÉTÉ"
            cell.labelHeader1.textColor = .white
            
            return cell
        }
        else{
  //          Categories.catID = "16"
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CategoryRow2
            cell.labelHeader2.text = "POLITIQUE"
            cell.labelHeader2.textColor = .white
            
            return cell
        }

    }
    
}
