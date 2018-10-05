//
//  SignUpViewController.swift
//  Waite
//
//  Created by apple on 10/09/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import MBProgressHUD
import GooglePlaces

class SignUpViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, UISearchDisplayDelegate {
    
    ///MARK:- Outlets
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var registerLbl: UILabel!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var mobileTxtField: UITextField!
    @IBOutlet weak var pswdTxtField: UITextField!
    @IBOutlet weak var confirmPswdTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var viewForCurrentLocation: UIView!
     @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewForSearch: UIView!
    //MARK:- Variables
    
    let locationManager = CLLocationManager()
    var latitude:String = String()
    var longitude:String = String()
    //var placesClient: GMSPlacesClient!
  //  let GoogleMapsAPIServerKey = "AIzaSyCrPCRwiD5zjeDcV0POIYrqlZszuZ0tiLM"
    var tableDataSource: GMSAutocompleteTableDataSource?
    var srchDisplayController: UISearchDisplayController?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        mobileTxtField.delegate = self
        
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource?.delegate = self
      //  srchDisplayController = UISearchDisplayController(searchBar: searchBar!, contentsController: self)
        srchDisplayController?.searchResultsDataSource = tableDataSource
        srchDisplayController?.searchResultsDelegate = tableDataSource
        srchDisplayController?.delegate = self
       // self.locationTxtField.delegate = self
       // placesClient = GMSPlacesClient.shared()
        // Do any additional setup after loading the view.
        self.initalSetUp()
        self.setLanguage()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }



    
    func initalSetUp() {
        nameTxtField.layer.borderWidth = 1.5
        nameTxtField.layer.borderColor = UIColor.white.cgColor
        emailTxtField.layer.borderWidth = 1.5
        emailTxtField.layer.borderColor = UIColor.white.cgColor
        mobileTxtField.layer.borderWidth = 1.5
        mobileTxtField.layer.borderColor = UIColor.white.cgColor
        pswdTxtField.layer.borderWidth = 1.5
        pswdTxtField.layer.borderColor = UIColor.white.cgColor
        confirmPswdTxtField.layer.borderWidth = 1.5
        confirmPswdTxtField.layer.borderColor = UIColor.white.cgColor
        viewForCurrentLocation.layer.borderWidth = 1.5
        viewForCurrentLocation.layer.borderColor = UIColor.white.cgColor
        signUpBtn.layer.borderWidth = 1.5
        signUpBtn.layer.borderColor = UIColor.white.cgColor
        nameTxtField.layer.cornerRadius = 5
        emailTxtField.layer.cornerRadius = 5
        mobileTxtField.layer.cornerRadius = 5
        pswdTxtField.layer.cornerRadius = 5
        confirmPswdTxtField.layer.cornerRadius = 5
        viewForCurrentLocation.layer.cornerRadius = 5
        signUpBtn.layer.cornerRadius = 5
        
        signUpBtn.layer.cornerRadius = 5
        signUpBtn.layer.shadowOpacity = 10.0
        signUpBtn.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        signUpBtn.layer.shadowRadius = 3.0
        signUpBtn.layer.shadowColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8).cgColor
        
        viewForCurrentLocation.frame.origin.y = confirmPswdTxtField.frame.origin.y + confirmPswdTxtField.frame.size.height + 30
        signUpBtn.frame.origin.y = viewForCurrentLocation.frame.origin.y + viewForCurrentLocation.frame.size.height + 30
        
        mainScrollView.contentSize.height = signUpBtn.frame.origin.y + signUpBtn.frame.size.height + 50
    }
    
    func setLanguage() {
//        signUpBtn.setTitle("register".localized, for: .normal)
//        registerLbl.text = "r_register".localized
//        nameTxtField.placeholder = "r_first_name".localized
//        emailTxtField.placeholder = "r_email".localized
//        mobileTxtField.placeholder = "r_phone".localized
//        pswdTxtField.placeholder = "r_password".localized
//        confirmPswdTxtField.placeholder = "r_confirm_password".localized
//        locationTxtField.placeholder = "r_location".localized
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        if !nameTxtField.hasText{
            Utility.showAlert(title: "Alert", message: "Please enter name.", viewController: self)
        }
        else if !emailTxtField.hasText{
             Utility.showAlert(title: "Alert", message: "Please enter email.", viewController: self)
        }
        else if !(emailTxtField.text?.isEmail)!{
            Utility.showAlert(title: "Alert", message: "Please enter a valid email.", viewController: self)
            
        }
        else if !mobileTxtField.hasText{
            Utility.showAlert(title: "Alert", message: "Please enter mobile No.", viewController: self)
        }
        else if !pswdTxtField.hasText{
            Utility.showAlert(title: "Alert", message: "Please enter password.", viewController: self)
            
        }
        else if pswdTxtField.text != confirmPswdTxtField.text{
            Utility.showAlert(title: "Alert", message: "Password doesn't match.", viewController: self)
        }
        else if !locationTxtField.hasText{
            Utility.showAlert(title: "Alert", message: "please Enter your location.", viewController: self)
        }
        else{
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let parameters : NSDictionary  =
                ["name": nameTxtField.text!,
                 "email" : emailTxtField.text!,
                 "mobile" : mobileTxtField.text!,
                 "password" : pswdTxtField.text!,
                 "confirm_password" : confirmPswdTxtField.text!,
                 "location" : locationTxtField.text!,
                 "current_location" : "\(latitude),\(longitude)",
                 "device_type" : "iOS",
                 "device_id" : "23454",
                 "user_type" : "user",
                 "auth_key": "454HdffUYLKKsrsJIU$",
                 ]
            
            print(parameters)
            print("\(GlobalConstants.baseURL)add_user")
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            Alamofire.request("\(GlobalConstants.baseURL)add_user", method: .post, parameters: parameters as? Parameters, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                    
                case .success(_):
                    
                    if response.result.value != nil{
                        
                        var dict:NSDictionary = NSDictionary()
                        dict = (response.result.value! as? NSDictionary)!
                        
                        print(dict)
                        
                        if dict.value(forKey: "status") is Int{
                            if dict.value(forKey: "status") as! Int == 1{
                                let alertController = UIAlertController(title: "Sucess", message: "\(dict.value(forKey: "msg")!)", preferredStyle: .alert)
                                
                                // Initialize Actions
                                let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) -> Void in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                
                                
                                
                                // Add Actions
                                alertController.addAction(yesAction)
                                
                                // Present Alert Controller
                                self.present(alertController, animated: true, completion: nil)

                                
                            }
                            else{
                                Utility.showAlert(title: "Alert", message: "\(dict.value(forKey: "msg")!)", viewController: self)
                            }
                        }
                        else if dict.value(forKey: "status") is String{
                            
                            if dict.value(forKey: "status") as! String == "1"{
                                //                       / self.performSegue(withIdentifier: "HomeViewIdentifier", sender: self)
                            }
                            else{
                                Utility.showAlert(title: "Alert", message: "\(dict.value(forKey: "msg")!)", viewController: self)
                            }
                        }
                    }
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    break
                    
                case .failure(_):
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    Utility.showAlert(title: "Alert", message: "Something went wrong. Please try again later.", viewController: self)
                    break
                    
                }
            }
        }
    }
    @IBAction func selectGooglePlaceBtnClicked(_ sender: UIButton) {
      self.viewForSearch.isHidden = false
    }
    
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator off.
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        // Reload table data.
        srchDisplayController?.searchResultsTableView.reloadData()
    }
    
    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        // Turn the network activity indicator on.
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        // Reload table data.
        srchDisplayController?.searchResultsTableView.reloadData()
    }
    
    
    @IBAction func currentLocationBtnClicked(_ sender: UIButton) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                
                print("placemarks",placemarks!)
                let pm = placemarks?[0]
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            
         //   print("your location is:-",containsPlacemark)
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            print(containsPlacemark)

          //  print("\(containsPlacemark.name!),\(containsPlacemark.subLocality!),\(containsPlacemark.locality!),\(containsPlacemark.administrativeArea!),\(containsPlacemark.postalCode!),\(containsPlacemark.country!)")
            locationTxtField.text = "\(containsPlacemark.name!),\(containsPlacemark.locality!),\(containsPlacemark.administrativeArea!),\(containsPlacemark.postalCode!),\(containsPlacemark.country!)"
            latitude = "\(String(describing: containsPlacemark.location?.coordinate.latitude))"
            longitude = "\(String(describing: containsPlacemark.location?.coordinate.longitude))"
