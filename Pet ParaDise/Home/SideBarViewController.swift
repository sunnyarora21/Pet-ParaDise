//
//  SideBarViewController.swift
//  Pet ParaDise
//
//  Created by apple on 03/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class SideBarViewController: UIViewController {
    
    //MARK:- Outlets
    
    
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
            let logoImg:UIImageView = UIImageView()
            logoImg.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
            logoImg.image = UIImage(named: "Logo")
            navigationItem.titleView?.addSubview(logoImg)
    
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
