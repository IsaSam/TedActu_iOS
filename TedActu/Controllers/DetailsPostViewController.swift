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
//    @IBOutlet var titleLabel: UILabel!
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
        
//        activityIndicatoryWeb.hidesWhenStopped = true
        CategoriesID()
        PostSelect()

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
//    // show indicator
//    func webViewDidStartLoad(_ webView: UIWebView){
//        activityIndicatoryWeb.startAnimating()
//        activityIndicatoryWeb.isHidden = false
//    }
//    // hide indicator
//    func webViewDidFinishLoad(_ webView: UIWebView){
//        activityIndicatoryWeb.stopAnimating()
//        activityIndicatoryWeb.isHidden = true
//    }
//     // hide indicator
//    func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
//        activityIndicatoryWeb.stopAnimating()
//        activityIndicatoryWeb.isHidden = true
//    }
    
//    func topBarLogo(){
//        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
//        imageView.contentMode = .scaleAspectFit
//        let image = UIImage(named: "ayibopost-logo-blanc-2.png")
//        imageView.image = image
//        logoContainer.addSubview(imageView)
//        navigationItem.titleView = logoContainer
//    }
    
    
    func PostSelect(){
        
//        let titleDic = (post as AnyObject).value(forKey: "title")
        let contentDic = (post as AnyObject).value(forKey: "excerpt")
        let embedDic = (post as AnyObject).value(forKey: "_embedded")
        
//        let titleDicString = titleDic! as! [String : Any]
        let contentDicString = contentDic! as! [String: Any]
        let embedDicString = embedDic! as! [String: Any]
        
 //       titleLabel.text = (titleDicString as AnyObject).value(forKey: "rendered") as? String
 //       BookmarksUp = false
        let htmlTag = (contentDicString as AnyObject).value(forKey: "rendered") as? String
        let content = htmlTag?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        contentLabel.text = content?.stringByDecodingHTMLEntities
        contentLabel.text = "" // to remove
        
        // for images
        let imgArray = (embedDicString as AnyObject).value(forKey: "wp:featuredmedia")
        let mediaDetails = (imgArray as AnyObject).value(forKey: "media_details")
        let sizes = (mediaDetails as AnyObject).value(forKey: "sizes")
        
//        //Author Name
//        if let author = (embedDicString as AnyObject).value(forKey: "author"){
//            let dataDicAuthor = author as? [[String: Any]]
//            self.Name = dataDicAuthor!
//
//            let authorImg = (author as AnyObject).value(forKey: "simple_local_avatar")
//            let authorImgDic = authorImg as? [[String: Any]]
//            if authorImgDic != nil{
//                self.authorsImg = authorImgDic!
//            }
//
//        }
        
//        for author in Name{
//            let authorNameE = author["name"] as? String
//            let authorDescR = author["description"] as? String
//            let authorName = authorNameE?.stringByDecodingHTMLEntities
//            let authorDescr = authorDescR?.stringByDecodingHTMLEntities
//            if authorName == "Guest author" || authorName == "Admin" || authorName == "Ayibopost" {
//                authorNameLabel.text = ""
//                authorNameLabel2.text = ""
//            }else{
//                authorNameLabel.text = "Par " + authorName!
//                authorNameLabel2.text = authorName!
//            }
//            authorDesc.text = authorDescr!
//        }
        
//        for image in authorsImg{
//            let imageURL = image["80"] as? String
//            let imageURL2 = image["80"] as? String
//            if let imagePath = imageURL,
//                let imgUrl = URL(string:  imagePath){
//                authorPicture.layer.borderColor = UIColor.white.cgColor
//                authorPicture.layer.borderWidth = 2.0
//                authorPicture.layer.cornerRadius = authorPicture.frame.height / 2
//                authorPicture.clipsToBounds = true
//                authorPicture.af_setImage(withURL: imgUrl)
//            }
//            else{
//                authorPicture.layer.borderColor = UIColor.white.cgColor
//                authorPicture.layer.borderWidth = 2.0
//                authorPicture.layer.cornerRadius = authorPicture.frame.height / 2
//                authorPicture.clipsToBounds = true
//                //cell.imageTeam.image = nil
//                authorPicture.image = UIImage(named: "FN.jpg") //image place
//            }
//            if let imagePath2 = imageURL2,
//                let imgUrl2 = URL(string: imagePath2){
//                authorPicture2.layer.borderColor = UIColor.white.cgColor
//                authorPicture2.layer.borderWidth = 2.0
//                authorPicture2.layer.cornerRadius = authorPicture2.frame.height / 2
//                authorPicture2.clipsToBounds = true
//                authorPicture2.af_setImage(withURL: imgUrl2)
//            }
//            else{
//                authorPicture2.layer.borderColor = UIColor.white.cgColor
//                authorPicture2.layer.borderWidth = 2.0
//                authorPicture2.layer.cornerRadius = authorPicture2.frame.height / 2
//                authorPicture2.clipsToBounds = true
//                //cell.imageTeam.image = nil
//                authorPicture2.image = UIImage(named: "FN.jpg") //image place
//            }
//
//        }
        //Date
        
//        //date format conversion
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let newDateFormatter = DateFormatter()
//        //        newDateFormatter.dateFormat = "MMM dd, yyyy"
//        newDateFormatter.dateFormat = "dd MMM, yyyy"
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = "HH-mm-ss"
//        let newTimeFormatter = DateFormatter()
//        newTimeFormatter.dateFormat = "h:mm a"
//        let dateTime = post!["date"] as? String
//        let dateComponents = dateTime?.components(separatedBy: "T")
//        let splitDate = dateComponents![0]
//        let splitTime = dateComponents![1]
//        if let date = dateFormatter.date(from: splitDate) {
//            convertedDate = newDateFormatter.string(from: date)
//        }
//        if let time = timeFormatter.date(from: splitTime){
//            convertedTime = newTimeFormatter.string(from: time)
//        }
//        datePost.text = convertedDate
//        //Images
//        let html2 = htmlTag?.allStringsBetween(start: "<iframe src=", end: "</iframe>")
//        let input = String(describing: html2)
//        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
//        let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
//        for match in matches {
//            guard let range = Range(match.range, in: input) else { continue }
//            let urlYou = input[range]
//            if urlYou != ""{
//                urlYoutube = String(urlYou)
//                webView.isHidden = false
//            }
//        }
//        if urlYoutube != ""{
//                   print(urlYoutube)
//            self.postImageView.isHidden = true
//            webView.isHidden = false
//
//            webView.allowsInlineMediaPlayback = true
//            webView.loadHTMLString("<iframe width=\"\(webView.frame.width)\" height=\"\(webView.frame.height)\" src=\"\(urlYoutube)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
//       //     webView.delegate = self as? UIWebViewDelegate
//            self.activityIndicatoryWeb.stopAnimating()
//            self.activityIndicatoryWeb.isHidden = true
//        }
//        else{
//            webView.isHidden = true
//            self.activityIndicatoryWeb.stopAnimating()
//            //for images

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
              //  }
           // }

       // }

        
    }
    
//    // MARK: - Share Button
//
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
