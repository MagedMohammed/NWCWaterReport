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
    
    static var  decoded  = UserDefaults.standard.data(forKey: "LoginObject")
    static var LoginObject = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [LoginObj]
//    static var LoginObject = UserDefaults.standard.value(forKey: "LoginObject")
    static func setLanguage(){
        let preferredLanguage = UserDefaults.standard.string(forKey: "languageCode" )
        if preferredLanguage != "en" {
            Localization.preferredLanguage = LocalizableLanguage(code: LocalizableLanguage.english.code)!.code
            languageCode = "en"
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            setupMainWindow()
            UserDefaults.standard.set("en", forKey: "languageCode")
            
        } else if preferredLanguage != "ar" {
            Localization.preferredLanguage = LocalizableLanguage(code: LocalizableLanguage.arabic.code)!.code
            languageCode = "ar"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            setupMainWindow()
            UserDefaults.standard.set("ar", forKey: "languageCode")
        }
    }
    
}
