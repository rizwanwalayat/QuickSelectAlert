//
//  Extensions.swift
//  QuickSelectAlert
//
//  Created by Rizwan Walayat on 03/11/2024.
//

import UIKit

public extension String {
    func size(with font: UIFont = .systemFont(ofSize: 15.0)) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)
        return size
    }
}
