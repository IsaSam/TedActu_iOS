//
//  ListCategoriesViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 5/3/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cellCategory"

class ListCategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myImages: [UIImage] = [
        UIImage(named: "Politique_BG_Color.jpg")!,
        UIImage(named: "Savoir+_BG_Color.jpg")!,
        UIImage(named: "Societe_BG_Color.jpg")!,
        UIImage(named: "Sport_BG_Color.jpg")!,
        UIImage(named: "Culture_BG_Color.jpg")!,
        UIImage(named: "Anket_BG_Color.jpg")!
        
    ]
    
    var deviceOrientation: Bool?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .black
        
        //tabBarColor
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.00, green: 0.11, blue: 0.29, alpha: 1.00)
        
        topBarLogo()
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("landscape")
            deviceOrientation = true
        } else {
            print("portrait")
            deviceOrientation = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("o- \(deviceOrientation ?? false)")
        
//        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 8, bottom: 10, right: 8)
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical //.horizontal
//        layout.minimumLineSpacing = 5
//        layout.minimumInteritemSpacing = 5
//        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
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
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myImages.count
    }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! cellCategory
            
            ////
            
            
            // Add a background image view to the tableViewCell
            let backgroundImage = UIImage(named: "back_img_blue.png")
            let imageView = UIImageView(image: backgroundImage)
            
            // Add a background image view to the tableView
            collectionView.backgroundView = imageView
    //        cell.backgroundView = imageView
            
            cell.backgroundColor = .clear
        
            cell.imageListCategories?.image = myImages[indexPath.row]
            
            return cell
            
        }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

         // animation 2
         cell.alpha = 0
         UIView.animate(withDuration: 1.5){
         cell.alpha = 1.0
         }
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        if deviceOrientation != true{
            let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
            return CGSize(width: size, height: size)
        }else{
            let size:CGFloat = (collectionView.frame.size.width - space) / 6.0
            return CGSize(width: size, height: size)
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
//        return CGSize(width: itemSize, height: itemSize+40)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        MyVariables2.rowSelect = row
  //      collectionView.deselectRow(at: indexPath, animated: true) // to remove
    }
    
}
