//
//  navgationBar.swift
//  NovationApp
//
//  Created by Youxel MacBook 8 on 9/1/19.
//  Copyright © 2019 Youxel. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setColorOfNavBlack(){
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "PrimaryColor")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "PrimaryColor")!]
    }
    
    func setColorOfNav(){
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "PrimaryColor")
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func imageInNavBar(){
//        let logo = UIImage(named: "logoBlack.png")
//        let imageView = UIImageView(image:logo)
//        self.navigationItem.titleView = imageView
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.layer.masksToBounds = true
        let image = UIImage(named: "Icon-60_120")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        
        
    }
    
}
