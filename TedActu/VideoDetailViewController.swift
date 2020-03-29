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
            
        
            override func viewDidAppear(_ animated: Bool) {
                
                if let vid = self.selectedVideo{
                    
                    
                    self.videoTitle.text = vid.videoTitle
                    self.videoDes.text = vid.videoDes
                    
                    
                    let width = self.view.frame.size.width
                    // let height = (width/320)*180
                    
                    
                    let videoEmbedString =  "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"250\"  width= \"\(width)\"   src=\"http://www.youtube.com/embed/" + vid.videoId + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
                    
                    self.webView.loadHTMLString(videoEmbedString, baseURL: nil)
                    
                }
                
                
            }
        
        
            
    }
