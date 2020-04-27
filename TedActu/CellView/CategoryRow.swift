//
//  CategoryRow.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/5/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class CategoryRow: UITableViewCell {
    @IBOutlet weak var labelHeader1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CategoryRow : UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath as IndexPath) as! CategoriesCollectionViewCell
        
        print("index: \(indexPath.row)")
        
 //       Categories.catID = "22"
        
        cell.titleLabel.text = String(indexPath.row)
        cell.titleLabel.textColor = .white
        
        print(collectionView.numberOfSections)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
}
extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
           return CGSize(width: itemSize, height: itemSize)
       }

}



