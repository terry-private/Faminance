//
//  MainCategoryTablViewCell.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit

class MainCategoryTableViewCell: UITableViewCell {
    var targetAmount: Float = 0
    var realAmount: Float = 0
    var isOver: Bool = false
    
    @IBOutlet var statusNameLabel: UILabel!
    @IBOutlet var statusBackBarView: UIView!
    @IBOutlet var statusFrontBarView: UIView!
    @IBOutlet var recentryMonyLabel: UILabel!
    @IBOutlet var remainingMonyLabel: UILabel!
    
    @IBOutlet weak var targetMoneyLabel: UILabel!
    
    @IBOutlet weak var statusFrontBarWidth: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusBackBarView.layer.cornerRadius = 6
        self.statusFrontBarView.layer.cornerRadius = 6
        self.backgroundColor = .clear
        showLabel()
    }
    

    
    // 金額の表示
    func showLabel() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        self.recentryMonyLabel.text = formatter.string(from: NSNumber(value: self.realAmount))
        self.remainingMonyLabel.text = "残 " + formatter.string(from: NSNumber(value: self.targetAmount - self.realAmount))!
        
        self.targetMoneyLabel.text = "今月の目標  " + formatter.string(from: NSNumber(value: self.targetAmount))!
    }
    
    func barAnimation() {
        showLabel()
        
        // barのアニメーション
        self.statusFrontBarWidth.constant = CGFloat(0)
        self.layoutIfNeeded()
        
        if self.realAmount < self.targetAmount {
            self.statusBackBarView.layer.backgroundColor = UIColor.rgb(red: 209, green: 209, blue: 209).cgColor
            self.remainingMonyLabel.textColor = UIColor.rgb(red: 100, green: 180, blue: 180)
            self.statusFrontBarWidth.constant = CGFloat(Float(self.statusBackBarView.bounds.size.width) * self.realAmount / self.targetAmount)
        } else {
            self.statusBackBarView.layer.backgroundColor = UIColor.rgb(red: 209, green: 60, blue: 60).cgColor
            self.remainingMonyLabel.textColor = UIColor.rgb(red: 209, green: 60, blue: 60)
            self.statusFrontBarWidth.constant = CGFloat(Float(self.statusBackBarView.bounds.size.width) * self.targetAmount / self.realAmount)
        }
        
        UIView.animate(withDuration: 0.4,animations:{self.layoutIfNeeded() })
        
    }
}
