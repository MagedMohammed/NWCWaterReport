//
//  ComplaintsCollectionViewCell.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/31/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

class ComplaintsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak private var complaintImage: UIImageView!
    //    @IBOutlet weak private var backView: UIView!
    @IBOutlet weak private var complaintTitleLabel: UILabel!
    
    func setCell(image:String, title:String, isSelected:Bool){
        self.complaintTitleLabel.text = title
        self.complaintImage.image = UIImage(named: image)
    }
}
