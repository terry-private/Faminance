//
//  CashTransaction.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation
import Firebase

class CashTransaction {
    let id: String
    let inOut: String
    var amount:Int
    var mainCategoryId: String
    var subCategoryId: String
    var date: Date
    var bankId: String
    var memo: String
    
    init(dic: [String: Any]) {
        id = dic["id"] as? String ?? ""
        inOut = dic["inOut"] as? String ?? ""
        amount = dic["amount"] as? Int ?? 0
        mainCategoryId = dic["mainCategoryId"] as? String ?? ""
        subCategoryId = dic["subCategoryId"] as? String ?? ""
        date = dic["date"] as? Date ?? Date.current
        memo = dic["memo"] as? String ?? ""
        bankId = dic["bankId"] as? String ?? ""
    }
}
