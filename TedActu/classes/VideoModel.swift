//
//  VideoModel.swift
//  TedActu
//
//  Created by Isaac Samuel on 3/29/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class VideoModel: NSObject {
    
    let UPLOADS_PLAYLIST_ID =  "UUYwjO810TxGsyEG9ytlRtbQ"
    let API_KEY = "AIzaSyBQqgKRuhh2JuqOpKpwRULqtydyYSRkvn4"
    let urlString = "https://www.googleapis.com/youtube/v3/playlistItems"
    
    var items: [[String: Any]] = []
    var snippet: [[String: Any]] = []
    var videoTitle: [[String: Any]] = []
    var videoDesc: [[String: Any]] = []
    var videoId: [[String: Any]] = []
    var videoTitleString: [String] = []
    var videoDescString: [String] = []
    var videoIdString: [String] = []
    
    func getFeedVideos(){
        
        // Alamofire 4
        let parameters: Parameters = ["part": "snippet", "playlistId": UPLOADS_PLAYLIST_ID, "key": API_KEY]
        
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
                
//                            var  videos = [video]()
//                            let video1 = video()
                
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
                                        self.videoTitleString.append(titleDic as! String)
                                   //     self.videoTitleString = (titleDic as! String)
                                        self.videoDescString.append(descDic as! String)
                                   //     self.videoDescString = (descDic as! String)
                                        self.videoIdString.append(videoId as! String)
//                                   //     self.videoIdString = (videoId as! String)
//                                        video1.videoTitle = self.videoTitleString!
//                                        video1.videoDes = self.videoDescString!
//                                        video1.videoId = self.videoIdString!
//                                        videos.append(video1)
                                        
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
                                    
                             print("json \(JSON)")
                           }
                        
            }
    }
    
//    func getVideos()-> [video]{
//
//        var  videos = [video]()
//        let video1 = video()
//
//         //Assign properties
//        for i in self.videoIdString{
//            video1.videoId = i
//            print("i: \(i)")
//            for t in videoTitleString{
//                video1.videoTitle = t
//                print("t: \(t)")
//            }
//            for d in videoDescString{
//                video1.videoDes = d
//                print("d: \(d)")
//            }
//        }
//        //Append it into array video
//        videos.append(video1)
//
//        return videos
//    }
    
    
//    func getFeedVideo(){
//
//        // Fetch video dynamically through the youtube data API (synchronous downloading )
//        // this make application more synchronous to prevent frozen app
//
//        Alamofire.request( url ,  method: .get , parameters:  ["part":"snippet" , "playlistId": id , "key": ApiKey ], encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) -> Void in
//
//            if let JSON = response.result.value as? [String:Any]  {//as? [String:Any] {
//
//                for video in JSON["items"] as! NSArray {
//
//                    print("video \(video)")
//
//                }
//
//             print("json \(JSON)")
//           }
//
//
//            
//        }
//
//
//
//    }//End function getFeedVideo
    
    
    
    func getVideo()-> [video]{
        
        var  videos = [video]()
        
        //video1
        //make an object
        let video1 = video()
        
        //Assign properties
        video1.videoId = "UftZhK_9IF0"
        video1.videoTitle = "Abitan koray ak Jerusalem ap rele anmwe pou leta ayisyen"
        
        video1.videoDes = "Abitan koray ak Jerusalem ap rele anmwe pou leta ayisyen ki pa JANM JANM pase wè yo malgre gwo menas Kowonaviris la.#FullRepoòtaj"
        
        
        //Append it into array video
        
        videos.append(video1)
        
        
        //video2
        
        //make an object
        let video2 = video()
        
        //Assign properties
        video2.videoId = "zzdCFYGLWjk"
        video2.videoTitle = "Retour sur le passage des sélections nationales amputées en terre dominicaine | Ted’Actu"
        
        
        video2.videoDes = "Ted'Actu et AHFA présentent Les sélections nationales (masculine et féminine) amputées lors de leur passage en République Dominicaine du 10 au 19 janvier 2020."
        
        //Append it into array video
        
        videos.append(video2)
        
        //video3
        
        //make an object
        let video3 = video()
        
        //Assign properties
        video3.videoId = "L2T2NtWIYPo"
        video3.videoTitle = "Mezi ak Prevansyon kont Coronavirus : gouvènman ayisyen an pote anpil presizyon | Ted’Actu" //"How To Make an App - Ep 3 - Xcode 7 Tutorial (Xcode 7, iOS 9)"
        
        
        
        video3.videoDes = "Nan yon pwen près ki bay nan rezidans Premye Minis lan jodi dimanch 15 mas 2020 an, chèf gouvènman an Joseph Jouthe ak Minis Enteryè a, Audin Bernadel Fils ak doktè Patrick Delile, pote anpil presizyon sou prevansyon ak mezi gouvènman pran kont Coronavirus la ki pa sispann fè raj nan anpil Kote nan mond lan."
        
        //Append it into array video
        
        videos.append(video3)
        
        
        //video4
        
        //make an object
        let video4 = video()
        
        //Assign properties
        video4.videoId = "skOhQGj9xXM"
        video4.videoTitle = "Mezi ak Prevansyon kont Coronavirus : gouvènman ayisyen an pote anpil presizyon | Ted’Actu"
        
        
        video4.videoDes = "Nan yon pwen près ki bay nan rezidans Premye Minis lan jodi dimanch 15 mas 2020 an, chèf gouvènman an Joseph Jouthe ak Minis Enteryè a, Audin Bernadel Fils ak doktè Patrick Delile, pote anpil presizyon sou prevansyon ak mezi gouvènman pran kont Coronavirus la ki pa sispann fè raj nan anpil Kote nan mond lan."
        
        //Append it into array video
        
        videos.append(video4)
        
        
        //video5
        
        //make an object
        let video5 = video()
        
        //Assign properties
        video5.videoId = "0eFYsjsMy8M"
        video5.videoTitle = "Polisye ki revoke yo pa dakò diskite ak Komisyon CSPN fòme a. Poukisa ? | Ted’Actu"
        
        
        
        video5.videoDes = "Polisye ki revoke yo te jwenn envitasyon komisyon CSPN kreye pou kapab idantifye revandikasyon tout polisye ki konpoze Sendika PNH la. Malgre yo reponn ak envitasyon an, yo pat aksepte chita ak komisyon sila a pou plizyè rezon." 
        
        //Append it into array video
        
        videos.append(video5)
        
        return videos
    }
    
}


