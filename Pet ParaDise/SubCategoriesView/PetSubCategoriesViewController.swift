//
//  PetSubCategoriesViewController.swift
//  Pet ParaDise
//
//  Created by apple on 04/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class PetSubCategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, SubCategoryProtocol {

    //MARK:- Outlets
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleLbl: UILabel!
    //MARK:- Variables
    var mainArray:NSArray = NSArray()
    var titleString:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a navView to add to the navigation bar
        self.navigationController?.navigationBar.isHidden = true
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
      //  self.setUp()
        self.initialSetUp()
    }
    
    
    
    func initialSetUp() {
        self.titleLbl.text = titleString
        mainArray = [
            ["Name" : "Birds",
             "image" : "birds",
            ],
            ["Name" : "Fish",
             "image" : "fish",
             ],
            ["Name" : "Dogs",
             "image" : "Dogs",
             ],
            ["Name" : "Cats",
             "image" : "Cat",
             ],
            ["Name" : "Small Animals",
             "image" : "smallAnimals",
             ],
            ["Name" : "Coming Soon",
             "image" : "ComingSoon",
             ],
        ]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- CollectionView Methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // 1
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 2
        return mainArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoryCollectionViewCellIdentifier", for: indexPath as IndexPath) as! SubCategoryCollectionViewCell
        cell.subCategoryDelegate = self
        let dict:NSDictionary = mainArray.object(at: indexPath.row) as! NSDictionary
        cell.subCategoryNameLbl.text = "\(dict.value(forKey: "Name")!)"
        cell.subCategoryImgView.image = UIImage(named: "\(dict.value(forKey: "image")!)")
        if indexPath.row == 5{
            cell.subCategoryImgView.contentMode = .scaleAspectFill
        }
       // cell.mainMenuCollectionDelegate = self
//        Alamofire.request("\(dict.value(forKey: "image")!)").responseImage { response in
//            
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//                cell.productImgView.image = image
//            }
//        }
        return cell
    }
    
    func showCategoryProductList(cell: SubCategoryCollectionViewCell){
        let petSubView = self.storyboard?.instantiateViewController(withIdentifier: "ProductListViewIdentifier") as! ProductListViewController
        petSubView.titleString = cell.subCategoryNameLbl.text!
        self.navigationController?.pushViewController(petSubView, animated: true)
    }
    
    //ProductListViewIdentifier
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0 - 5
        let yourHeight = collectionView.frame.size.height/3.0 - 50
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToCartBtnClicked(_ sender: UIButton) {
        
    }
    
}
