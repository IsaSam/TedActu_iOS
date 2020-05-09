//
//  ViewController.swift
//  FluidPhoto
//
//  Created by Masamichi Ueta on 2016/12/23.
//  Copyright © 2016 Masmichi Ueta. All rights reserved.
//

///////////////////////////////
import UIKit
import AlamofireImage
import SDWebImage
///////////////////////////////

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
//***    var photos: [UIImage]!
    var selectedIndexPath: IndexPath!
    
    //////////////////////////////////
    
        @IBOutlet var postImageView: UIImageView!
        @IBOutlet var titleLabel: UILabel!
        @IBOutlet weak var contentLabel: UILabel!
        @IBOutlet var downloadButton: UIButton!
        @IBOutlet weak var viewCategory: UIView!
        @IBOutlet weak var imgFeaturedGallery: UIImageView!
        @IBOutlet weak var backImgCat: UIImageView!
        
//        var filteredPosts: [String: Any]?
        var post: [String: Any]?
//        var imgPost: [String: Any]?
//        var urlPost1: String?
//        var urlYoutube = ""
//        var nameString: [String: Any]?
//        var postTitle: [String: Any]?
//        var postContent: [String: Any]?
//        var postImage: [String: Any]?
//        var imgPosts: [[String: Any]] = []
//        var categoryID: Any?
////        var imgURLShare: String?
//        var postFormat: String?
    
    var imgPosts1:  [UIImage] = []
    let reuseIdentifier = "cellGallery"
    
    var imageUrlIframe: [String] = []
    var cellWidth: CGFloat?
    var cellHeight: CGFloat?
    
    //////////////////////////////////
    
    //These variables are used to hold any updates to the safeAreaInsets
    //that might not have been propagated to this ViewController. This is required
    //for supporting devices running on >= iOS 11. These will be set manually from
    //PhotoZoomViewController.swift to ensure any changes to the safeAreaInsets
    //after the device rotates are pushed to this ViewController. This is required
    //to ensure the collectionView.convert() function calculates the proper
    //frame result inside referenceImageViewFrameInTransitioningView()
    var currentLeftSafeAreaInset  : CGFloat = 0.0
    var currentRightSafeAreaInset : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  print("** \(myPostVar.post ?? [:])")
        
        /////////////////////////////////
                    collectionView.delegate = self
                    collectionView.dataSource = self
                
        //        assignbackground()
        //        self.tabBarController?.tabBar.isHidden = true
                
        //        activityIndicatoryWeb.hidesWhenStopped = true
        //        CategoriesID()
                PostSelect()
        ////////////////////////////////
        
  /***      self.photos = [
            #imageLiteral(resourceName: "1"),
            #imageLiteral(resourceName: "2"),
            #imageLiteral(resourceName: "3"),
            #imageLiteral(resourceName: "4"),
            #imageLiteral(resourceName: "5"),
            #imageLiteral(resourceName: "6"),
            #imageLiteral(resourceName: "7"),
            #imageLiteral(resourceName: "8"),
            #imageLiteral(resourceName: "9"),
            #imageLiteral(resourceName: "10"),
            #imageLiteral(resourceName: "11"),
            #imageLiteral(resourceName: "12"),
            #imageLiteral(resourceName: "13"),
            #imageLiteral(resourceName: "14"),
            #imageLiteral(resourceName: "15"),
            #imageLiteral(resourceName: "16"),
            #imageLiteral(resourceName: "17"),
            #imageLiteral(resourceName: "18"),
            #imageLiteral(resourceName: "1"),
            #imageLiteral(resourceName: "2"),
            #imageLiteral(resourceName: "3"),
            #imageLiteral(resourceName: "4"),
            #imageLiteral(resourceName: "5"),
            #imageLiteral(resourceName: "6"),
            #imageLiteral(resourceName: "7"),
            #imageLiteral(resourceName: "8"),
            #imageLiteral(resourceName: "9"),
            #imageLiteral(resourceName: "10"),
            #imageLiteral(resourceName: "11"),
            #imageLiteral(resourceName: "12"),
            #imageLiteral(resourceName: "13"),
            #imageLiteral(resourceName: "14"),
            #imageLiteral(resourceName: "15"),
            #imageLiteral(resourceName: "16"),
            #imageLiteral(resourceName: "17"),
            #imageLiteral(resourceName: "18")
        ]
        */
        //Manually set the collectionView frame to the size of the view bounds
        //(this is required to support iOS 10 devices and earlier)
        self.collectionView.frame = self.view.bounds
        
    }
    
    ///////////////////////
    
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
    ///////////////////////
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        ///////////////////////////////
        topBarLogo()
        view.backgroundColor = .black
        //////////////////////////////
    }
    //////////////////////////////////
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
    ////////////////////////////
