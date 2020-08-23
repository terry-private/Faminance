//
//  MyBank.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation

class MyBank {
    let id: String
    var name: String
    var initialAmount: Int
    var memo: String
    
    var cashTransactions = [String: CashTransaction]()
    
    init(dic: [String: Any]) {
        self.id = dic["id"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.initialAmount = dic["initialAmount"] as? Int ?? 0
        self.memo = dic["memo"] as? String ?? ""
    }
    
    func latestBalance() -> Int {
        var sum = self.initialAmount
        for ct in self.cashTransactions.values {
            sum += ct.amount
        }
        return sum
    }
    
}
