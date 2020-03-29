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
    
       let UPLOADS_PLAYLIST_ID =  "UCYwjO810TxGsyEG9ytlRtbQ"
       let API_KEY = "AIzaSyC7fKfqeDD_QkhMRaS8Sd0Zk9d8mJFCTDE"
       let urlString = "https://www.googleapis.com/youtube/v3/playlistItems"
    
        let id =  "UCYwjO810TxGsyEG9ytlRtbQ"
        let ApiKey = "AIzaSyC7fKfqeDD_QkhMRaS8Sd0Zk9d8mJFCTDE"
        let url = "https://www.googleapis.com/youtube/v3/playlistItems"
    
    func getFeedVideos(){
        
        
        // Alamofire 4
        let parameters: Parameters = ["part": "snippet", "playlistId": UPLOADS_PLAYLIST_ID, "key": API_KEY]
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.queryString)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                print("*** success")
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
            }
        
    }
    
    func getFeedVideo(){
        
        // Fetch video dynamically through the youtube data API (synchronous downloading )
        // this make application more synchronous to prevent frozen app
        
        Alamofire.request( url ,  method: .get , parameters:  ["part":"snippet" , "playlistId": id , "key": ApiKey ], encoding: JSONEncoding.default, headers: nil).responseJSON{ (response) -> Void in
            
            if let JSON = response.result.value as? [String:Any]  {//as? [String:Any] {
                
                for video in JSON["items"] as! NSArray {
                    
                    print(video)
                
                }
                
             print("json \(JSON)")
           }
            
            
            
        }
 
        
        
    }//End function getFeedVideo
    
    
    
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
