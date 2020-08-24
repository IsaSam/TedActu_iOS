//
//  CategoryCollectionViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 5/29/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cellCategory"

class CategoryCollectionViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
    
        override func viewDidLoad() {
            super.viewDidLoad()

      /*      if let patternImage = UIImage(named: "Pattern") {
                view.backgroundColor = UIColor(patternImage: patternImage)
            }*/
     //       collectionView?.backgroundColor = .clear
            collectionView?.contentInset = UIEdgeInsets(top: 20, left: 8, bottom: 10, right: 8)

  //          collectionView?.dataSource = self
        }

    }

    extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout {

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 6
        }

        private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! cellCategory

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
            let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
            return CGSize(width: itemSize, height: itemSize+40)
        }



    
    // MARK: -

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//
//        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
//                layout.minimumLineSpacing = 10
//                layout.minimumInteritemSpacing = 10
//                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//                let size = CGSize(width:(collectionView!.bounds.width-30)/2, height: 250)
//                layout.itemSize = size
//        }
//
//        collectionView?.dataSource = self
//        collectionView?.delegate = self
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
//        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
//        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
//        return CGSize(width: size, height: size)
//    }
//
//
//
//    // MARK: - UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 6
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
//
//        // Configure the cell
//        cell.backgroundColor = .green
//
//        return cell
//    }

    // MARK: - UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
