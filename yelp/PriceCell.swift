//
//  PriceCell.swift
//  yelp
//
//  Created by Niaz Jalal on 9/27/14.
//  Copyright (c) 2014 Niaz Jalal. All rights reserved.
//

import UIKit

protocol PriceCellDelegate {
    func priceRangeChanged(priceCell: PriceCell, range: String)
}

class PriceCell: UITableViewCell {
    
    var delegate: PriceCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
