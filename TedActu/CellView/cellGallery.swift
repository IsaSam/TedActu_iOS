//
//  cellGallery.swift
//  TedActu
//
//  Created by Isaac Samuel on 5/8/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class cellGallery: UICollectionViewCell {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var imageCellCategory: UIImageView!
    @IBOutlet weak var widthImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightImageConstraint: NSLayoutConstraint!
    
    override var isHighlighted: Bool {
           willSet {
               if newValue == true {
                   UIView.transition(with: imageCellCategory, duration: 5.0, options: .transitionCrossDissolve, animations: {
                       self.imageCellCategory.isHighlighted = newValue
                   })
               }
           }
       }
       
    override var isSelected: Bool {
           willSet {
               if newValue == false {
                   UIView.transition(with: imageCellCategory, duration: 5.0, options: .transitionCrossDissolve, animations: {
                       self.imageCellCategory.isHighlighted = newValue
                   })
               }
           }
       }
}
