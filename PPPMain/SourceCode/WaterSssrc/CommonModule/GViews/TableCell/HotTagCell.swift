//
//  HotTagCell.swift
//  tripbay_ios
//
//  Created by gama on 2021/3/1.
//  Copyright © 2021 TripBay. All rights reserved.
//

import UIKit

class HotTagCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var tagBackgroundView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 0.12

        layer.cornerRadius = 5
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.gray.cgColor
        
        tagBackgroundView.layer.cornerRadius = 4.0
        tagBackgroundView.layer.masksToBounds = true
        
    }

}
