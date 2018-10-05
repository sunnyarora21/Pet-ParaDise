//
//  ProductListViewController.swift
//  Pet ParaDise
//
//  Created by apple on 04/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK:- Outlets
    @IBOutlet weak var productListTableView: UITableView!
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    //MARK:- Variables
    
    var titleString:String = String()
    var listArray:NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.titleLbl.text = titleString
        productListTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCellIdentifier")
        // Do any additional setup after loading the view.\
        self.initalSetUp()
    }

    func initalSetUp()  {
        listArray = [
            ["name" : "German Shepherd",
             "behaviour" : "Aggressive",
             "price" : "20000",
             "image" : "germanshepherd",
            ],
            ["name" : "Labrador",
             "behaviour" : "Friendly",
             "price" : "15000",
             "image" : "Labrador",
             ],
            ["name" : "Pug",
             "behaviour" : "Frieldly",
             "price" : "25000",
             "image" : "Pug",
             ],
            ["name" : "rotweiler",
             "behaviour" : "intelligent",
             "price" : "10000",
             "image" : "rotweiler",
             ],
        ]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- TableView Method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listArray.count
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell
    {
        let cell:ListTableViewCell = tableView.dequeueReusableCell (withIdentifier: "ListTableViewCellIdentifier") as! ListTableViewCell
        let dict:NSDictionary = listArray.object(at: indexPath.row)as! NSDictionary
        cell.brideImgView.image = UIImage(named: "\(dict.value(forKey: "image")!)")
        cell.brideNameLbl.text = dict.value(forKey: "name") as? String
        cell.brideBehaviourLbl.text = dict.value(forKey: "behaviour") as? String
        cell.bridePriceLbl.text = dict.value(forKey: "price") as? String
        return cell
    }

    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
