//
//  LoginViewController.swift
//  Waite
//
//  Created by apple on 10/09/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class LoginViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var customerLoginLbl: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var forgotPswdBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var arabLangBtn: UIButton!
    @IBOutlet weak var engliashLngBtn: UIButton!
    
    //MARK:- Variables
    var languageBundle : Bundle?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        if UserDefaults.standard.value(forKey: "Login") != nil{
            if UserDefaults.standard.value(forKey: "Login")as! Bool == true{
//                let homeView = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewIdentifier") as! HomeViewController
//                self.navigationController?.pushViewController(homeView, animated: true)
            }
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "JosefinSans-Regular", size: 20)!]
        UINavigationBar.appearance().barTintColor = UIColor(red: 39.0/255.0, green: 187.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
        self.intialSetup()
        self.setLanguage()
    }
    
    

    
    func intialSetup()  {
        emailTxtField.layer.borderWidth = 1.5
        emailTxtField.layer.borderColor = UIColor.white.cgColor
        passwordTxtField.layer.borderColor = UIColor.white.cgColor
        passwordTxtField.layer.borderWidth = 1.5
        loginBtn.layer.borderColor = UIColor.white.cgColor
        loginBtn.layer.borderWidth = 1.5
        emailTxtField.layer.cornerRadius = 5
        passwordTxtField.layer.cornerRadius = 5
        loginBtn.layer.cornerRadius = 5
        arabLangBtn.layer.borderColor = UIColor.white.cgColor
        arabLangBtn.layer.borderWidth = 1.5
        engliashLngBtn.layer.borderColor = UIColor.white.cgColor
        engliashLngBtn.layer.borderWidth = 1.5
        engliashLngBtn.layer.backgroundColor = UIColor.white.cgColor
        engliashLngBtn.setTitleColor(.darkGray, for: .normal)
        engliashLngBtn.layer.cornerRadius = 5
        arabLangBtn.layer.cornerRadius = 5
        
        loginBtn.layer.cornerRadius = 5
        loginBtn.layer.shadowOpacity = 10.0
        loginBtn.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        loginBtn.layer.shadowRadius = 3.0
        loginBtn.layer.shadowColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.8).cgColor
        
      
        let FormattedText = NSMutableAttributedString()
        FormattedText
            .bold("New User?")
            .normal("SignUp")
        
        signUpBtn.setAttributedTitle(FormattedText, for: .normal)
        
     //   lbl_Third.attributedText = myMutableString
     /*   if Language.language == Language.english{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            engliashLngBtn.layer.backgroundColor = UIColor.white.cgColor
            engliashLngBtn.setTitleColor(.darkGray, for: .normal)
            arabLangBtn.layer.backgroundColor = UIColor.clear.cgColor
            arabLangBtn.setTitleColor(.white, for: .normal)
        }
        else{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            arabLangBtn.layer.backgroundColor = UIColor.white.cgColor
            arabLangBtn.setTitleColor(.darkGray, for: .normal)
            engliashLngBtn.layer.backgroundColor = UIColor.clear.cgColor
            engliashLngBtn.setTitleColor(.white, for: .normal)
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forgotPswdBtnClicked(_ sender: UIButton) {
        //ForgotViewIdentifier
        let forgotView = self.storyboard?.instantiateViewController(withIdentifier: "ForgotViewIdentifier") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(forgotView, animated: true)
        
    }
    func setLanguage() {
//        loginBtn.setTitle("login".localized, for: .normal)
//
//        let signUpStr:String = "\("sign_up".localized)\("dont_account".localized)"
//
//        signUpBtn.setTitle(signUpStr, for: .normal)
//        forgotPswdBtn.setTitle("forgot_password".localized, for: .normal)
//        emailTxtField.placeholder = "r_email".localized
//        passwordTxtField.placeholder = "r_password".localized
//        //customerLoginLbl.text = "Welcome".localized
//        customerLoginLbl.text = "Login_welcome".localized
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        if !emailTxtField.hasText{
            Utility.showAlert(title: "Alert", message: "Please enter email.", viewController: self)
            
        }
        else if !(emailTxtField.text?.isEmail)!{
            Utility.showAlert(title: "Alert", message: "Please enter a valid email.", viewController: self)
        }
        else if !passwordTxtField.hasText{
            Utility.showAlert(title: "Alert", message: "Please enter password.", viewController: self)
        }
        else{
            
            let menuListView = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewIdentifier") as! SWRevealViewController
            self.navigationController?.pushViewController(menuListView, animated: true)
          /*  MBProgressHUD.showAdded(to: self.view, animated: true)
            let parameters : NSDictionary  =
                ["email": emailTxtField.text!,
                 "password" : passwordTxtField.text!,
                  "device_type" : "iOS",
                   "device_id" : "23454",
                   "user_type" : "user",
                   "auth_key": "454HdffUYLKKsrsJIU$",
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
                                let userDetailDict:NSDictionary = dict.value(forKey: "userdata")as! NSDictionary
                                print(userDetailDict)
                                UserDefaults.standard.setValue(userDetailDict, forKey: "UserDetails")
                                UserDefaults.standard.set(true, forKey: "Login")
                                let homeView = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewIdentifier") as! HomeViewController
                                self.navigationController?.pushViewController(homeView, animated: true)
                            }
                            else{
                                Utility.showAlert(title: "Alert", message: "\(dict.value(forKey: "msg")!)", viewController: self)
                            }
                        }
                        else if dict.value(forKey: "status") is String{
                            if dict.value(forKey: "status") as! String == "1"{
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
            }*/
        }
    }
    
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        let signUpView = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewIdentifier") as! SignUpViewController
        self.navigationController?.pushViewController(signUpView, animated: true)

    }
    
    @IBAction func arabLangBtnClicked(_ sender: UIButton) {
//        UIView.appearance().semanticContentAttribute = .forceLeftToRight
//        arabLangBtn.layer.backgroundColor = UIColor.white.cgColor
//        arabLangBtn.setTitleColor(.darkGray, for: .normal)
//        Language.language = Language.arabic
//        engliashLngBtn.layer.backgroundColor = UIColor.clear.cgColor
//        engliashLngBtn.setTitleColor(.white, for: .normal)
      //  Localize.setCurrentLanguage("fr")
    }
    
    @IBAction func englishLangBtnClicked(_ sender: UIButton) {
//        UIView.appearance().semanticContentAttribute = .forceRightToLeft
//        engliashLngBtn.layer.backgroundColor = UIColor.white.cgColor
//        engliashLngBtn.setTitleColor(.darkGray, for: .normal)
//        Language.language = Language.english
//       // Localize.setCurrentLanguage("en")
//        arabLangBtn.layer.backgroundColor = UIColor.clear.cgColor
//        arabLangBtn.setTitleColor(.white, for: .normal)
    }
   
}
extension String {
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
extension NSMutableAttributedString {
    @discardableResult func bold(_ text:String) -> NSMutableAttributedString {
        
        let attrs : [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.font : UIFont(name: "JosefinSans-Regular", size: 18)!,
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let attrs : [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.font : UIFont(name: "JosefinSans-Regular", size: 17)!,
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        let normal =  NSAttributedString(string: text,  attributes:attrs)
        self.append(normal)
        return self
}
}
