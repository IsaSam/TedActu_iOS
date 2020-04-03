//
//  HomeViewController.swift
//  TedActu
//
//  Created by Isaac Samuel on 4/2/20.
//  Copyright © 2020 Isaac Samuel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var myImages: [UIImage] = [
        UIImage(named: "feed1.png")!,
        UIImage(named: "feed2.png")!,
        UIImage(named: "feed3.png")!,
        UIImage(named: "feed4.png")!,
        UIImage(named: "feed5.png")!,
        UIImage(named: "feed6.png")!,
        UIImage(named: "feed7.png")!,
        UIImage(named: "feed8.png")!
    ]
    
    var myDescriptions: [String] = [
        "Le bilan s'élève à plus de 900 000 cas de Covid-19 dans 187 pays et territoires, dont 215 000 aux Etats-Unis où la maladie progresse le plus vite.",
        """
            Toujours par arrêté,

            Le citoyen Michelet COMEAU, a été nommé Directeur Général du Ministère de l’Économie et des Finances.

            Le citoyen Rode TOUSSAINT, a été nommé Directeur Général du Ministère des Travaux Publics, Transports et Communications.

            Le citoyen Jean Marie Harry SALOMON, a été nommé Directeur Général adjoint de l’Institut Haïtien de Statistique et d’Informatique (IHSI).
        """,
        """
            Si vous utilisez Android 9 et les versions inférieures,
            * Allez dans l’application WhatsApp
            * Puis dans Réglages
            * Discussions
            * Thèmes
            * Choisissez le mode sombre.
        """,
        "L’attaquant de 19 ans devance le joueur du FC Barcelone Ansu Fati et Mason Greenwood de Manchester United, respectivement 2ème et 3ème.",
        "Levez la main si vous l'avez déjà remarqué.",
        "L’attaquant de 19 ans devance le joueur du FC Barcelone Ansu Fati et Mason Greenwood de Manchester United, respectivement 2ème et 3ème.",
        "Si vous avez déjà retiré votre billet, ne vous inquiétez pas. Il sera valide pour 2021.",
        "L'heure est grave."
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HomeViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! HomeTableViewCell
    
        cell.imageFeed?.image = myImages[indexPath.row]
        
        return cell
        
    }
 
    
    
}







