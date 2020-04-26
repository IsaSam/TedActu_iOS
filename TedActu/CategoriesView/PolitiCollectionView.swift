//
//  PolitiCollectionView.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/25/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class PolitiCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate{
    
    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PoliticViewCell", for: indexPath) as! PoliticViewCell
        
        return cell
    }
 

}
