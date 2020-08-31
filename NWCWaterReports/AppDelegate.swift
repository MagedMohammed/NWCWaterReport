//
//  AppDelegate.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/30/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit
import GoogleMaps


public let MAPS_KEY = "AIzaSyDq_07Sw8szGROZZLRGIaOjMtuHTwFVQa8"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSServices.provideAPIKey(MAPS_KEY)
        //        GMSPlacesClient.provideAPIKey(MAPS_KEY)
        return true
    }
}
