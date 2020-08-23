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
    
    let UPLOADS_PLAYLIST_ID =  "UUYwjO810TxGsyEG9ytlRtbQ"
    let API_KEY = "AIzaSyBQqgKRuhh2JuqOpKpwRULqtydyYSRkvn4"
    let urlString = "https://www.googleapis.com/youtube/v3/playlistItems"
    
    var snippet: [[String: Any]] = []
    var snippet1: [[String: Any]] = []
    var resourceId1: [[String: Any]] = []
    
    var posts: [[String: Any]] = []

       @IBOutlet weak var tableView: UITableView!
        var videos:[video] = [video]()
        var selectedVideo:video?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.delegate = self
            tableView.dataSource = self
            
            getFeedsVideos()
            

        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // remove separator
        tableView.separatorColor = .clear
        
        //backButton color
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.94, green: 0.47, blue: 0.19, alpha: 1.00)
        
        //tabBarColor
        self.tabBarController?.tabBar.barTintColor = UIColor(red: 0.00, green: 0.11, blue: 0.29, alpha: 1.00)
        
        // hide navigationBar
     //   navigationController?.setNavigationBarHidden(true, animated: animated)
        topBarLogo()
        
        // Add a background image view to the table view
        let backgroundImage = UIImage(named: "back_img_blue")
        //back-img-white
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
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
        
    }//End viewController

    //Mark delegates of Table viewController

    extension PlaylistViewController : UITableViewDataSource , UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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






