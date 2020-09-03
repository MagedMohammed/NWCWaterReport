//
//  VerifyOtpVC.swift
//  NWCWaterReports
//
//  Created by Mohamed Sadek on 9/3/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

class VerifyOtpVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var headerLabel: UILabel!{
        didSet{
            headerLabel.text = "enter_the_sent_code".localized()
        }
    }
    @IBOutlet weak var verifyCodeTF: UITextField!
    @IBOutlet weak var VerfiyBtn: UIButton!{
        didSet {
            VerfiyBtn.setTitle("verify".localized(), for: .normal)
        }
    }
    
    //MARK: lifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     //MARK: Methods
    func customizeNavigationBar() {
      if let navController = navigationController {
           navController.navigationBar.barTintColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
           navController.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        }
      }
    
    @objc func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func VerifyBtnAction(_ sender: UIButton) {
    }
}
