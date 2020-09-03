//
//  ReportsTableViewCell.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 9/2/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

class ReportsTableViewCell: UITableViewCell {
    
    
    //    MARK:- Outlet
    @IBOutlet weak private var reportImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!{
        didSet{
            self.nameLabel.text = "name".localized()
        }
    }
    @IBOutlet weak private var nameValueLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!{
        didSet{
            self.dateLabel.text = "date".localized()
        }
    }
    @IBOutlet weak private var dateValueLabel: UILabel!
    @IBOutlet weak private var descrptionValueLabel: UILabel!
    @IBOutlet weak private var descrptionLabel: UILabel!{
        didSet{
            descrptionLabel.text = "description".localized()
        }
    }
    //    MARK:- Properties
    
    //    MARK:- ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //    MARK:- Method
    func setCell(name:String, date:String, descrption:String){
        self.nameValueLabel.text = name
        self.dateValueLabel.text = date
        self.descrptionValueLabel.text = description
    }
    
}
