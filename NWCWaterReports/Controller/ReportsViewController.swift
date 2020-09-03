//
//  ReportsViewController.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 9/2/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

struct ReportsList: Codable{
    var user_name = String()
    var image = String()
    var date = Constants.dateToString()
    var complaintsName = String()
}

class ReportsViewController: UIViewController {

//    MARK:- Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reportsTableView: UITableView!
    
    
    var reportsData = [ReportsList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportsTableView.delegate = self
        reportsTableView.dataSource = self
        reportsTableView.register(UINib(nibName: "ReportsTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "ReportsTableViewCell")
    }
    
    func setDataForList(){
        let data = UserDefaults.standard.retrieve(object: [ReportsList].self, fromKey: "Reports") ?? [ReportsList]()
        self.reportsData = data
        
        
    }
    
}
extension ReportsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReportsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReportsTableViewCell", for: indexPath) as! ReportsTableViewCell
        let name = reportsData[indexPath.row].user_name
        let image = reportsData[indexPath.row].image
        let date = reportsData[indexPath.row].date
        let complintName = reportsData[indexPath.row].complaintsName
        
        cell.setCell(name: name, date: date, descrption: description,image:image)
        return cell
    }
    
    
}
