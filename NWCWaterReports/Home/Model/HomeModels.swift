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
    var title:String
    var image:String
    var isSelected = false
}

struct ComplaintsFormData{
    var image:[UIImage] = [UIImage]()
    var complaintsType = String()
    var descrption = String()
    var location = String()
}
