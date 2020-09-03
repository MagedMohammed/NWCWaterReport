//
//  Constants.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/31/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import Foundation
import Localization

class Constants {
    
    static var LoginObject = UserDefaults.standard.retrieve(object: LoginObj.self, fromKey: "LoginObject")
    static func setLanguage(){
        let preferredLanguage = UserDefaults.standard.string(forKey: "languageCode" )
        if preferredLanguage == "en" {
            Localization.preferredLanguage = LocalizableLanguage(code: LocalizableLanguage.english.code)!.code
            languageCode = "en"
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            setupMainWindow()
//            UserDefaults.standard.set("en", forKey: "languageCode")
            
        } else if preferredLanguage == "ar" || preferredLanguage == nil  {
            Localization.preferredLanguage = LocalizableLanguage(code: LocalizableLanguage.arabic.code)!.code
            languageCode = "ar"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            setupMainWindow()
//            UserDefaults.standard.set("ar", forKey: "languageCode")
            
        }
    }
    
    /**
    Convert UIImage to a base64 representation
    - Parameters:
    - image : passed image to be converted
     - Returns: String
    */
    class func convertImageToBase64(image: UIImage) -> String {
         let userImageData:NSData = image.jpegData(compressionQuality: 0.25)! as NSData
         let userImgString = userImageData.base64EncodedString(options: .init(rawValue: 0))
         return userImgString
     }
}
