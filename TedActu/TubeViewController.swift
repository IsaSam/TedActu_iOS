//
//  TubeViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 3/24/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class TubeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var videos:[Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let video = Video()
        video.Key = "zzdCFYGLWjk"
        video.Title = "Retour sur le passage des sélections nationales"
        videos.append(video)
        
        let video = Video()
        video.Key = "zzdCFYGLWjk"
        video.Title = "Retour sur le passage des sélections nationales"
        videos.append(video)
        
        let video = Video()
        video.Key = "zzdCFYGLWjk"
        video.Title = "Retour sur le passage des sélections nationales"
        videos.append(video)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VideoTableViewCell
         
         cell.videoTitle.text = videos[indexPath.row].Title
         let url = "https://img.youtube.com/vi/\(videos[indexPath.row].Key)/0.jpg"
         cell.videoImage.downloaded(from: url)
        // cell.videoImage.image = UIImage(named: String(videos[indexPath.row].Key))
         
         return cell
    }
 
    class Video{
        var Key:String = ""
        var Title:String = ""
    }
}

extension UIImageView{
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return}
        downloaded(from: url, contentMode: mode)
    }
}
