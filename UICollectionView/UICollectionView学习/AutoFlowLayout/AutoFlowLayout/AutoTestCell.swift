//
//  AutoTestCell.swift
//  AutoFlowLayout
//
//  Created by ddn on 16/9/18.
//  Copyright © 2016年 张永俊. All rights reserved.
//

import UIKit

class AutoTestCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //只有使用estimatedItemSize时起作用
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let attr = super.preferredLayoutAttributesFitting(layoutAttributes)
//        
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
//        
//        let size = self.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
//        attr.frame.size = size
//        return attr
//    }
}
