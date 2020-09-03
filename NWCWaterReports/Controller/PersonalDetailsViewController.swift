//
//  ViewController.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/30/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit


class LoginObj: Codable{
    var name: String
    var email:String
    var phoneNumber:String
    var token:String
    var isLogged:Bool
    
    init(name: String, email: String, phoneNumber: String,token:String,isLogged:Bool) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.token = token
        self.isLogged = isLogged
        
    }
    
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String
        let token = aDecoder.decodeObject(forKey: "token") as! String
        let isLogged = aDecoder.decodeObject(forKey: "isLogged") as! Bool
        self.init(name: name, email: email, phoneNumber: phoneNumber,token:token,isLogged:isLogged)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(isLogged, forKey: "isLogged")
    }
}

class PersonalDetailsViewController: UIViewController {

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
    
     let userDefaults = UserDefaults.standard
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backSign".localized()), style: .done, target: self, action: #selector(backBtnPressed))
            
           navController.navigationBar.barTintColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
           navController.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        }
      }


    @objc func backBtnPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: Actions
    @IBAction func submitBtnAction(_ sender: UIButton) {
        let loginObject = LoginObj(name: nameTF.text ?? ""  , email: emailTF.text ?? ""  , phoneNumber: mobileTF.text ?? "" , token: "",isLogged:true)
            userDefaults.save(customObject:loginObject, inKey: "LoginObject")
            userDefaults.synchronize()
    }
}
