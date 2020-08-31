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


class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //    MARK:- Outlet
    
    @IBOutlet weak var getImageBu: UIButton!
    @IBOutlet weak var getImageFromCamiraBu: AnimatableButton!
    @IBOutlet weak var getLocationBu: UIButton!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var problemCollectionView: UICollectionView!
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var problemTextView: AnimatableTextView!
    
    //    MARK:- Properties
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation!
    
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        
    }
    //    MARK:- Method
    func getLocation() {
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
//        }
    }
    
    func setMap(location:CLLocation){
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 12) //GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
        self.mapView.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        setMap(location:manager.location!)
    }
}
