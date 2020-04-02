//
//  PlaylistViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 3/29/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit
import UIKit
import Alamofire

class PlaylistViewController: UIViewController {
    
    ////new
    let UPLOADS_PLAYLIST_ID =  "UUYwjO810TxGsyEG9ytlRtbQ"
    let API_KEY = "AIzaSyBQqgKRuhh2JuqOpKpwRULqtydyYSRkvn4"
    let urlString = "https://www.googleapis.com/youtube/v3/playlistItems"
    
    var items: [[String: Any]] = []
    var snippet: [[String: Any]] = []
        var snippet1: [[String: Any]] = []
        var resourceId1: [[String: Any]] = []
    var videoTitle: [[String: Any]] = []
    var videoDesc: [[String: Any]] = []
    var videoId: [[String: Any]] = []
    var videoTitleString: [String] = []
    var videoDescString: [String] = []
    var videoIdString: [String] = []
//    var videoTitleString: String?
//    var videoDescString: String?
//    var videoIdString: String?
    
    var posts: [[String: Any]] = []
//    var  videos = [video]()
//
    ///

       @IBOutlet weak var tableView: UITableView!
        var videos:[video] = [video]()
        var selectedVideo:video?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
   ////         let model = VideoModel()
      //      self.videos = model.getVideo()
            
   ////         model.getFeedVideos()
        
     //       self.videos = model.getVideos()
            
            tableView.delegate = self
            tableView.dataSource = self
            
   ///         getFeedVideos()
            getFeedsVideos()
            

        }
    
    ///new
    func getFeedsVideos(){
        
        // Alamofire 4
        let parameters: Parameters = ["part": "snippet", "playlistId": UPLOADS_PLAYLIST_ID, "key": API_KEY]
        
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
///                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
                
                            if let JSON = response.result.value as? [String:Any]  {//as? [String:Any] {
                                
 ///                            print("json \(JSON)")
                                
                                ////

                                 for item in JSON["items"] as! NSArray {
                                    self.posts.append(item as! [String : Any])
                                         
                                     }
//                                            let video1 = video()
                                            
                                                 for snippet in self.posts{
                                                     self.snippet.append(snippet)
                                                     }

                                                 for items2 in self.snippet{
                                                     let snippetDic = (items2 as AnyObject).value(forKey: "snippet")
                                                    self.snippet1.append(snippetDic as! [String : Any])
                                                     let resourceId = (snippetDic as AnyObject).value(forKey: "resourceId")
                                                    self.resourceId1.append(resourceId as! [String : Any])
                                                    
                                                    DispatchQueue.main.async {
                                                        self.tableView?.reloadData()
                                                        }
                                                     }
                                   
                                ///
                           }
                        
            }
    }
    
    
    func getFeedVideos(){
            
            // Alamofire 4
            let parameters: Parameters = ["part": "snippet", "playlistId": UPLOADS_PLAYLIST_ID, "key": API_KEY]
            
            
            Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
                .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
 ///                   print("Progress: \(progress.fractionCompleted)")
                }
                .validate { request, response, data in
                    // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                    return .success
                }
                .responseJSON { response in
                    debugPrint(response)
                    
                                var  videos = [video]()
                                let video1 = video()
                    
                                if let JSON = response.result.value as? [String:Any]  {//as? [String:Any] {
                                    
                                    for items in JSON["items"] as! NSArray {
                                        
                                   
                                     //   self.items = items as! [[String : Any]]
                                        self.items.append(items as! [String : Any])
                                        for snippet in self.items{
                                            
                                            print("begin--")
                                            self.snippet.append(snippet)
                                       //     print(snippet)
                                            print("*--")
                                            }
                                        for items2 in self.snippet{
                                            let snippetDic = (items2 as AnyObject).value(forKey: "snippet")
                                            let titleDic = (snippetDic as AnyObject).value(forKey: "title")
                                            let descDic = (snippetDic as AnyObject).value(forKey: "description")
                                            let resourceId = (snippetDic as AnyObject).value(forKey: "resourceId")
                                            let videoId = (resourceId as AnyObject).value(forKey: "videoId")
//                                       //     self.videoTitleString.append(titleDic as! String)
//                                            self.videoTitleString = (titleDic as! String)
//                                       //     self.videoDescString.append(descDic as! String)
//                                            self.videoDescString = (descDic as! String)
//                                       //     self.videoIdString.append(videoId as! String)
//                                            self.videoIdString = (videoId as! String)
                                            
                                            video1.videoTitle = (titleDic as! String)
                                            video1.videoDes = (descDic as! String)
                                            video1.videoId = (videoId as! String)
                                            
                                            videos.append(video1)
                                      //      self.tableView.reloadData()
                                            
                                            print("***")
                                            
                                            let titleDicString = titleDic as? [[String: Any]]
                                            let descDicString = descDic as? [[String: Any]]
                                            let videoDicString = videoId as? [[String: Any]]
                                            
                                            if titleDicString != nil || descDicString != nil || videoDicString != nil{
                                                self.videoTitle = titleDicString!
                                                self.videoDesc = descDicString!
                                                self.videoId = videoDicString!
                                            }

                                        }
                                            
                                        }
                                    
   ///                              print("json \(JSON)")
                               }
                            
                }
        }
    
        
    }//End viewController

    //Mark delegates of Table viewController

    extension PlaylistViewController : UITableViewDataSource , UITableViewDelegate{
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         ///   return videos.count
           /// return posts.count
            return snippet1.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let post = snippet1[indexPath.row]
            let resource = resourceId1[indexPath.row]
            let video1 = video()
            
            let label = cell.viewWithTag(2) as! UILabel
            label.text = post["title"] as? String
            print("label:\(indexPath.row) \(label.text ?? "nil")")
            
            video1.videoDes = (post["description"] as? String)!
            video1.videoId =  (resource["videoId"] as? String)!
            self.videos.append(video1)
    
//            let videoTitle = videos[indexPath.row].videoTitle
//            let videoTitle = videoTitleString[indexPath.row]
//            let label = cell.viewWithTag(2) as! UILabel
//            label.text = videoTitle
            
            
            // Construct the video thumbnail url
//            let videoThumbnailUrlString = "https://i1.ytimg.com/vi/" + videos[indexPath.row].videoId + "/maxresdefault.jpg"
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






