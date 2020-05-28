//
//  HomeTableViewCell.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/2/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imagePost: UIImageView!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewBottomImg: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
