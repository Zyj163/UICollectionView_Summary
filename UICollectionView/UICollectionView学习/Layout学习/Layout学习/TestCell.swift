//
//  TestCell.swift
//  Layout学习
//
//  Created by ddn on 16/9/22.
//  Copyright © 2016年 张永俊. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 5
        layer.borderWidth = 2
        layer.borderColor = UIColor.green.cgColor
        layer.masksToBounds = true
    }

}
