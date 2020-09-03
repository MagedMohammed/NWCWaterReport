//
//  VerifyOtpVC.swift
//  NWCWaterReports
//
//  Created by Mohamed Sadek on 9/3/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

class VerifyOtpVC: UIViewController,ErrorFeedBack {
    
    //MARK: IBOutlets
    @IBOutlet weak var verifyCodeTF: UITextField!
    @IBOutlet weak var VerfiyBtn: UIButton!
    
    //    MARK:- Properties
    var loginObj:LoginObj?
    let userDefaults = UserDefaults.standard

    //MARK: lifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Methods
    func customizeNavigationBar() {
        if let navController = navigationController {
            title = "Verification".localized()
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back sign"), style: .done, target: self, action: #selector(backBtnPressed))
            
            navController.navigationBar.barTintColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            navController.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        }
    }
    
    @objc func backBtnPressed(){
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func VerifyBtnAction(_ sender: UIButton) {
        guard let code = verifyCodeTF.text, !code.isEmpty else{
            self.showErrorAlert(title: "error".localized(), msg: "otp_message_error")
            return}
        
        if var loginData = self.loginObj{
            NetworkRequest.authUser(mobil: loginData.phoneNumber, code: code, deviceId: loginData.deviceId, os: loginData.osVersion, messageRef: loginData.messageRef) { (data, error) in
                if let token = data, error == nil {
                    loginData.token = token
                    loginData.isLogged = true
                    self.userDefaults.save(customObject:loginData, inKey: "LoginObject")
                    self.userDefaults.synchronize()
                    var rootVC : UIViewController?
                        rootVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "Home") as! UINavigationController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = rootVC
                }
            }
        }
    }
}
