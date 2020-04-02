//
//  PlaylistViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 3/29/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

       @IBOutlet weak var tableView: UITableView!
        var videos:[video] = [video]()
        var selectedVideo:video?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let model = VideoModel()
      //      self.videos = model.getVideo()
            
            model.getFeedVideos()
        
     //       self.videos = model.getVideos()
        }
        
    }//End viewController

    //Mark delegates of Table viewController

    extension PlaylistViewController : UITableViewDataSource , UITableViewDelegate{
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return videos.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            
            
            
            let videoTitle = videos[indexPath.row].videoTitle
            let label = cell.viewWithTag(2) as! UILabel
            label.text = videoTitle
            
            
            // Construct the video thumbnail url
            let videoThumbnailUrlString = "https://i1.ytimg.com/vi/" + videos[indexPath.row].videoId + "/maxresdefault.jpg"
            
            
            // Create an NSurl object
            let videoThumbnailUrl = NSURL(string: videoThumbnailUrlString)
            
            
            if videoThumbnailUrl != nil{
                // Create an NSURL request object
                let request = NSURLRequest(url: videoThumbnailUrl! as URL)
                
                // Create an NSURLSession
                let session =  URLSession.shared
                
                // Create a dataTask and pass in the request
                let dataTask = session.dataTask( with: request as URLRequest , completionHandler: {
                    //completionHandler:{( // code } as! (Data?, URLResponse?, Error?
                    (responseData, response, error) in
                    
                    //  DispatchQueue.async(DispatchQueue.main){
                    
                    DispatchQueue.main.async {
                        // Get a reference to the imageview element of the cell
                        let imageView = cell.viewWithTag(1) as! UIImageView
                        
                        // Create an image object from the data and assign it into the imageView
                        
                       imageView.image = UIImage(data: responseData!)
                        
                        
                    }
                    
                })
                dataTask.resume()
                
            }
            
            
            return cell
            
        }
        
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return (self.view.frame.size.width/320)*180
        }
        
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
            self.selectedVideo = self.videos[indexPath.row]
          
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let detailViewController = segue.destination as! VideoDetailViewController
            
            detailViewController.selectedVideo = self.selectedVideo
            
            
        }
        
        
    }






