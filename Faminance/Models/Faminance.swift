//
//  Faminance.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation

class Faminance {
    let id: String
    var name: String
    var families = [String: User]()
    var myBanks = [String: MyBank]()
    var mainCategories = [String: MainCategory]()
    var memo: String
    
    init(dic: [String: Any]) {
        self.id = dic["id"] as? String ?? ""
        self.name = dic["name"] as? String ?? ""
        
        if let fmls = dic["families"] as? [String: Any] {
            for (uid, user) in fmls {
                self.families[uid] = User(dic:user as! [String: Any])
            }
        }
        if let mbks = dic["myBanks"] as? [String: Any] {
            for (bkid, bk) in mbks {
                self.myBanks[bkid] = MyBank(dic: bk as! [String: Any])
            }
        }
        
        if let mcats = dic["mainCategories"] as? [String: Any] {
            for (mcatid, mcat) in mcats {
                self.mainCategories[mcatid] = MainCategory(dic: mcat as! [String: Any])
            }
        }
        
        self.memo = dic["memo"] as? String ?? ""
        
        setMyBanksCashTransactions()
    }
    
    func setMyBanksCashTransactions() {
        
        for mcat in self.mainCategories.values {
            if let mAllCashTransactions = mcat.getAllCashTransactions() {
                for ct in mAllCashTransactions.values {
                    self.myBanks[ct.bankId]?.cashTransactions[ct.id] = ct
                }
            }
        }
        
    }
    
    func getAllCashTransactions() -> [String: CashTransaction]? {
        var allCashTransactions = [String: CashTransaction]()
        for mcat in self.mainCategories.values {
            if let mAllCashTransactions = mcat.getAllCashTransactions() {
                allCashTransactions.united(mAllCashTransactions)
            }
        }
        return allCashTransactions
    }
    
    func mainCategoryAtIndex(_ index: Int) -> MainCategory? {
        let sortedMainCategories = Array(self.mainCategories.keys).sorted(by: <)
        return self.mainCategories[sortedMainCategories[index]]
    }
    
    func myBankAtIndex(_ index: Int) -> MyBank? {
        let sortedMyBanks = Array(self.myBanks.keys).sorted(by: <)
        return self.myBanks[sortedMyBanks[index]]
    }
    
    func getAtMonth(date: Date) -> Faminance {
        var mcs = [String: MainCategory]()
        for (mcId,mc) in self.mainCategories {
            mcs[mcId] = mc
        }
        let fm = Faminance(dic:[
            "id": self.id,
            "name": self.name,
            "memo": self.memo
        ])
        fm.families = self.families
        fm.myBanks = self.myBanks
        fm.mainCategories = mcs
        fm.setMyBanksCashTransactions()
        return fm
    }
}
