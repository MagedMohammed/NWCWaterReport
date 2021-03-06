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
import Localization
import SideMenu
import NVActivityIndicatorView

//     'SA': ('Saudi Arabia', (34.6323360532, 16.3478913436, 55.6666593769, 32.161008816)),

class HomeViewController: UIViewController, CLLocationManagerDelegate, ErrorFeedBack, NVActivityIndicatorViewable {
    
    //    MARK:- Outlet
    
    @IBOutlet weak var imageCollectionView: UICollectionView!{
        didSet{
            self.imageCollectionView.delegate = self
            self.imageCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var imageStackView: UIStackView!{
        didSet{
            imageStackView.isHidden = imagesArr.isEmpty
        }
    }
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var imageLabel: UILabel!{
        didSet{
            self.imageLabel.isHidden = true
            self.imageLabel.layer.cornerRadius = self.imageLabel.frame.width/2
            self.imageLabel.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var languageItem: UIBarButtonItem!{
        didSet{
            self.languageItem.image = UIImage(systemName: languageCode == "ar" ? "e.circle.fill" : "a.circle.fill")
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
    var complaintsList = [Complaints]()
    var formData = ComplaintsFormData()
    var selectedImage = ""
    var complaintsName = ""
    let userdefults = UserDefaults.standard
    var imagesArr = [UIImage]()
    var cities = [
        City(name: "Riyadh", CBU: "RCBU"),
        City(name: "Jeddah", CBU: "JCBU"),
        City(name: "Makkah", CBU: "MCBU"),
        City(name: "Taif", CBU: "TCBU")
    ]
    /*
     static var TankerCBU = ["RCBU","JCBU","MCBU","TCBU","AS"]
     static let nwcCities = ["Riyadh","Makkah","Jeddah","Taif","الرياض","مكة","جدة","الطائف"]
     
     */
    //    MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let lati = CLLocationDegrees(exactly: 24.774265) ??  CLLocationDegrees()
        let longi = CLLocationDegrees(exactly: 46.738586) ??  CLLocationDegrees()
        let location = CLLocation(latitude: lati, longitude: longi)
        self.setMap(location:location, zoom: 4)
        setDataForComplaints()
        self.problemCollectionView.delegate = self
        self.problemCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setColorOfNav()
        imageInNavBar()
        Constants.LoginObject = UserDefaults.standard.retrieve(object: LoginObj.self, fromKey: "LoginObject")
    }
    
    
    //    MARK:- Method
    func setDataForComplaints(){
        self.complaintsList = [
            Complaints(id: "CM_WVIO",title: "water_misuse".localized(), selectedImage:"04c", image: "04o",isSelected: false),
            Complaints(id: "CM_SEVI",title: "sewage_overflow".localized(), selectedImage: "03c", image: "03o",isSelected: false),
            Complaints(id: "CM_LKGE_M",title: "leak_meter".localized(), selectedImage: "02c", image: "02o",isSelected: false),
            Complaints(id: "CM_LKGE",title: "water_leakage".localized(), selectedImage: "01c", image: "01o",isSelected: false)
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
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "sideMenu", bundle: nil)
        let menu = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuNavigationController
        if languageCode == "en" {
            menu.leftSide = true
        } else {
            menu.leftSide = false
        }
        DispatchQueue.main.async {
            self.present(menu, animated: true, completion: nil)
        }
    }
    @objc func didTapMenu(){
        let storyboard = UIStoryboard(name: "sideMenu", bundle: nil)
        let menu = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuNavigationController
        if languageCode == "en" {
            menu.leftSide = true
        } else {
            menu.leftSide = false
        }
        DispatchQueue.main.async {
            self.present(menu, animated: true, completion: nil)
        }
    }
    func setMap(location:CLLocation,zoom:Float){
        
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: zoom)
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
        self.formData.latlng = "(\(locValue.latitude), \(locValue.longitude))"
        setMap(location:manager.location!, zoom: 15)
        locationManager.stopUpdatingLocation()
        NetworkRequest.getAddressFromLatLong(latitude: locValue.latitude, longitude: locValue.longitude) { address in
            print(address.city)
            for city in self.cities{
                if city.name == address.city{
                    self.formData.cbu = city.CBU
                }else{
                    continue
                }
            }
            if self.formData.cbu == nil{
                self.showErrorAlert(title: "error".localized(), msg: "not_in_cbu".localized())
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
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
            userdefults.set("ar", forKey: "languageCode")
            userdefults.synchronize()
            
        } else if preferredLanguage != "ar" {
            Localization.preferredLanguage = LocalizableLanguage(code: LocalizableLanguage.arabic.code)!.code
            languageCode = "ar"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            setupMainWindow()
            userdefults.set("ar", forKey: "languageCode")
            userdefults.synchronize()
        }
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        guard self.formData.cbu != nil else{
            self.showErrorAlert(title: "error".localized(), msg: "not_in_cbu".localized())
            return
        }
        self.formData.comments = self.problemTextView.text ?? ""
        //print(self.formData)
        if Constants.LoginObject?.isLogged ?? false {
            self.startAnimating()
            NetworkRequest.submitComplaints(parameter: self.formData) { (data, error) in
                
                if let data = data, error == nil{
                    if data == "OK"{
                        
                        if var obj = UserDefaults.standard.retrieve(object: [ReportsList].self, fromKey: "Reports") {
                            if let name  = UserDefaults.standard.retrieve(object: LoginObj.self, fromKey: "LoginObject")?.name{
                                let insertObj = ReportsList(user_name: name , image: self.selectedImage, complaintsName: self.complaintsName)
                                obj.append(insertObj)
                            }
                            UserDefaults.standard.save(customObject: obj, inKey: "Reports")
                        } else {
                            if let name  = UserDefaults.standard.retrieve(object: LoginObj.self, fromKey: "LoginObject")?.name{
                                let insertObj = ReportsList(user_name: name , image: self.selectedImage, complaintsName: self.complaintsName)
                                UserDefaults.standard.save(customObject: [insertObj], inKey: "Reports")
                            }
                            
                        }
                        
                        if self.isAnimating{
                            self.stopAnimating()
                        }
                        self.showErrorAlert(title: "done".localized(), msg: "submit_done".localized())
                        self.clearData()
                    }else{
                        self.stopAnimating()
                        self.showErrorAlert(title: "error".localized(), msg: data)
                    }
                }
            }
        }else{
            let vc = PersonalDetailsViewController.instance()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //        NetworkRequest.submitComplaints(parameter: self.formData)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        
        clearData()
    }
    
    func clearData(){
        self.imageLabel.isHidden = true
        self.formData.image = [String]()
        self.formData.descrption = ""
        self.problemTextView.text = ""
        self.setDataForComplaints()
    }
    
}

extension HomeViewController: UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == imageCollectionView {
            return self.imagesArr.count
        }
        
        return complaintsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
            let cell:ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
            let image = self.imagesArr[indexPath.row]
            cell.imageImageView.image = image
            cell.delete = {
                self.imagesArr.remove(at: indexPath.row)
                self.formData.image.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.imageStackView.isHidden = self.imagesArr.isEmpty
                    self.imageCollectionView.reloadData()
                }
            }
            return cell
        }
        let cell:ComplaintsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComplaintsCollectionViewCell", for: indexPath) as! ComplaintsCollectionViewCell
        let title = self.complaintsList[indexPath.row].title
        let isSelected = self.complaintsList[indexPath.row].isSelected
        let image = isSelected ? self.complaintsList[indexPath.row].selectedImage : self.complaintsList[indexPath.row].image
        
        cell.setCell(image: image, title: title, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95 , height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.setDataForComplaints()
        self.complaintsList[indexPath.row].isSelected = true
        self.formData.complaintsType = self.complaintsList[indexPath.row].id
        self.selectedImage = self.complaintsList[indexPath.row].selectedImage
        self.complaintsName = self.complaintsList[indexPath.row].title
        collectionView.reloadData()
    }
}

// Image Picker
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage
        {
            let image2String = Constants.convertImageToBase64(image: image)
            self.imagesArr.append(image)
            self.formData.image.append(image2String)
            self.imageStackView.isHidden = false
            self.imageCollectionView.reloadData()
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

