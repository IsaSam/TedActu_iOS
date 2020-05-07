//
//  AboutViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 5/5/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
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
        
        let webaddress = "https://wego.here.com/directions/mix//Ted%E2%80%99Actu,-Port-au-Prince,-Ha%C3%AFti:e-eyJuYW1lIjoiVGVkXHUyMDE5QWN0dSIsImFkZHJlc3MiOiJWaWxsZSBEZSBQb3J0LUF1LVByaW5jZSwgT3Vlc3QsIEhhaXRpIiwibGF0aXR1ZGUiOjE4LjUzOTIsImxvbmdpdHVkZSI6LTcyLjMzNSwicHJvdmlkZXJOYW1lIjoiZmFjZWJvb2siLCJwcm92aWRlcklkIjoxOTM4NDM0ODczMDU2OTY2fQ==?map=18.5392,-72.335,15,normal&fb_locale=fr_FR" // 1
        if let url = URL(string: webaddress) { // 2
            let urlRequest = URLRequest(url: url) // 3
            self.webView.load(urlRequest) // 4
        }

    }
    
    

}