//            localityTxtField.text = locality
//            postalCodeTxtField.text = postalCode
//            aAreaTxtField.text = administrativeArea
//            countryTxtField.text = country
        }
        
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func showSelectedAddress(detailedAddressString: String, latitude: String, longitude: String)  {
        self.locationTxtField.text = detailedAddressString
        self.longitude =  longitude
        self.latitude = latitude
//        print(self.locationTxtField.text!)
//        print(self.longitude)
//        print(self.latitude)
        self.viewForSearch.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func closeSearchBarBtnClicked(_ sender: UIButton) {
        self.viewForSearch.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @IBAction func hideSearchLocationBtnClicked(_ sender: UIButton) {
        self.viewForSearch.isHidden = true
    }
    
}
extension SignUpViewController: GMSAutocompleteTableDataSourceDelegate {
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        srchDisplayController?.isActive = false
        
//                print("Place name: \(place.name)")
//                print("Place address: \(place.formattedAddress)")
//                print("Place attributions: \(place.attributions)")
        
        self.showSelectedAddress(detailedAddressString: place.formattedAddress!, latitude: "\(place.coordinate.longitude)", longitude: "\(place.coordinate.latitude)")
       
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        tableDataSource?.sourceTextHasChanged(searchString)
        return false
    }
    
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // TODO: Handle the error.
        print("Error: \(error.localizedDescription)")
    }
    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
}

