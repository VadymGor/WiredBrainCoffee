//
//  ColorCollectionViewCell.swift
//  WiredBrainCoffee
//
//  Created by Vadym Horovyi on 18/04/2020.
//  Copyright © 2020 Mark Moeykens. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func setup(backgroundColor: UIColor, cellNumber: Int) {
        self.backgroundColor = backgroundColor
        numberLabel.text = "\(cellNumber)"
    }
}
