//
//  ReportsViewController.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 9/2/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController {

//    MARK:- Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reportsTableView: UITableView!
    
    
    var reportsData = [ComplaintsFormData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportsTableView.delegate = self
        reportsTableView.dataSource = self
        reportsTableView.register(UINib(nibName: "ReportsTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "ReportsTableViewCell")
    }
}
extension ReportsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReportsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ReportsTableViewCell", for: indexPath) as! ReportsTableViewCell
//        let name = reportsData[indexPath.row].
        
        return cell
    }
    
    
}
