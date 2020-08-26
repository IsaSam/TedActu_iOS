//
//  SplashScreenView.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/30/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class SplashScreenView: UIViewController {
    var timer = Timer()
    
    @IBOutlet weak var launchImgVw: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        launchImgVw.loadGif(name: "splashscreen_img")
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.goToMainScreen), userInfo: nil, repeats: true)
    }
    
    @objc func goToMainScreen() {
        
        timer.invalidate()
        
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
        
        
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