//MARK: --
    
    
       func PostSelect(){
           
//           let titleDic = (post as AnyObject).value(forKey: "title")
        let contentDic = (post as AnyObject).value(forKey: "content")
//        let embedDic = (myPostVar.post as AnyObject).value(forKey: "_embedded")
           
//           let titleDicString = titleDic! as! [String : Any]
           let contentDicString = contentDic! as! [String: Any]
//           let embedDicString = embedDic! as! [String: Any]
           
//           let htmlTitle = (titleDicString as AnyObject).value(forKey: "rendered") as? String
//           let title = htmlTitle?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
//           titleLabel.text = title?.stringByDecodingHTMLEntities
           
    //       BookmarksUp = false
           let htmlTag = (contentDicString as AnyObject).value(forKey: "rendered") as? String
           let content = htmlTag?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
//           contentLabel.text = content?.stringByDecodingHTMLEntities
//           contentLabel.text = "" // to remove
           
//           // for images
//           let imgArray = (embedDicString as AnyObject).value(forKey: "wp:featuredmedia")
//           let mediaDetails = (imgArray as AnyObject).value(forKey: "media_details")
//           let sizes = (mediaDetails as AnyObject).value(forKey: "sizes")
           
           // MARK: - Take image iframe
           
           //Images
           print("htmlTag: \(htmlTag ?? "nil")")
           let htmlTag2 = htmlTag?.stringByDecodingHTMLEntities
           print("htmlTag2: \(htmlTag2 ?? "nil")")
      //     let html2 = htmlTag2?.allStringsBetween(start: "<iframe src=", end: "</iframe>")
           let html2 = htmlTag2?.allStringsBetween(start: "<iframe frameborder=", end: "</iframe>")
           
           let input = String(describing: html2)
           print("input: \(input)")
           let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
           let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
           print("match: \(matches)")
           for match in matches {
               guard let range = Range(match.range, in: input) else { continue }
               let urlIMG = input[range]
               if urlIMG != ""{
                   imageUrlIframe.append(String(urlIMG))
                   print("ImageFrame: \(urlIMG)")
               }else{print("nnnil2")}
           }
           
           // MARK: -

//           do{
//               if let fullImg =  (sizes as AnyObject).value(forKey: "full"){
//                           let dataDic = fullImg as? [[String: Any]]
//
//                           if dataDic != nil{
//                               self.imgPosts = dataDic!
//                               print("image size full founded")
//                           }
//                           else{
//                               print("saved sizes not founded")
//                           }
//                           for images in imgPosts{
//                               let imageURL = images["source_url"] as? String
//                               imgURLShare = imageURL
//                               if let imagePath = imageURL,
//                                   let imgUrl = URL(string:  imagePath){
//                                   postImageView.af_setImage(withURL: imgUrl)
//                                   imgFeaturedGallery.af_setImage(withURL: imgUrl)
//
//                                   imgFeaturedGallery.layer.cornerRadius = 17.0
//                                   imgFeaturedGallery.clipsToBounds = true
//                                   imgFeaturedGallery.layer.borderWidth = 2.0
//                                   imgFeaturedGallery.layer.borderColor = UIColor.white.cgColor
//
//                               }
//                               else{
//                                   postImageView.image = nil
//                               }
//                           }
//                       }
//                   }
       }

    /////////////////////////////
    
    override func viewSafeAreaInsetsDidChange() {
    
        //if the application launches in landscape mode, the safeAreaInsets
        //need to be updated from 0.0 if the device is an iPhone X model. At
        //application launch this function is called before viewWillLayoutSubviews()
        if #available(iOS 11, *) {
            
            self.currentLeftSafeAreaInset = self.view.safeAreaInsets.left
            self.currentRightSafeAreaInset = self.view.safeAreaInsets.right
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        
        //Only perform these changes for devices running iOS 11 and later. This is called
        //inside viewWillLayoutSubviews() instead of viewWillTransition() because when the
        //device rotates, the navBarHeight and statusBarHeight will be calculated inside
        //viewWillTransition() using the current orientation, and not the orientation
        //that the device will be at the end of the transition.
        
        //By the time that viewWillLayoutSubviews() is called, the views frames have been
        //properly updated for the new orientation, so the navBar and statusBar height values
        //can be calculated and applied directly as per the code below
        
        if #available(iOS 11, *) {
            
            self.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.bounds.size)
            self.collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.view.bounds.size)
            
            self.collectionView.contentInsetAdjustmentBehavior = .never
            let statusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.height
            let navBarHeight : CGFloat = navigationController?.navigationBar.frame.height ?? 0
            self.edgesForExtendedLayout = .all
            let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
            
            if UIDevice.current.orientation.isLandscape {
                self.collectionView.contentInset = UIEdgeInsets(top: (navBarHeight) + statusBarHeight, left: self.currentLeftSafeAreaInset, bottom: tabBarHeight, right: self.currentRightSafeAreaInset)
            }
            else {
                self.collectionView.contentInset = UIEdgeInsets(top: (navBarHeight) + statusBarHeight, left: 0.0, bottom: tabBarHeight, right: 0.0)
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if #available(iOS 11, *) {
            //Do nothing
        }
        else {
            
            //Support for devices running iOS 10 and below
            
            //Check to see if the view is currently visible, and if so,
            //animate the frame transition to the new orientation
            if self.viewIfLoaded?.window != nil {
                
                coordinator.animate(alongsideTransition: { _ in
                    
                    //This needs to be called inside viewWillTransition() instead of viewWillLayoutSubviews()
                    //for devices running iOS 10.0 and earlier otherwise the frames for the view and the
                    //collectionView will not be calculated properly.
                    self.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
                    self.collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
                    
                }, completion: { _ in
                    
                    //Invalidate the collectionViewLayout
                    self.collectionView.collectionViewLayout.invalidateLayout()
                    
                })
                
            }
            //Otherwise, do not animate the transition
            else {
                
                self.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
                self.collectionView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    
                //Invalidate the collectionViewLayout
                self.collectionView.collectionViewLayout.invalidateLayout()
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhotoPageView" {
            let nav = self.navigationController
            let vc = segue.destination as! PhotoPageContainerViewController
            nav?.delegate = vc.transitionController
            vc.transitionController.fromDelegate = self
            vc.transitionController.toDelegate = vc
            vc.delegate = self
            vc.currentIndex = self.selectedIndexPath.row
            vc.photos = self.imgPosts1
        }
    }
    
    @IBAction func backToViewController(segue: UIStoryboardSegue) {
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       //*** return self.photos.count
        return self.imageUrlIframe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCollectionViewCell.self)", for: indexPath) as! PhotoCollectionViewCell
        
        //////////////////////////////////
