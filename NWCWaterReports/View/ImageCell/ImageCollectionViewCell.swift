//
//  ImageCollectionViewCell.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 9/29/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //    MARK:- Outlet
    @IBOutlet weak var imageImageView: UIImageView!
    
    //    MARK:- Properties
    var delete:(()->())?
    
    //    MARK:- Action
    @IBAction func deleteAction(_ sender: UIButton) {
        self.delete?()
    }
}
