//
//  ViewController.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/30/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

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
    }
}

