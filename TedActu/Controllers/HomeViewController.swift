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


struct MyVariables2 {
    static var rowSelect: Int?
}

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    @IBOutlet weak var activityIndicatory: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [[String: Any]] = []
    var postsTitle: [[String: Any]] = []
    var postsContent: [[String: Any]] = []
    var postsEmbed: [[String: Any]] = []
    var postsEmbed1: [[String: Any]] = []
    
    var imgPosts: [[String: Any]] = []
    var imgPosts1: [[String: Any]] = []
    var urlPost1: String?
    var loadNumber = 1
    var convertedDate: String = ""
    var convertedTime: String = ""
    var imagePost1: UIImageView?
    var imagePost2: UIImage?
    var refreshControl: UIRefreshControl!
    var c1: Any?
//    var fixHeight: CGFloat = 410.0
    var fixHeight: CGFloat?
    
    var categoryID: Int?
    var catID: String?
    
    override func viewDidAppear(_ animated: Bool) {
        print("---- didap")
            }
    override func viewDidDisappear(_ animated: Bool) {
       print("---- disap")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // navigationController?.setNavigationBarHidden(false, animated: animated)
        print("---- wildisa")
        view.backgroundColor = .black
       
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        print("rowSelect: \(MyVariables2.rowSelect ?? -1)")
        selectCategory()
        
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
   
    func selectCategory(){
        if MyVariables2.rowSelect != -1{
            if MyVariables2.rowSelect == 0 {
                   catID = "16"
                   print("Catégorie POLITIQUE")
               }
               else if MyVariables2.rowSelect == 1 {
                   catID = "22"
                   print("Catégorie SAVOIR+")
               }
                else if MyVariables2.rowSelect == 2 {
                    catID = "18"
                    print("Catégorie SOCIÉTÉ")
                }
                else if MyVariables2.rowSelect == 3 {
                    catID = "19"
                    print("Catégorie SPORT")
                }
                else if MyVariables2.rowSelect == 4 {
                    catID = "20"
                    print("Catégorie CULTURE")
                }
                else if MyVariables2.rowSelect == 5 {
                    catID = "23"
                    print("Catégorie ANKÈT")
                }
        }else{
            catID = ""
            print("Toutes les Catégories")
        }
    }
    
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        getPostList()
    }
    
    // GET Post
     func getPostList(){
        self.activityIndicatory.startAnimating() //====================
//        TedActuAPIManager.shared.get(url: "https://tedactu.com/wp-json/wp/v2/posts?&page=\(loadNumber)&categories=\(catID ?? "")&_embed") { (result, error) in
          
        TedActuAPIManager.shared.get(url: "https://tedactu.com/wp-json/wp/v2/posts?&page=\(loadNumber)&per_page=20&categories=\(catID ?? "")&_embed") { (result, error) in
            
         
         if error != nil{
            DispatchQueue.main.async {

                self.activityIndicatory.stopAnimating()
                self.activityIndicatory.isHidden = true
                
            }
                let errorAlertController = UIAlertController(title: "On ne peut pas obtenir de données", message: "La connexion Internet semble être hors ligne", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Réessayer", style: .cancel)
                errorAlertController.addAction(cancelAction)
                self.present(errorAlertController, animated: true)
           //     self.dismiss(animated: true, completion: nil)
         return
         }
         
             
        if result != nil{
                do{
                    print("===========")
         self.posts = result!
                    ///////////////////
// MARK: - BLOC TO GET HEIHT IMG FIRST
                    
                    let embedDic = (self.posts as AnyObject).value(forKey: "_embedded")
                    let embedDicString = embedDic as? [[String: Any]]
                    self.postsEmbed1 = embedDicString!
                    for postImage in self.postsEmbed1{
                        let imgArray = (postImage as AnyObject).value(forKey: "wp:featuredmedia")
                        let mediaDetails = (imgArray as AnyObject).value(forKey: "media_details")
                         
                        do{
                                        let dataDic = mediaDetails as? [[String: Any]]
                                        if dataDic != nil{
                                            self.imgPosts1 = dataDic!
                                            for images in self.imgPosts1{
                                                let h = images["height"] as? Int
                                         //        print("height1: \(h!)")
                                                
                                                        let imgSize = h
                                                let imgSize_f = imgSize
                                                if imgSize_f! > 1800{
                                          //          print("- imageHeight >>>>: \(imgSize_f!)")
                                                            self.fixHeight = 1200
                                                        }else if imgSize_f! > 1400{
                                           //                 print("- imageHeight >>: \(imgSize_f!)")
                                                            self.fixHeight = 800
                                                        }else{
                                            //                print("- imageHeight: \(imgSize!)")
                                                            self.fixHeight = 400
                                                        }
                                                
                                                }
                                            }
                                    }
                    }
// MARK: - //
                    
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicatory.stopAnimating()
                self.activityIndicatory.isHidden = true
            }
            
            }//// end of do
        }            else{
                        print("**** end of posts")
                        DispatchQueue.main.async {
                            self.activityIndicatory.stopAnimating()
                            self.activityIndicatory.isHidden = true
                        }
        //                let errorAlertController = UIAlertController(title: "Désolé, Fin des articles!", message: "Remonter la liste", preferredStyle: .alert)
        //                let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        //                errorAlertController.addAction(cancelAction)
        //                self.present(errorAlertController, animated: true)
                    }
            
         }
//        DispatchQueue.main.async {
//            self.activityIndicatory.stopAnimating()
//            self.activityIndicatory.isHidden = true
//            self.refreshControl.endRefreshing()
//        }
        
    }
    // Get More Posts
    func loadMorePosts(){
        self.activityIndicatory.startAnimating()
        self.activityIndicatory.isHidden = false
        loadNumber = loadNumber + 1
        TedActuAPIManager.shared.get(url: "https://tedactu.com/wp-json/wp/v2/posts?&page=\(loadNumber)&per_page=20&categories=\(catID ?? "")&_embed") { (result, error) in
            
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
                        self.tableView.reloadData()
                        self.activityIndicatory.stopAnimating()
                        self.activityIndicatory.isHidden = true
                    }
                }
        }

                        else{
                            print("*** end of posts")
                            DispatchQueue.main.async {
                                self.activityIndicatory.stopAnimating()
                                self.activityIndicatory.isHidden = true
                            }
            //                let errorAlertController = UIAlertController(title: "Désolé, Fin des articles!", message: "Remonter la liste", preferredStyle: .alert)
            //                let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            //                errorAlertController.addAction(cancelAction)
            //                self.present(errorAlertController, animated: true)
                        }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count{
            print("load more...")
            loadMorePosts()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.posts.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! HomeTableViewCell

        // Add a background image view to the tableViewCell
     /*   let backgroundImage = UIImage(named: "back_img_blue.png")
        let imageView = UIImageView(image: backgroundImage)
        cell.backgroundView = imageView
    */
        cell.backgroundColor = .clear
        cell.titleLabel.textColor = .white

    //=====================================================================
            let post = posts[indexPath.row]
////       self.c1 = post["categories"] as? [Any]
        
              
              // MARK: - VIEW BOTTOM
        let cateID = post["categories"] as? [Any]
        
        if cateID != nil{
                    if cateID as? NSObject == [16] as? NSObject{
                        cell.viewBottomImg.backgroundColor = UIColor(red: 0.47, green: 0.12, blue: 0.07, alpha: 1.00)
                        cell.titleLabel.backgroundColor = UIColor(red: 0.47, green: 0.12, blue: 0.07, alpha: 1.00)
                        
                        categoryID = 16
                    }else if cateID as? NSObject == [22] as? NSObject{
                        cell.viewBottomImg.backgroundColor = UIColor(red: 0.91, green: 0.72, blue: 0.18, alpha: 1.00)
                        cell.titleLabel.backgroundColor = UIColor(red: 0.91, green: 0.72, blue: 0.18, alpha: 1.00)
                        categoryID = 22
                    }
                    else if cateID as? NSObject == [23] as? NSObject{
                         cell.viewBottomImg.backgroundColor = UIColor(red: 0.02, green: 0.02, blue: 0.02, alpha: 1.00)
                        cell.titleLabel.backgroundColor = UIColor(red: 0.02, green: 0.02, blue: 0.02, alpha: 1.00)
                        categoryID = 23
                    }
                    else if cateID as? NSObject == [19] as? NSObject{
                        cell.viewBottomImg.backgroundColor = UIColor(red: 0.19, green: 0.63, blue: 0.98, alpha: 1.00)
                        cell.titleLabel.backgroundColor = UIColor(red: 0.19, green: 0.63, blue: 0.98, alpha: 1.00)
                        categoryID = 19
                    }
                    else if cateID as? NSObject == [20] as? NSObject{
                         cell.viewBottomImg.backgroundColor = UIColor(red: 0.25, green: 0.54, blue: 0.16, alpha: 1.00)
                        cell.titleLabel.backgroundColor = UIColor(red: 0.25, green: 0.54, blue: 0.16, alpha: 1.00)
                        categoryID = 20
                    }
                    else if cateID as? NSObject == [18] as? NSObject{
                        cell.viewBottomImg.backgroundColor = UIColor(red: 0.50, green: 0.20, blue: 0.56, alpha: 1.00)
                        cell.titleLabel.backgroundColor = UIColor(red: 0.50, green: 0.20, blue: 0.56, alpha: 1.00)
                        categoryID = 18
                    }
        }
// MARK: -
        
            do{
                let titleDic = (posts as AnyObject).value(forKey: "title")
                let embedDic = (posts as AnyObject).value(forKey: "_embedded")
                let excerptDic = (posts as AnyObject).value(forKey: "excerpt")
                
                let titleDicString = titleDic as? [[String: Any]]
                let embedDicString = embedDic as? [[String: Any]]
                let excerptDicString = excerptDic as? [[String: Any]]
                
                self.postsTitle = titleDicString!
                self.postsEmbed = embedDicString!
                self.postsContent = excerptDicString!
            }
                let postTitle = postsTitle[indexPath.row]
////            let postContent = postsContent[indexPath.row]
            let postImage = postsEmbed[indexPath.row]

        
            let imgArray = (postImage as AnyObject).value(forKey: "wp:featuredmedia")
                let mediaDetails = (imgArray as AnyObject).value(forKey: "media_details")
                let sizes = (mediaDetails as AnyObject).value(forKey: "sizes")
            let encoded = postTitle["rendered"] as? String
            cell.titleLabel.text = encoded?.stringByDecodingHTMLEntities
////            let title_ = encoded?.stringByDecodingHTMLEntities
////            let htmlTag =  postContent["rendered"] as! String
////            let content = htmlTag.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
////            let content_ = content.stringByDecodingHTMLEntities
            
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
            do{
                let full =  (sizes as AnyObject).value(forKey: "full")
                let dataDic = full as? [[String: Any]]
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
                   // to add1                cell.imagePost.image = UIImage(named: "placeholderImage.png")
                                } else {
                                    //     print("Success let using the image...")
                                    cell.imagePost.sd_setImage(with: imgUrl)
                                    
                                    
// MARK: - IMG HEIGHT
//                                    let heightCell = cell.frame.height
//                                    print(heightCell)
                                    let imgSize = image?.size.height
                                    let imgSize_f = Float(imgSize!)
                                    
                            //        print(tableView.frame.height)
                                    if imgSize_f > 1800.0{
                            //            print("\(indexPath.row) - imageHeight >>>>: \(imgSize_f)")
                                        self.fixHeight = 1200
                                    }else if imgSize_f > 1400.0{
                             //           print("\(indexPath.row) - imageHeight >>: \(imgSize_f)")
                                        self.fixHeight = 800
                                    }else{
                            //            print("\(indexPath.row) - imageHeight: \(imgSize!)")
                                        self.fixHeight = 400
                                    }
// MARK: - //
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
                  // to add1          cell.imagePost.image = UIImage(named: "loading4.jpg") //image place
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        height = fixHeight!
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsPostSegue" {
            let detailViewController = segue.destination as! DetailsPostViewController
             print("DetailsPost View segue")
             let cell = sender as! UITableViewCell
             let indexPath = tableView.indexPath(for: cell)
             let post = posts[(indexPath?.row)!]
             let postTitle = postsTitle[(indexPath?.row)!]
             let postContent = postsContent[(indexPath?.row)!]
             let imgPost = postsEmbed[(indexPath?.row)!]
             let nameString = postsEmbed[(indexPath?.row)!]
            let cate = post["categories"] as? [Any]
            let postFormat = post["format"] as? String
            print(postFormat!)
            
                
                 detailViewController.post = post
                 detailViewController.nameString = nameString
                 detailViewController.postTitle = postTitle
                 detailViewController.postContent = postContent
                 detailViewController.imgPost = imgPost
                detailViewController.categoryID = cate
                detailViewController.postFormat = postFormat
            if postFormat == "gallery"{
            }
            
            }
     }
    
}// End of Class






