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
<<<<<<< HEAD
import Localization
=======
import SideMenu
>>>>>>> 85d5ebfc3bc4a54cf27c0743672003725d2f655f


class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    //    MARK:- Outlet
    
    @IBOutlet weak var imageLabel: UILabel!{
        didSet{
            self.imageLabel.isHidden = true
            self.imageLabel.layer.cornerRadius = self.imageLabel.frame.width/2
            self.imageLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var cancelBu: UIButton!{
        didSet{
            cancelBu.setTitle("cancel".localized(), for: .normal)
        }
    }
    @IBOutlet weak var submitBu: UIButton!{
        didSet{
            submitBu.setTitle("submit".localized(), for: .normal)
        }
    }
    @IBOutlet weak var reportTypeLabel: UILabel!{
        didSet{
            reportTypeLabel.text = "report_type".localized()
        }
    }
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
    @IBOutlet weak var problemTextView: AnimatableTextView!{
        didSet{
            problemTextView.placeholderText = "description".localized()
        }
    }
    
    //    MARK:- Properties
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation!
<<<<<<< HEAD
    var complaintsList = [Complaints]()
    var formData = ComplaintsFormData()
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorOfNav()
        imageInNavBar()
        NetworkRequest.request()
        let lati = CLLocationDegrees(exactly: 24.774265) ??  CLLocationDegrees()
        let longi = CLLocationDegrees(exactly: 46.738586) ??  CLLocationDegrees()
        let location = CLLocation(latitude: lati, longitude: longi)
        self.setMap(location:location, zoom: 4)
        setDataForComplaints()
        self.problemCollectionView.delegate = self
        self.problemCollectionView.dataSource = self
=======
    
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "hamburger"), style: .done, target: self, action: #selector(didTapMenu))
>>>>>>> 85d5ebfc3bc4a54cf27c0743672003725d2f655f
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
    
<<<<<<< HEAD
    func setMap(location:CLLocation,zoom:Float){
        
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: zoom)
=======
    @objc func didTapMenu(){
        let storyboard = UIStoryboard(name: "sideMenu", bundle: nil)
               let menu = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuNavigationController
               DispatchQueue.main.async {
                   self.present(menu, animated: true, completion: nil)
               }
    }
    
    func setMap(location:CLLocation){
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 12) //GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
>>>>>>> 85d5ebfc3bc4a54cf27c0743672003725d2f655f
        let mapView = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
        self.mapView.addSubview(mapView)
        let marker = GMSMarker()
        marker.position = location.coordinate
        marker.title = "your_location".localized()
        marker.map = mapView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        setMap(location:manager.location!, zoom: 15)
    }
    //    MARK:- Action
    
    @IBAction func getLocationAction(_ sender: UIButton) {
        getLocation()
    }
    @IBAction func addImageFromCameraAction(_ sender: UIButton) {
        self.openCamera()
    }
    @IBAction func addImageFromPhoneAction(_ sender: UIButton) {
        self.openGallery()
    }
    @IBAction func languageAction(_ sender: UIBarButtonItem) {
        let preferredLanguage = Localization.preferredLanguage
        if preferredLanguage != "en" {
            Localization.preferredLanguage = LocalizableLanguage(code: LocalizableLanguage.english.code)!.code
            languageCode = "en"
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            setupMainWindow()
            UserDefaults.standard.set("en", forKey: "languageCode")
            
        } else if preferredLanguage != "ar" {
            Localization.preferredLanguage = LocalizableLanguage(code: LocalizableLanguage.arabic.code)!.code
            languageCode = "ar"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            setupMainWindow()
            UserDefaults.standard.set("ar", forKey: "languageCode")
        }
    }
    @IBAction func submitAction(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.imageLabel.isHidden = true
        self.formData.image = [UIImage]()
        self.formData.descrption = ""
        self.problemTextView.text = ""
        self.setDataForComplaints()
        
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
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage
        {
            self.formData.image.append(image)
            self.imageLabel.isHidden = false
            self.imageLabel.text = "\(self.formData.image.count)"
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "warning".localized(), message: "noـcamera".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "warning".localized(), message: "no_access_gallery".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
