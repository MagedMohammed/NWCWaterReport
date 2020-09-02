//
//  SideMenuViewController.swift
//  NWCWaterReports
//
//  Created by Mohamed Sadek on 8/31/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    let source = [Item(icon: #imageLiteral(resourceName: "home-icon"), name: "home".localized()) , Item(icon: #imageLiteral(resourceName: "account-icon"), name: "personal_information".localized()) , Item(icon: #imageLiteral(resourceName: "nwclog1"), name: "NWC".localized()) ,Item(icon: #imageLiteral(resourceName: "ebranch-logo"), name: "eBranch".localized()) , Item(icon: #imageLiteral(resourceName: "phone-icon-1"), name: "930 00 1744")]
    
    
    //MARK: lifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

     //MARK: Methods
     func openWebView(stringUrl :String){
        guard let url = URL(string: stringUrl) else {
          return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
      }
}

  //MARK: Extensions
extension SideMenuViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell") as! SideMenuTableViewCell
        let bgColorView = UIView()
        bgColorView.backgroundColor = #colorLiteral(red: 0.1460938156, green: 0.3017449081, blue: 0.4727679491, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        cell.iconImageView.image = source[indexPath.row].icon
        cell.titleLabel.text  = source[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.dismiss(animated: true, completion: nil)      
        case 1:
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
              let PersonalDetailsVC = storyboard.instantiateViewController(withIdentifier: "PersonalDetailsVC") as! PersonalDetailsViewController
                 self.navigationController?.pushViewController(PersonalDetailsVC, animated: true)
        case 2 :
           openWebView(stringUrl: "https://www.nwc.com.sa")
        case 3:
            openWebView(stringUrl: "https://e.nwc.com.sa")
        case 4 :
            if let url = NSURL(string: "tel://\(920001744)"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.openURL(url as URL)
            }
        default:
            return
        }
    }
}


class SideMenuTableViewCell : UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}

struct Item {
    var icon : UIImage?
    var name : String?
}
