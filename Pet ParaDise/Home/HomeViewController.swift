//
//  HomeViewController.swift
//  Pet ParaDise
//
//  Created by apple on 03/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var topScrollView: UIScrollView!
    @IBOutlet weak var bottomScrollView: UIScrollView!
    
    
    //MARK:- Variables
    @IBOutlet weak var viewForpets: UIView!
     var categoryArray:NSArray = NSArray()
    var imgArray:NSArray = NSArray()
    var baseMenuArray:NSArray = NSArray()
    var initialX:CGFloat = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       // self.setTitle()
        //navigationItem.titleView = UIImageView(image: UIImage(named: "Logo"))
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "JosefinSans-Regular", size: 20)!]
//        UINavigationBar.appearance().tintColor = UIColor.white
        if revealViewController() != nil {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
          _ = Timer.scheduledTimer(timeInterval: 03.0, target: self, selector: #selector(HomeViewController.ScrollImages), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        self.setUp()
    }
    
    
    
    func initialSetUp() {
        viewForpets.layer.cornerRadius = 5
        viewForpets.layer.cornerRadius = 5
        viewForpets.layer.shadowOpacity = 10.0
        viewForpets.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        viewForpets.layer.shadowRadius = 3.0
        viewForpets.layer.shadowColor = UIColor.lightGray.cgColor
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.navigationBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUp() {
        self.categoryArray = [
            ["name" : "Pet",
             "imageName" : "petsImg"
            ],
            ["name" : "Food",
             "imageName" : "FoodImg"
            ],
            ["name" : "Accessories",
             "imageName" : "AccessoriesImg"
            ],
            ["name" : "Medicine",
             "imageName" : "MedicineImg"
            ],
            ["name" : "Toys",
             "imageName" : "ToysImg"
            ],
            ["name" : "Pet Services",
             "imageName" : "PetServicesImg"
            ],
        ]
        
        self.imgArray = ["img1","img2","img3"]
        
        baseMenuArray = [
            ["name" : "HOME",
             "imageName" : "Home",
             ],
            ["name" : "CATEGORIES",
             "imageName" : "Categories",
             ],
            ["name" : "SEARCH",
             "imageName" : "search",
             ],
            ["name" : "CALL",
             "imageName" : "CALL",
             ],
            ["name" : "CART",
             "imageName" : "Cart",
             ],
            ]
        self.createView()
        self.createTopScrollView()
        self.createBottomView()
    }
    func createView() {
        
        
        var X:CGFloat = CGFloat()
        X = 10
        
        var Y:CGFloat = CGFloat()
        Y = topScrollView.frame.origin.y + topScrollView.frame.size.height + 70
         for i in 0...categoryArray.count - 1 {
            let dict:NSDictionary = self.categoryArray.object(at: i)as! NSDictionary

            let baseView:UIView = UIView()
            baseView.frame = CGRect(x: X, y: Y, width: self.view.frame.size.width / 3.4, height: 100)
            baseView.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
            baseView.layer.cornerRadius = 8
            baseView.layer.shadowOpacity = 10.0
            baseView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
            baseView.layer.shadowRadius = 3.0
            baseView.layer.shadowColor = UIColor.lightGray.cgColor
            self.view.addSubview(baseView)
            
            let imageView:UIImageView = UIImageView()
            imageView.frame = CGRect(x: 35, y: 10, width: 50, height: 50)
            imageView.image = UIImage(named: "\(dict.value(forKey: "imageName")!)")
            baseView.addSubview(imageView)
            
            let nameLbl:UILabel = UILabel()
            nameLbl.frame = CGRect(x: 1, y: imageView.frame.size.height + 10, width: baseView.frame.size.width, height: baseView.frame.size.height - (imageView.frame.size.height + 10))
            nameLbl.text = "\(dict.value(forKey: "name")!)"
            nameLbl.textColor = UIColor(red: 15.0/255.0, green: 170.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            nameLbl.textAlignment = .center
            //nameLbl.font = UIFont.boldSystemFont(ofSize: 14)
            nameLbl.font = UIFont(name: "JosefinSans-Regular", size: 15)
            baseView.addSubview(nameLbl)
            
            let menuTypeBtn:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: baseView.frame.size.width, height: baseView.frame.size.height))
            menuTypeBtn.backgroundColor = UIColor.clear
            menuTypeBtn.tag = i
            menuTypeBtn.addTarget(self, action:#selector(self.menuTypeBtnClicked), for: .touchUpInside)
            baseView.addSubview(menuTypeBtn)
            
            X = X + baseView.frame.size.width + 10
            
            if X >= self.view.frame.size.width - 70{
                X = 10
                Y = Y + 130
            }
        }
        
    }
    
    
    @objc func menuTypeBtnClicked(sender: UIButton) {
        print("sender:----- \(sender.tag)")
        if sender.tag == 0{
        let petSubView = self.storyboard?.instantiateViewController(withIdentifier: "PetSubCategoriesViewIdentifier") as! PetSubCategoriesViewController
        //submenuListView.menuID = "\(sender.tag + 1)"
            petSubView.titleString = "Pets"
        self.navigationController?.pushViewController(petSubView, animated: true)
            
        }
    }
    
    func createTopScrollView()  {
        var X:CGFloat = CGFloat()
        X = 10
        for i in 0...imgArray.count - 1 {
            let imageView:UIImageView = UIImageView()
            imageView.frame = CGRect(x: X, y: 0, width: topScrollView.frame.size.width - 20, height: topScrollView.frame.size.height)
            imageView.layer.cornerRadius = 8
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: "\(self.imgArray.object(at: i))")
            topScrollView.addSubview(imageView)
            X = X + topScrollView.frame.size.width
            topScrollView.contentSize.width = X
        }
    }
    
    func createBottomView() {
        var X:CGFloat = CGFloat()
        X = 0
        for i in 0...baseMenuArray.count - 1 {
            let dict:NSDictionary = baseMenuArray.object(at: i)as! NSDictionary
            
            let baseview: UIView = UIView()
            baseview.frame = CGRect(x: X, y: 0, width: bottomScrollView.frame.size.width / 5, height: bottomScrollView.frame.size.height)
            
            bottomScrollView.addSubview(baseview)
            X = X + baseview.frame.size.width
            bottomScrollView.contentSize.width = X
            
            let menuImageView:UIImageView = UIImageView()
            menuImageView.frame = CGRect(x: 0, y: 5, width: 30, height: 30)
            menuImageView.image = UIImage(named: "\(dict.value(forKey: "imageName")!)")
            baseview.addSubview(menuImageView)
            menuImageView.frame.origin.x = baseview.frame.size.width / 2 - (menuImageView.frame.origin.x / 2 + menuImageView.frame.size.width / 2)
            
            let menuNameLbl:UILabel = UILabel()
            menuNameLbl.frame = CGRect(x: 0, y: menuImageView.frame.origin.y + menuImageView.frame.size.height, width: baseview.frame.size.width, height: baseview.frame.size.height - menuImageView.frame.size.height)
            menuNameLbl.text = "\(dict.value(forKey: "name")!)"
            menuNameLbl.textAlignment = .center
            menuNameLbl.font = UIFont(name: "JosefinSans-Regular", size: 11)
            //menuNameLbl.font = menuNameLbl.font.withSize(12)
            menuNameLbl.numberOfLines = 0
            baseview.addSubview(menuNameLbl)
        }
    }
    
    @objc func ScrollImages()
    {
        //  scrollView.setContentOffset(CGPoint(x: x, y: y), animated: true)
        //let x = CGFloat(pageControll.currentPage) * topScrollView.frame.size.width
        initialX = initialX + topScrollView.frame.size.width
        if initialX >= (CGFloat(topScrollView.frame.size.width) * CGFloat(imgArray.count)){
            initialX = 0
        }
        
        topScrollView.setContentOffset(CGPoint(x:initialX, y:0), animated: true)
        
    }
    
    //PetSubCategoriesViewIdentifier
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
