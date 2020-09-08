//
//  CashTransactionTableViewCell.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit

class CashTransactionTableViewCell: UITableViewCell{
    @IBOutlet weak var subCategoryColorRectView: UIView!
    @IBOutlet weak var subCategoryNameLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
