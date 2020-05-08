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

class DetailsPostViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "cellGallery" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
                // get a reference to our storyboard cell
               // get a reference to our storyboard cell
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! cellGallery

        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.item]
        cell.myLabel.textColor = .black
        cell.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.96, alpha: 1.00)// make cell more visible in our example project

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    // MARK: - UICollectionViewDelegate protocol

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
//    @IBOutlet weak var viewTitleLabel: UIView!
    @IBOutlet var downloadButton: UIButton!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var imgFeaturedGallery: UIImageView!
    @IBOutlet weak var backImgCat: UIImageView!
    
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
    var imgURLShare: String?
    var postFormat: String?
    
    // MARK: - Main
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if postFormat == "gallery"{
           viewCategory.isHidden = false
            
            
        }else{
            viewCategory.isHidden = true
        }
        topBarLogo()
        view.backgroundColor = .black
        
    }
    func topBarLogo(){
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo-text-white.png")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        
        //backButton color
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.94, green: 0.47, blue: 0.19, alpha: 1.00)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if postFormat == "gallery"{
            collectionView.delegate = self
            collectionView.dataSource = self
            
//            let layout =  collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
//                layout!.minimumLineSpacing = 10
//                    layout!.minimumInteritemSpacing = 10
//                    layout!.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//                    let size = CGSize(width:(collectionView!.bounds.width-30)/2, height: 250)
//                    layout!.itemSize = size
            
        }
        
        assignbackground()
        self.tabBarController?.tabBar.isHidden = true
        
//        activityIndicatoryWeb.hidesWhenStopped = true
        CategoriesID()
        PostSelect()

         }
    
    // Set a background image scale to view
    func assignbackground(){
          let background = UIImage(named: "back-img-white2")

          var imageView : UIImageView!
          imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleToFill
          imageView.clipsToBounds = true
          imageView.image = background
          imageView.center = view.center
          view.addSubview(imageView)
          self.view.sendSubviewToBack(imageView)
      }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    func CategoriesID(){
        if categoryID != nil{
                    if categoryID as? NSObject == [16] as? NSObject{
                        titleLabel.backgroundColor = UIColor(red: 0.47, green: 0.12, blue: 0.07, alpha: 1.00)
                        print("Politique")
                        categoryID = 16
                    }else if categoryID as? NSObject == [22] as? NSObject{
                        titleLabel.backgroundColor = UIColor(red: 0.91, green: 0.72, blue: 0.18, alpha: 1.00)
                        print("(((")
                        print("Savoir+")
                        categoryID = 22
                    }
                    else if categoryID as? NSObject == [23] as? NSObject{
                        titleLabel.backgroundColor = UIColor(red: 0.02, green: 0.02, blue: 0.02, alpha: 1.00)
                        print("Anket")
                        categoryID = 23
                    }
                    else if categoryID as? NSObject == [19] as? NSObject{
                        titleLabel.backgroundColor = UIColor(red: 0.19, green: 0.63, blue: 0.98, alpha: 1.00)
                        print("Sport")
                        categoryID = 19
                    }
                    else if categoryID as? NSObject == [20] as? NSObject{
                        titleLabel.backgroundColor = UIColor(red: 0.25, green: 0.54, blue: 0.16, alpha: 1.00)
                        print("Culture")
                        categoryID = 20
                    }
                    else if categoryID as? NSObject == [18] as? NSObject{
                        titleLabel.backgroundColor = UIColor(red: 0.50, green: 0.20, blue: 0.56, alpha: 1.00)
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
        

        do{
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
                            imgURLShare = imageURL
                            if let imagePath = imageURL,
                                let imgUrl = URL(string:  imagePath){
                                postImageView.af_setImage(withURL: imgUrl)
                                imgFeaturedGallery.af_setImage(withURL: imgUrl)
                                
                                imgFeaturedGallery.layer.cornerRadius = 17.0
                                imgFeaturedGallery.clipsToBounds = true
                                imgFeaturedGallery.layer.borderWidth = 2.0
 //                               imgFeaturedGallery.layer.masksToBounds = false
                                imgFeaturedGallery.layer.borderColor = UIColor.white.cgColor
                                
                            }
                            else{
                                postImageView.image = nil
                            }
                        }
                    }
                }
    }
    
    // MARK: - Share and Download Image

    @IBAction func btnShareTapped(_ sender: Any) {
        let title = titleLabel.text
        let URl = post![PostKeys.link]
        let image = postImageView.image

        let vc = UIActivityViewController(activityItems: [title, URl, image], applicationActivities: [])
        if let popoverController = vc.popoverPresentationController{
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.view.bounds
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Saving Image here
    @IBAction func save(_ sender: AnyObject) {
        guard let selectedImage = postImageView.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Image Saved!", message: "Your image has been saved to your photos.")
        }
    }

    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
