//
//  BankTableViewCell.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit

class BankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var latestBalanceLabel: UILabel!
    
    @IBOutlet weak var bankColorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


