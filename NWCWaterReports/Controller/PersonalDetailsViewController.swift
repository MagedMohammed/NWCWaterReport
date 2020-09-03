//
//  ViewController.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/30/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit


struct LoginObj: Codable{
    var name =          String()
    var email =         String()
    var phoneNumber =   String()
    var token =         String()
    var messageRef =    String()
    var isLogged =      false
    var deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    var osVersion = UIDevice.current.systemVersion ?? ""
}

class PersonalDetailsViewController: UIViewController,ErrorFeedBack {
    
    //MARK: IBOutlets
    @IBOutlet weak var personalInfoLabel: UILabel! {
        didSet {
            personalInfoLabel.text = "personal_information".localized()
        }
    }
    @IBOutlet weak var nameTF: UITextField! {
        didSet {
            nameTF.placeholder = "name".localized()
            nameTF.textAlignment = languageCode == "en" ? .left : .right
        }
    }
    @IBOutlet weak var mobileTF: UITextField! {
        didSet {
            mobileTF.placeholder = "05xxxxxxxx"
            mobileTF.textAlignment = languageCode == "en" ? .left : .right
        }
    }
    @IBOutlet weak var emailTF: UITextField!{
        didSet {
            emailTF.placeholder = "email".localized()
            emailTF.textAlignment = languageCode == "en" ? .left : .right
            
        }
    }
    @IBOutlet weak var registerBtn: UIButton!{
        didSet {
            registerBtn.setTitle("register".localized(), for: .normal)
        }
    }
    
    static func instance()-> PersonalDetailsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalDetailsVC") as! PersonalDetailsViewController
        return vc
    }
    
    var loginObject = LoginObj()
    //MARK: lifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if languageCode == "en" {
            view.semanticContentAttribute = .forceRightToLeft
        } else {
            view.semanticContentAttribute = .forceLeftToRight
        }
    }
    
    //MARK: Methods
    func customizeNavigationBar() {
        if let navController = navigationController {
            title = "water_reports".localized()
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back sign"), style: .done, target: self, action: #selector(backBtnPressed))
            
            navController.navigationBar.barTintColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            navController.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        }
    }
    
    
    @objc func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Actions
    @IBAction func submitBtnAction(_ sender: UIButton) {
        guard let name = self.nameTF.text,!name.isEmpty else{
            return
        }
        guard let email = self.emailTF.text,!email.isEmpty else{return
            
        }
        guard let phoneNumber = self.mobileTF.text,!phoneNumber.isEmpty else{return}
        NetworkRequest.getOTP(mobile: phoneNumber) { (data, error) in
            if let data = data, error == nil{
                self.loginObject = LoginObj(name: name , email: email, phoneNumber:phoneNumber,messageRef: data)
                    
                self.performSegue(withIdentifier: "goToOTP", sender: self.loginObject)
        
            }else{
                self.showErrorAlert(title: "error", msg: error?.localizedDescription ?? "")
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToOTP" {
            if let destination = segue.destination as? VerifyOtpVC {
                if let id = sender as? LoginObj {
                    destination.loginObj = id
                }
            }
        }
    }
}
