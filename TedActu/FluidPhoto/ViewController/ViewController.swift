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
    
    var selectedIndexPath: IndexPath!
    
    //////////////////////////////////
    
 //       @IBOutlet var postImageView: UIImageView!
        @IBOutlet weak var contentLabel: UILabel!
        
        var post: [String: Any]?
    
    var imgPosts1:  [UIImage] = []
    let reuseIdentifier = "cellGallery"
    
    var imageUrlIframe: [String] = []
//    var cellWidth: CGFloat?
//    var cellHeight: CGFloat?
    
    //////////////////////////////////
    var currentLeftSafeAreaInset  : CGFloat = 0.0
    var currentRightSafeAreaInset : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /////////////////////////////////
                    collectionView.delegate = self
                    collectionView.dataSource = self

                PostSelect()

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
           
        let contentDic = (post as AnyObject).value(forKey: "content")
           let contentDicString = contentDic! as! [String: Any]

           let htmlTag = (contentDicString as AnyObject).value(forKey: "rendered") as? String

           
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
        return self.imageUrlIframe.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCollectionViewCell.self)", for: indexPath) as! PhotoCollectionViewCell
        

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
                        
         
                               }
               })
        /////////////////////////////////
        
        return cell
    }
    
    ////////////////////////////////
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
//        self.cellWidth = collectionView.frame.size.width
//        self.cellHeight = collectionView.frame.size.height
//        print("&&&: \(cellWidth!) - \(cellHeight!)")

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
        if selectedIndexPath != nil{
            let cell = self.collectionView.cellForItem(at: self.selectedIndexPath) as! PhotoCollectionViewCell
            
            let cellFrame = self.collectionView.convert(cell.frame, to: self.view)
        
        
        if cellFrame.minY < self.collectionView.contentInset.top {
            self.collectionView.scrollToItem(at: self.selectedIndexPath, at: .top, animated: false)
        } else if cellFrame.maxY > self.view.frame.height - self.collectionView.contentInset.bottom {
            self.collectionView.scrollToItem(at: self.selectedIndexPath, at: .bottom, animated: false)
            }
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
