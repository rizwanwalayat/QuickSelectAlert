//
//  CustomAlertCell.swift
//  OhmConnect
//
//  Created by Rizwan Walayat on 26/06/2024.
//

import UIKit

class QuickSelectAlertCell: UICollectionViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? .systemGray5 : .systemGray4
            self.itemLabel.textColor = isSelected ? .systemBlue : .darkGray
        }
    }
    
    func updateCell(text: String) {
        itemLabel.text = text
    }
}
