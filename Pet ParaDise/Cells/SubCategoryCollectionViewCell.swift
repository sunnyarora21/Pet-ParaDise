//
//  SubCategoryCollectionViewCell.swift
//  Pet ParaDise
//
//  Created by apple on 04/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit
protocol SubCategoryProtocol {
    func showCategoryProductList(cell: SubCategoryCollectionViewCell)
    
}

class SubCategoryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var subCategoryImgView: UIImageView!
    @IBOutlet weak var subCategoryNameLbl: UILabel!
    @IBOutlet weak var blurView: UIView!
    
    var subCategoryDelegate:SubCategoryProtocol?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        subCategoryImgView.layer.cornerRadius = 10
        subCategoryImgView.clipsToBounds = true
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
    }
    
    
    @IBAction func categorySelected(_ sender: UIButton) {
        self.subCategoryDelegate?.showCategoryProductList(cell: self)
    }
    
}
