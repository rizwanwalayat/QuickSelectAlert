//
//  AutoSizedCollectionView.swift
//  OhmConnect
//
//  Created by Rizwan Walayat on 28/06/2024.
//

import UIKit

class AutoSizedCollectionView: UICollectionView {

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
