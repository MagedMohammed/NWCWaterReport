//
//  ViewController.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/30/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    //MARK: lifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
      customizeNavigationBar()
    }

    //MARK: Methods
    func customizeNavigationBar() {
      if let navController = navigationController {
            title = "بلاغات المياه"
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