///        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PhotoCollectionViewCell //cellGallery

        cell.imageView.layer.cornerRadius = 17.0
        cell.imageView.clipsToBounds = true
        cell.imageView.layer.borderWidth = 2.0
        cell.imageView.layer.borderColor = UIColor.white.cgColor
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.96, alpha: 1.00)// make cell more visible in our example project
        cell.imageView.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.96, alpha: 1.00)
//to add        cell.widthImageConstraint.constant = self.cellWidth!
//to add        cell.heightImageConstraint.constant = self.cellHeight!
        
           let imageURL = imageUrlIframe[indexPath.row]
           print("urlI: \(imageURL) - \(indexPath.row)")
        
           let imagePath = imageURL
           let imgUrl = URL(string:  imagePath)
                            cell.imageView.sd_setImage(with: imgUrl, placeholderImage:nil, completed: { (image, error, cacheType, imgUrl) -> Void in
                                if ((error) != nil) {
                                } else {
                                    print("Success let using the image...")
                                    cell.imageView.sd_setImage(with: imgUrl)
                                        
                                    let img = cell.imageView.image
                                   
                                    self.imgPosts1.append(img!)
                                    //self.imgPosts1.append(cell.imageView.image!)
         
                               }
               })
        /////////////////////////////////
        
      //***  cell.imageView.image = self.photos[indexPath.row]
        return cell
    }
    
    ////////////////////////////////
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        self.cellWidth = collectionView.frame.size.width
        self.cellHeight = collectionView.frame.size.height
        print("&&&: \(cellWidth!) - \(cellHeight!)")
        
        // corner image
        collectionView.layer.cornerRadius = 17.0
        collectionView.clipsToBounds = true
        collectionView.layer.borderWidth = 2.0
        collectionView.layer.borderColor = UIColor.white.cgColor
        
        return CGSize(width: size, height: size)
    }
    ///////////////////////////////
        // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "ShowPhotoPageView", sender: self)
    }
    
    //This function prevents the collectionView from accessing a deallocated cell. In the event
    //that the cell for the selectedIndexPath is nil, a default UIImageView is returned in its place
    func getImageViewFromCollectionViewCell(for selectedIndexPath: IndexPath) -> UIImageView {
        
        //Get the array of visible cells in the collectionView
        let visibleCells = self.collectionView.indexPathsForVisibleItems
        
        //If the current indexPath is not visible in the collectionView,
        //scroll the collectionView to the cell to prevent it from returning a nil value
        if !visibleCells.contains(self.selectedIndexPath) {
           
            //Scroll the collectionView to the current selectedIndexPath which is offscreen
            self.collectionView.scrollToItem(at: self.selectedIndexPath, at: .centeredVertically, animated: false)
            
            //Reload the items at the newly visible indexPaths
            self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
            self.collectionView.layoutIfNeeded()
            
            //Guard against nil values
            guard let guardedCell = (self.collectionView.cellForItem(at: self.selectedIndexPath) as? PhotoCollectionViewCell) else {
                //Return a default UIImageView
                return UIImageView(frame: CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 100.0, height: 100.0))
            }
            //The PhotoCollectionViewCell was found in the collectionView, return the image
            return guardedCell.imageView
        }
        else {
            
            //Guard against nil return values
            guard let guardedCell = self.collectionView.cellForItem(at: self.selectedIndexPath) as? PhotoCollectionViewCell else {
                //Return a default UIImageView
                return UIImageView(frame: CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 100.0, height: 100.0))
            }
            //The PhotoCollectionViewCell was found in the collectionView, return the image
            return guardedCell.imageView
        }
        
    }
    
    //This function prevents the collectionView from accessing a deallocated cell. In the
    //event that the cell for the selectedIndexPath is nil, a default CGRect is returned in its place
    func getFrameFromCollectionViewCell(for selectedIndexPath: IndexPath) -> CGRect {
        
        //Get the currently visible cells from the collectionView
        let visibleCells = self.collectionView.indexPathsForVisibleItems
        
        //If the current indexPath is not visible in the collectionView,
        //scroll the collectionView to the cell to prevent it from returning a nil value
        if !visibleCells.contains(self.selectedIndexPath) {
            
            //Scroll the collectionView to the cell that is currently offscreen
            self.collectionView.scrollToItem(at: self.selectedIndexPath, at: .centeredVertically, animated: false)
            
            //Reload the items at the newly visible indexPaths
            self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
            self.collectionView.layoutIfNeeded()
            
            //Prevent the collectionView from returning a nil value
            guard let guardedCell = (self.collectionView.cellForItem(at: self.selectedIndexPath) as? PhotoCollectionViewCell) else {
                return CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 100.0, height: 100.0)
            }
            
            return guardedCell.frame
        }
        //Otherwise the cell should be visible
        else {
            //Prevent the collectionView from returning a nil value
            guard let guardedCell = (self.collectionView.cellForItem(at: self.selectedIndexPath) as? PhotoCollectionViewCell) else {
                return CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: 100.0, height: 100.0)
            }
            //The cell was found successfully
            return guardedCell.frame
        }
    }
    
}


