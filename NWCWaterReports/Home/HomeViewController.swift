//
//  HomeViewController.swift
//  NWCWaterReports
//
//  Created by Maged Omar on 8/30/20.
//  Copyright © 2020 NWC. All rights reserved.
//

import UIKit
import IBAnimatable
import CoreLocation
import GoogleMaps


struct Complaints{
    var title:String
    var image:String
    var isSelected = false
}

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //    MARK:- Outlet
    
    @IBOutlet weak var getImageBu: UIButton!
    @IBOutlet weak var getImageFromCamiraBu: AnimatableButton!
    @IBOutlet weak var getLocationBu: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var problemCollectionView: UICollectionView!
    @IBOutlet weak var problemLabel: UILabel!{
        didSet{
            self.problemLabel.text = "description".localized()
        }
    }
    @IBOutlet weak var problemTextView: AnimatableTextView!
    
    //    MARK:- Properties
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation!
    var complaintsList = [Complaints]()
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //        getLocation()
        setDataForComplaints()
        self.problemCollectionView.delegate = self
        self.problemCollectionView.dataSource = self
    }
    //    MARK:- Method
    func setDataForComplaints(){
        self.complaintsList = [
            Complaints(title: "water_misuse".localized(), image: "04c"),
            Complaints(title: "sewage_overflow".localized(), image: "03c"),
            Complaints(title: "leak_meter".localized(), image: "02c"),
            Complaints(title: "water_leakage".localized(), image: "01c")
        ]
    }
    
    func getLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setMap(location:CLLocation){
        
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 12)
        let mapView = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
        self.mapView.addSubview(mapView)
        let marker = GMSMarker()
        marker.position = location.coordinate
        marker.title = "your_location".localized()
        //        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        setMap(location:manager.location!)
    }
    //    MARK:- Action
    
    @IBAction func getLocationAction(_ sender: UIButton) {
        getLocation()
    }
    @IBAction func addImageFromCameraAction(_ sender: UIButton) {
    }
    @IBAction func addImageFromPhoneAction(_ sender: UIButton) {
    }
    
    
}
extension HomeViewController: UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return complaintsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ComplaintsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComplaintsCollectionViewCell", for: indexPath) as! ComplaintsCollectionViewCell
        let title = self.complaintsList[indexPath.row].title
        let image = self.complaintsList[indexPath.row].image
        let isSelected = self.complaintsList[indexPath.row].isSelected
        cell.setCell(image: image, title: title, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100 , height: 110)
    }
    
}
