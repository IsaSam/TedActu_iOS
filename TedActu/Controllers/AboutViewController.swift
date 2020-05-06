//
//  AboutViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 5/5/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //tabBarColor
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.01, green: 0.05, blue: 0.14, alpha: 1.00)
        
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
        navigationController?.navigationBar.backgroundColor = UIColor(red:0.00, green:0.11, blue:0.29, alpha:1.00)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    

}
