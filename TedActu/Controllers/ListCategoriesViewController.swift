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
        UIImage(named: "Politique_BG_Color.jpg")!,
        UIImage(named: "Savoir+_BG_Color.jpg")!,
        UIImage(named: "Societe_BG_Color.jpg")!,
        UIImage(named: "Sport_BG_Color.jpg")!,
        UIImage(named: "Culture_BG_Color.jpg")!,
        UIImage(named: "Anket_BG_Color.jpg")!
        
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .black
        
        //tabBarColor
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.00, green: 0.11, blue: 0.29, alpha: 1.00)
        
        topBarLogo()
        
    }
    func topBarLogo(){
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo-text-white.png")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        //Background
        navigationController?.navigationBar.backgroundColor = .systemBlue
        navigationController?.navigationBar.barStyle = .blackTranslucent
//        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.11, blue:0.29, alpha:1.00)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension ListCategoriesViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        ////
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCategoriesCell", for: indexPath) as! ListCategoriesTableViewCell
        
        // Add a background image view to the tableViewCell
        let backgroundImage = UIImage(named: "back_img_blue.png")
        let imageView = UIImageView(image: backgroundImage)
        
        // Add a background image view to the tableView
        tableView.backgroundView = imageView
//        cell.backgroundView = imageView
        
        cell.backgroundColor = .clear
    
        cell.imageListCategories?.image = myImages[indexPath.row]
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        MyVariables2.rowSelect = row
        tableView.deselectRow(at: indexPath, animated: true) // to remove
    }

  
}