extension ViewController: PhotoPageContainerViewControllerDelegate {
 
    func containerViewController(_ containerViewController: PhotoPageContainerViewController, indexDidUpdate currentIndex: Int) {
        self.selectedIndexPath = IndexPath(row: currentIndex, section: 0)
        self.collectionView.scrollToItem(at: self.selectedIndexPath, at: .centeredVertically, animated: false)
    }
}

extension ViewController: ZoomAnimatorDelegate {
    
    func transitionWillStartWith(zoomAnimator: ZoomAnimator) {
        
    }
    
    func transitionDidEndWith(zoomAnimator: ZoomAnimator) {
        let cell = self.collectionView.cellForItem(at: self.selectedIndexPath) as! PhotoCollectionViewCell
        
        let cellFrame = self.collectionView.convert(cell.frame, to: self.view)
        
        if cellFrame.minY < self.collectionView.contentInset.top {
            self.collectionView.scrollToItem(at: self.selectedIndexPath, at: .top, animated: false)
        } else if cellFrame.maxY > self.view.frame.height - self.collectionView.contentInset.bottom {
            self.collectionView.scrollToItem(at: self.selectedIndexPath, at: .bottom, animated: false)
        }
    }
    
    func referenceImageView(for zoomAnimator: ZoomAnimator) -> UIImageView? {
        
        //Get a guarded reference to the cell's UIImageView
        let referenceImageView = getImageViewFromCollectionViewCell(for: self.selectedIndexPath)
        
        return referenceImageView
    }
    
    func referenceImageViewFrameInTransitioningView(for zoomAnimator: ZoomAnimator) -> CGRect? {
        
        self.view.layoutIfNeeded()
        self.collectionView.layoutIfNeeded()
        
        //Get a guarded reference to the cell's frame
        let unconvertedFrame = getFrameFromCollectionViewCell(for: self.selectedIndexPath)
        
        let cellFrame = self.collectionView.convert(unconvertedFrame, to: self.view)
        
        if cellFrame.minY < self.collectionView.contentInset.top {
            return CGRect(x: cellFrame.minX, y: self.collectionView.contentInset.top, width: cellFrame.width, height: cellFrame.height - (self.collectionView.contentInset.top - cellFrame.minY))
        }
        
        return cellFrame
    }
    
}
