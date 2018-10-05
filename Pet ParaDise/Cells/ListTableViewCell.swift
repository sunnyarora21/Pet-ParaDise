//
//  ListTableViewCell.swift
//  Pet ParaDise
//
//  Created by apple on 04/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var brideImgView: UIImageView!
    @IBOutlet weak var brideNameLbl: UILabel!
    @IBOutlet weak var brideBehaviourLbl: UILabel!
    @IBOutlet weak var bridePriceLbl: UILabel!
    
    
    //MARK:- Variables
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 8
        mainView.layer.shadowOpacity = 10.0
        mainView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        mainView.layer.shadowRadius = 3.0
        mainView.layer.shadowColor = UIColor.lightGray.cgColor
        mainView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
