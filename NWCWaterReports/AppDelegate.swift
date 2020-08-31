//
//  AppDelegate.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/30/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit
import GoogleMaps
import Localization


public let MAPS_KEY = "AIzaSyDq_07Sw8szGROZZLRGIaOjMtuHTwFVQa8"
public var languageCode = Localization.preferredLanguage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey(MAPS_KEY)
        //        GMSPlacesClient.provideAPIKey(MAPS_KEY)
        Constants.setLanguage()
        return true
    }
}
func setupMainWindow(){
    var rootVC : UINavigationController?
    rootVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Home") as? UINavigationController
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.window?.rootViewController = rootVC
}
