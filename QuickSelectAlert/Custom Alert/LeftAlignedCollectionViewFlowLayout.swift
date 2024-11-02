//
//  LeftAlignedCollectionViewFlowLayout.swift
//  OhmConnect
//
//  Created by Rizwan Walayat on 28/06/2024.
//

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left

        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.x == sectionInset.left {
                leftMargin = sectionInset.left
            } else {
                layoutAttribute.frame.origin.x = leftMargin
            }
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
        }
        return attributes
    }
}
