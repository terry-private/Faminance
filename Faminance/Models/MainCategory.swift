//
//  MainCategory.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation

class MainCategory {
    let id: String
    var name: String
    let inOut: String
    var subCategories = [String: SubCategory]()
    var targetAmount: Int
    var memo: String
    var sortedSubCategories = [(key: String, value: SubCategory)]()
    
    init(dic: [String: Any]) {
        self.id = dic["id"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        self.inOut = dic["inOut"] as? String ?? ""
        self.targetAmount = dic["targetAmount"] as? Int ?? 0
        self.memo = dic["memo"] as? String ?? ""
        
        if let subCats = dic["subCategories"] as? [String:Any] {
            for (subCatId, subCatDic) in subCats {
                self.subCategories[subCatId] = SubCategory(dic: subCatDic as! [String : Any])
            }
        }
        sortSubCategories()
    }
    
    func getSum() -> Int {
        var sum: Int = 0
        for subCat in self.subCategories.values {
            sum += subCat.getSum()
        }
        return sum
    }
    
    func getAllCashTransactions() -> [String: CashTransaction]? {
        var allCashTransactions = [String: CashTransaction]()
        for sct in self.subCategories.values {
            allCashTransactions.united(sct.cashTransactions)
        }
        return allCashTransactions
    }
    
    func subCategoryAtIndex(_ index: Int) -> SubCategory? {
        return self.sortedSubCategories[index].value
    }
    func sortSubCategories() {
        let etc = self.subCategories["etc"]
        var sbc = self.subCategories
        sbc.removeValue(forKey: "etc")
        self.sortedSubCategories = sbc.sorted() {$0.value.getSum() > $1.value.getSum()}
        if etc != nil {
            self.sortedSubCategories.append((key:"etc",value:etc!))
        }
    }
    
    func getAtMonth(date: Date) -> MainCategory {
        
        var scs =  [String: SubCategory]()
        
        for (scId, sc) in self.subCategories {
            scs[scId] = sc.getAtMonth(date: date)
        }
        
        let mc = MainCategory(dic:[
            "id": id,
            "name": self.name,
            "inOut": self.inOut,
            "targetAmount": self.targetAmount,
            "memo": self.memo
        ])
        
        mc.subCategories = scs
        
        return mc
        
    }
}
