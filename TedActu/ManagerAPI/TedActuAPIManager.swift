//
//  TedActuAPIManager.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/9/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import Foundation

struct TedActuAPIManager{
    
    static let shared:TedActuAPIManager = TedActuAPIManager()
    
    func get(url:String, completion: @escaping ([[String: Any]]?, String?) -> Void ){
        let urlRequest = URLRequest(url: URL(string: url)!)
        URLSession.shared.dataTask(with: urlRequest) { ( data, response, error) in
           
            if error != nil {
                completion(nil, error?.localizedDescription)
                return
            }
           
            
            do{
                
                
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String : Any]]
    
                completion(json, nil)
                
                
            }catch{
                print("Error: \(error.localizedDescription)")
                
            }
                
        }.resume()
    }
}
