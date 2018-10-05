//
//  ForgotPasswordViewController.swift
//  Waite
//
//  Created by apple on 10/09/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class ForgotPasswordViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var forgotLbl: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    
    
    //MARK:- Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initalSetUp()
        self.changeLanguage()
    }
    func initalSetUp() {
        sendBtn.layer.cornerRadius = 5
        sendBtn.layer.borderColor = UIColor.white.cgColor
        sendBtn.layer.borderWidth = 1.5
        emailTxtField.layer.borderColor = UIColor.white.cgColor
        emailTxtField.layer.borderWidth = 1.5
        emailTxtField.layer.cornerRadius = 5
    }

    func changeLanguage() {
//        sendBtn.setTitle("fp_send".localized, for: .normal)
//        emailTxtField.placeholder = "r_email".localized
//        forgotLbl.text = "fp_forgot".localized
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendBtnClicked(_ sender: UIButton) {
        if !emailTxtField.hasText || !(emailTxtField.text?.isEmail)!{
           Utility.showAlert(title: "Alert", message: "Please enter a valid email.", viewController: self)
            
        }
        else{
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let parameters : NSDictionary  =
                ["email": emailTxtField.text!,
                 ]
            
            print(parameters)
            print("\(GlobalConstants.baseURL)user_login")
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            Alamofire.request("\(GlobalConstants.baseURL)user_login", method: .post, parameters: parameters as? Parameters, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
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
                                let yesAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
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
    

}
