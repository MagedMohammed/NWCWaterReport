//
//  HomeModels.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/31/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import Foundation
import UIKit

struct Complaints{
    var id:String
    var title:String
    var selectedImage:String
    var image:String
    var isSelected = false
}

struct ComplaintsFormData{
    var image:[UIImage] = [UIImage]()
    var complaintsType = String()
    var descrption = String()
    var mobileNumber = String()
    var token = String()
    var cbu = String()
    var deviceId = UIDevice.current.identifierForVendor?.uuidString
    var osVersion = UIDevice.current.systemVersion
    var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var comments = String()
    var xy = String()
    var coordinatesSource = "S"
    var latlng = String()
//    var image1 = String()
//    var image2 = String()
//    var image3 = String()
//    var image4 = String()
}
