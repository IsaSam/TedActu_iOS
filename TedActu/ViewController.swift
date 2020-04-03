//
//  ViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 3/19/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit
import BATabBarController

class ViewController: UIViewController {
        enum DemoTypes {
            case BATabBarWithText
            case BATabBarNoText
        }
        
        var  demotype = DemoTypes.BATabBarWithText
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            let testController = BATabBarController()

            var tabBarItem, tabBarItem2, tabBarItem3, tabBarItem4: BATabBarItem

            switch (self.demotype) {
            case .BATabBarWithText:
                let option1 = NSMutableAttributedString(string: "Accueil")
                option1.addAttribute(.foregroundColor, value: UIColor.clear, range: NSRange(location: 0, length: option1.length))
                
                let option2 = NSMutableAttributedString(string: "Catégories")
                option2.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: option1.length))
                
                let option3 = NSMutableAttributedString(string: "Playlists")
                option3.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: option1.length))
                
                let option4 = NSMutableAttributedString(string: "À Propos")
                option4.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: option1.length))
                
                tabBarItem  = BATabBarItem(image: UIImage(named: "home_unselected")!, selectedImage: UIImage(named: "home_selected")!, title: option1)
                tabBarItem2 = BATabBarItem(image: UIImage(named: "categories_unselected")!, selectedImage: UIImage(named: "categories_selected")!, title: option2)
                tabBarItem3 = BATabBarItem(image: UIImage(named: "video_playlist_unselected")!, selectedImage: UIImage(named: "video_playlist_selected")!, title: option3)
                tabBarItem4 = BATabBarItem(image: UIImage(named: "info_unselected")!, selectedImage: UIImage(named: "info_selected")!, title: option4)

            case .BATabBarNoText:
                tabBarItem  = BATabBarItem(image: UIImage(named: "home_unselected")!, selectedImage: UIImage(named: "home_selected")!)
                tabBarItem2 = BATabBarItem(image: UIImage(named: "categories_unselected")!, selectedImage: UIImage(named: "categories_selected")!)
                tabBarItem3 = BATabBarItem(image: UIImage(named: "video_playlist_unselected")!, selectedImage: UIImage(named: "video_playlist_selected")!)
                tabBarItem4 = BATabBarItem(image: UIImage(named: "info_unselected")!, selectedImage: UIImage(named: "info_selected")!)
            }

            let badge = BATabBarBadge(value: 1, badgeColor: .clear)
            tabBarItem.badge = badge


            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "homeView") as! HomeViewController
            self.navigationController?.pushViewController(vc1, animated: true)
            
            let vc2 = UIViewController()
            vc2.view.backgroundColor = .gray
            let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "PlayListView") as! PlaylistViewController
            self.navigationController?.pushViewController(vc3, animated: true)

            let vc4 = UIViewController()
            vc4.view.backgroundColor = .black
            

            testController.delegate = self
            testController.viewControllers = [vc1, vc2, vc3, vc4]
            testController.tabBarItems = [tabBarItem,tabBarItem2,tabBarItem3, tabBarItem4]


            //OPTIONAL SETTINGS

            //initial view controller
    //        testController.initialViewController = vc2

            //tab bar background color example
            testController.tabBarBackgroundColor = UIColor(red:0.00, green:0.11, blue:0.29, alpha:1.00)

            //tab bar item stroke color example
            testController.tabBarItemStrokeColor = UIColor(red:0.95, green:0.51, blue:0.19, alpha:1.00)

            //Tab bar line width example
            //testController.tabBarItemLineWidth = 9.0

            //Hides the tab bar when true
            //testController.hidesBottomBarWhenPushed = true

            self.view.addSubview(testController.view)
        }
        
    }

    extension ViewController: BATabBarControllerDelegate {
        func tabBarController(_ tabBarController: BATabBarController, didSelect: UIViewController) {
            print("Delegate success!")
        }
    }


