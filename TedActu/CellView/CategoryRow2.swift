//
//  CategoryRow2.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/26/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class CategoryRow2: UITableViewCell {
    @IBOutlet weak var labelHeader2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CategoryRow2 : UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell2", for: indexPath as IndexPath) as! CategoriesCollectionViewCell2
        
        print("index: \(indexPath.row)")
        
        cell.titleLabel2.text = String(indexPath.row)
        cell.titleLabel2.textColor = .white
        
        print(collectionView.numberOfSections)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
}
extension CategoryRow2 : UICollectionViewDelegateFlowLayout {
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
           return CGSize(width: itemSize, height: itemSize)
       }

}




