//
//  ErrorReporting.swift
//  NovationApp
//
//  Created by Youxel MacBook 8 on 9/26/19.
//  Copyright © 2019 Youxel. All rights reserved.
//

import Foundation
import UIKit


protocol ErrorFeedBack {
}

extension ErrorFeedBack where Self:UIViewController
{
    func showErrorAlert(title: String, msg: String)
    {
        var  attrString = NSMutableAttributedString()
        var  attributedTitle = NSMutableAttributedString()
        if languageCode == "ar" {
            attrString = NSMutableAttributedString(string: msg, attributes: [.font: UIFont(name: "GESSTwoLight-Light", size: 14)!])
            attributedTitle = NSMutableAttributedString(string: title, attributes: [.font: UIFont(name: "GESSTwoLight-Light", size: 14)!])
        }else{
            attrString = NSMutableAttributedString(string: msg, attributes: [.font: UIFont(name: "MyriadPro-Regular", size: 14)!])
            attributedTitle = NSMutableAttributedString(string: title, attributes: [.font: UIFont(name: "MyriadPro-Regular", size: 14)!])
        }
        let VC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        VC.setValue(attrString, forKey: "attributedMessage")
        VC.setValue(attributedTitle, forKey: "attributedTitle")
        VC.addAction(UIAlertAction(title: "OK".localized(), style: .default, handler: {_ in self.dismiss(animated: true, completion: nil)}))

        present(VC, animated: true)
    }
    
}
