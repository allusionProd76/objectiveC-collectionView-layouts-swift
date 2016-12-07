//
//  CalendarEventCell.swift
//  calendarCollectionViewLayout
//
//  Created by chrismart laptop on 11/11/16.
//  Copyright © 2016 Allusion Productions. All rights reserved.
//

import UIKit

class CalendarEventCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        layer.cornerRadius = 10
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 1).cgColor
    }
    
}
