//
//  VideoDetailViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 3/29/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class VideoDetailViewController: UIViewController {

     @IBOutlet weak var webView: UIWebView!
        @IBOutlet weak var videoTitle: UILabel!
        @IBOutlet weak var videoDes: UITextView!
        
        
        var selectedVideo:video?
            
            override func viewDidLoad() {
                super.viewDidLoad()

            }
            
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // remove separator
        //    tableView.separatorColor = .clear
            
            //backButton color
            self.navigationController?.navigationBar.tintColor = UIColor(red: 0.94, green: 0.47, blue: 0.19, alpha: 1.00)
            
            //tabBarColor
            self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.00, green: 0.11, blue: 0.29, alpha: 1.00)
            
            // hide navigationBar
         //   navigationController?.setNavigationBarHidden(true, animated: animated)
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
            
            navigationController?.navigationBar.backgroundColor = .systemBlue
            navigationController?.navigationBar.barStyle = .blackTranslucent
            
        //    navigationController?.navigationBar.backgroundColor = UIColor(red:0.00, green:0.11, blue:0.29, alpha:1.00)
        }
            override func viewDidAppear(_ animated: Bool) {
                
                if let vid = self.selectedVideo{
                    
                    
                    self.videoTitle.text = vid.videoTitle
                    self.videoDes.text = vid.videoDes
                    
                    
                    let width = self.view.frame.size.width
                    // let height = (width/320)*180
                    
                    
                    let videoEmbedString =  "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"320\"  width= \"\(width)\"   src=\"http://www.youtube.com/embed/" + vid.videoId + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
                    
                    self.webView.loadHTMLString(videoEmbedString, baseURL: nil)
                    
                }
                
                
            }
        
        
            
    }
