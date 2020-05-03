//
//  DetailsPostViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/30/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit
//import WebKit

enum PostKeys {
    static let title = "rendered"
    static let content = "rendered"
    static let image = "_embedded"
    static let date = "date"
    static let link = "link"
}

class DetailsPostViewController: UIViewController{
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var viewTitleLabel: UIView!
    
//    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var activityIndicatory: UIActivityIndicatorView!
    
    var filteredPosts: [String: Any]?
    var post: [String: Any]?
    var imgPost: [String: Any]?
    var urlPost1: String?
    var urlYoutube = ""
    var nameString: [String: Any]?
    var postTitle: [String: Any]?
    var postContent: [String: Any]?
    var postImage: [String: Any]?
    var imgPosts: [[String: Any]] = []
    var categoryID: Any?
    
    // MARK: - Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
//        activityIndicatoryWeb.hidesWhenStopped = true
        CategoriesID()
        PostSelect()

         }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    func CategoriesID(){
        if categoryID != nil{
                    if categoryID as? NSObject == [16] as? NSObject{
                        viewTitleLabel.backgroundColor = UIColor(red: 0.47, green: 0.12, blue: 0.07, alpha: 1.00)
                        print("Politique")
                        categoryID = 16
                    }else if categoryID as? NSObject == [22] as? NSObject{
                        viewTitleLabel.backgroundColor = UIColor(red: 0.91, green: 0.72, blue: 0.18, alpha: 1.00)
                        print("(((")
                        print("Savoir+")
                        categoryID = 22
                    }
                    else if categoryID as? NSObject == [23] as? NSObject{
                        viewTitleLabel.backgroundColor = UIColor(red: 0.02, green: 0.02, blue: 0.02, alpha: 1.00)
                        print("Anket")
                        categoryID = 23
                    }
                    else if categoryID as? NSObject == [19] as? NSObject{
                        viewTitleLabel.backgroundColor = UIColor(red: 0.19, green: 0.63, blue: 0.98, alpha: 1.00)
                        print("Sport")
                        categoryID = 19
                    }
                    else if categoryID as? NSObject == [20] as? NSObject{
                        viewTitleLabel.backgroundColor = UIColor(red: 0.25, green: 0.54, blue: 0.16, alpha: 1.00)
                        print("Culture")
                        categoryID = 20
                    }
                    else if categoryID as? NSObject == [18] as? NSObject{
                        viewTitleLabel.backgroundColor = UIColor(red: 0.50, green: 0.20, blue: 0.56, alpha: 1.00)
                        print("Société")
                        categoryID = 18
                    }
        }
    }
  
    func PostSelect(){
        
        let titleDic = (post as AnyObject).value(forKey: "title")
        let contentDic = (post as AnyObject).value(forKey: "excerpt")
        let embedDic = (post as AnyObject).value(forKey: "_embedded")
        
        let titleDicString = titleDic! as! [String : Any]
        let contentDicString = contentDic! as! [String: Any]
        let embedDicString = embedDic! as! [String: Any]
        
        let htmlTitle = (titleDicString as AnyObject).value(forKey: "rendered") as? String
        let title = htmlTitle?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        titleLabel.text = title?.stringByDecodingHTMLEntities
        
 //       BookmarksUp = false
        let htmlTag = (contentDicString as AnyObject).value(forKey: "rendered") as? String
        let content = htmlTag?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        contentLabel.text = content?.stringByDecodingHTMLEntities
        contentLabel.text = "" // to remove
        
        // for images
        let imgArray = (embedDicString as AnyObject).value(forKey: "wp:featuredmedia")
        let mediaDetails = (imgArray as AnyObject).value(forKey: "media_details")
        let sizes = (mediaDetails as AnyObject).value(forKey: "sizes")
        

     //   do{
            if let fullImg =  (sizes as AnyObject).value(forKey: "full"){
                        let dataDic = fullImg as? [[String: Any]]

                        if dataDic != nil{
                            self.imgPosts = dataDic!
                            print("image size full founded")
                        }
                        else{
                            print("saved sizes not founded")
                        }
                        for images in imgPosts{
                            let imageURL = images["source_url"] as? String
                            if let imagePath = imageURL,
                                let imgUrl = URL(string:  imagePath){
                                postImageView.af_setImage(withURL: imgUrl)
                            }
                            else{
                                postImageView.image = nil
                            }
                        }
                    }
                //}
    }
    
    // MARK: - Share Button

//    @IBAction func btnShareTapped(_ sender: Any) {
//        let title = titleLabel.text
//        let URl = post![PostKeys.link]
//        let image = postImageView.image
//
//        let vc = UIActivityViewController(activityItems: [title, URl, image], applicationActivities: [])
//        if let popoverController = vc.popoverPresentationController{
//            popoverController.sourceView = self.view
//            popoverController.sourceRect = self.view.bounds
//        }
//        self.present(vc, animated: true, completion: nil)
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
