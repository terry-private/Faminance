//
//  CashTransaction.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation

class CashTransaction {
    let id: String
    let inOut: String
    var amount:Int
    var mainCategoryId: String
    var subCategoryId: String
    var date = Date()
    var bankId: String
    var memo: String
    
    init(dic: [String: Any]) {
        self.id = dic["id"] as? String ?? ""
        self.inOut = dic["inOut"] as? String ?? ""
        self.amount = dic["amount"] as? Int ?? 0
        self.mainCategoryId = dic["mainCategoryId"] as? String ?? ""
        self.subCategoryId = dic["subCategoryId"] as? String ?? ""
        self.date = dic["date"] as? Date ?? Date()
        self.memo = dic["memo"] as? String ?? ""
        self.bankId = dic["bankId"] as? String ?? ""
    }
}
