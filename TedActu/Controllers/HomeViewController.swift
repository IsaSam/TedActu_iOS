//
//  HomeViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/2/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftyJSON
import SDWebImage

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    @IBOutlet weak var activityIndicatory: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [[String: Any]] = []
    var postsTitle: [[String: Any]] = []
    var postsContent: [[String: Any]] = []
    var postsEmbed: [[String: Any]] = []
    
    var imgPosts: [[String: Any]] = []
    var urlPost1: String?
    var loadNumber = 1
    var convertedDate: String = ""
    var convertedTime: String = ""
    var imagePost1: UIImageView?
    var imagePost2: UIImage?
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            getPostList()
        }else{
                print("Internet Connection not Available!")
                let errorAlertController = UIAlertController(title: "On ne peut pas obtenir de données", message: "La connexion Internet semble être hors ligne", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Réessayer", style: .cancel)
                   errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
        }
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        getPostList()
    }
    
    // GET Post
    private func getPostList(){
        
        self.activityIndicatory.startAnimating() //====================
         TedActuAPIManager.shared.get(url: "http://ted.policite.org/wp-json/wp/v2/posts?&page=\(loadNumber)&_embed") { (result, error) in
         
         if error != nil{
                let errorAlertController = UIAlertController(title: "On ne peut pas obtenir de données", message: "La connexion Internet semble être hors ligne", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Réessayer", style: .cancel)
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
         return
         }
            
         self.posts = result!
            DispatchQueue.main.async {
                self.tableView?.reloadData()
                self.activityIndicatory.stopAnimating()
                self.activityIndicatory.isHidden = true
            }
         }
         self.refreshControl.endRefreshing()
        
    }
    // Get More Posts
    func loadMorePosts(){
        self.activityIndicatory.startAnimating()
        self.activityIndicatory.isHidden = false
        loadNumber = loadNumber + 1
         TedActuAPIManager.shared.get(url: "http://ted.policite.org/wp-json/wp/v2/posts?&page=\(loadNumber)&_embed") { (result, error) in
            
                if error != nil{
                    let errorAlertController = UIAlertController(title: "On ne peut pas obtenir de données", message: "La connexion Internet semble être hors ligne", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Réessayer", style: .cancel)
                    errorAlertController.addAction(cancelAction)
                    self.present(errorAlertController, animated: true)
                    
                    return
                }
            if result != nil{
                do{

                    for item in result!
                    {
                        
                        self.posts.append(item)
                        
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView?.reloadData()
                        self.activityIndicatory.stopAnimating()
                        self.activityIndicatory.isHidden = true
                    }
                }
        }else{
                let errorAlertController = UIAlertController(title: "Désolé, Fin des articles!", message: "Remonter la liste", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel)
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count{
            loadMorePosts()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.posts.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! HomeTableViewCell
    //=====================================================================
            let post = posts[indexPath.row]
            
            do{
                let titleDic = (posts as AnyObject).value(forKey: "title")
                let embedDic = (posts as AnyObject).value(forKey: "_embedded")
                let contentDic = (posts as AnyObject).value(forKey: "content")
                
                let titleDicString = titleDic as? [[String: Any]]
                let embedDicString = embedDic as? [[String: Any]]
                let contentDicString = contentDic as? [[String: Any]]
                
                self.postsTitle = titleDicString!
                self.postsEmbed = embedDicString!
                self.postsContent = contentDicString!
            }
            let postTitle = postsTitle[indexPath.row]
            let postContent = postsContent[indexPath.row]
            let postImage = postsEmbed[indexPath.row]
            
            let imgArray = (postImage as AnyObject).value(forKey: "wp:featuredmedia")
            let mediaDetails = (imgArray as AnyObject).value(forKey: "media_details")
            let sizes = (mediaDetails as AnyObject).value(forKey: "sizes")
            
            let encoded = postTitle["rendered"] as? String
//            cell.titleLabel.text = encoded?.stringByDecodingHTMLEntities
            let title_ = encoded?.stringByDecodingHTMLEntities
            let htmlTag =  postContent["rendered"] as! String
            let content = htmlTag.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            let content_ = content.stringByDecodingHTMLEntities
            
            //date format conversion
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let newDateFormatter = DateFormatter()
            //        newDateFormatter.dateFormat = "MMM dd, yyyy"
            newDateFormatter.dateFormat = "dd MMM, yyyy"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH-mm-ss"
            let newTimeFormatter = DateFormatter()
            newTimeFormatter.dateFormat = "h:mm a"
            let dateTime = post["date"] as? String
            let dateComponents = dateTime?.components(separatedBy: "T")
            let splitDate = dateComponents![0]
            let splitTime = dateComponents![1]
            if let date = dateFormatter.date(from: splitDate) {
                convertedDate = newDateFormatter.string(from: date)
            }
            if let time = timeFormatter.date(from: splitTime){
                convertedTime = newTimeFormatter.string(from: time)
            }
            let datePost_ = convertedDate
            
//            let html2 = htmlTag.allStringsBetween(start: "<iframe src=", end: "</iframe>")
//            let input = String(describing: html2)
//            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//            let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
//            for match in matches {
//                guard let range = Range(match.range, in: input) else { continue }
//                let urlYou = input[range]
//                if urlYou != ""{
//                    urlYoutube = String(urlYou)
//                    cell.picMedia.isHidden = false //icon for media files
//                }
//                else{
//                    cell.picMedia.isHidden = true //icon for media files
//                }
//            }
            
            do{
                let medium =  (sizes as AnyObject).value(forKey: "full")
                let dataDic = medium as? [[String: Any]]
                if dataDic != nil{
                    
                    self.imgPosts = dataDic!
                    for images in imgPosts{
                        let imageURL = images["source_url"] as? String
//                        imgURLShare = imageURL
                        print("imageURL: \(imageURL!)")
                        if let imagePath = imageURL,
                            let imgUrl = URL(string:  imagePath){
                            
                            
                            cell.imagePost.sd_setImage(with: imgUrl, placeholderImage:nil, completed: { (image, error, cacheType, imgUrl) -> Void in
                                if ((error) != nil) {
                                    cell.imagePost.image = UIImage(named: "placeholderImage.png")
                                } else {
                                    //     print("Success let using the image...")
                                    cell.imagePost.sd_setImage(with: imgUrl)
                                }
                            })
                            
                            
                            
                            //          cell.posterImageView.layer.borderColor = UIColor.white.cgColor
                            //        cell.posterImageView.layer.borderWidth = 2.0
                            cell.imagePost.layer.cornerRadius = 4.0
                            cell.imagePost.clipsToBounds = true
                            cell.imagePost.af_setImage(withURL: imgUrl)
                            
                        }
                        else{
                        }
                        if let imagePath = imageURL,
                            let imgUrl = URL(string:  imagePath){
                            cell.imagePost.image = UIImage(named: "loading4.jpg") //image place
                            cell.imagePost.af_setImage(withURL: imgUrl)
                        }
                        else{
                            cell.imagePost.image = nil
                        }
                        //  imgShare = cell.imagePost.image
                        imagePost1 = cell.imagePost
                        imagePost2 = cell.imagePost.image
                    }
                }else{}
            }
            return cell  
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}// End of Class





