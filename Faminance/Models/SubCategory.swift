//
//  SubCategory.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation

class SubCategory {
    let id: String
    var name: String
    var cashTransactions = [String: CashTransaction]()
    var memo: String
    
    init(dic: [String: Any]) {
        self.id = dic["id"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.memo = dic["memo"] as? String ?? ""
        
        if let cts = dic["cashTransactions"] as? [String:Any] {
            for (ctId, ct) in cts {
                self.cashTransactions[ctId] = CashTransaction(dic: ct as! [String : Any])
            }
        }
        
    }
    
    func getSum() -> Int {
        var sum: Int = 0
        for ct in self.cashTransactions.values {
            sum += ct.amount
        }
        return sum
    }
    
    func getAtMonth(date: Date) -> SubCategory {
        var cts = [String: CashTransaction]()
        
        for (ctId, ct) in self.cashTransactions {
            if ct.date.year == date.year && ct.date.month == date.month {
                cts[ctId] = ct
            }
        }
        
        let sc = SubCategory(dic:[
            "id": self.id,
            "name": self.name,
            "memo": self.memo
        ])
        sc.cashTransactions = cts
        
        return sc
    }
}
