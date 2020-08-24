//
//  GalleriesCollectionView.swift
//  TedActu
//
//  Created by Isaac Samuel on 5/29/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cellCategory"

class GalleriesCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  /*      if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }*/
 //       collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 20, left: 8, bottom: 10, right: 8)

        collectionView?.dataSource = self
    }

//}

//extension GalleriesCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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



}
