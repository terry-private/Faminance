//
//  Faminance.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation


/// 一番親となるモデルクラス
/// Faminance
///     mainCategories: [id: MainCategory]
///     myBanks: [id: MyBanks]
///     families: [id: User]
class Faminance {
    let id: String
    var name: String
    var families = [String: User]()
    var myBanks = [String: MyBank]()
    var mainCategories = [String: MainCategory]()
    var memo: String
    var version: Int = 0
    var createdAt: Date = Date.current
    
    /// Firebaseの情報をそのまま引数の辞書に代入
    /// - Parameter dic: [
    ///     id: String,
    ///     name: String,
    ///     faminies: [String: Any],
    ///     myBanks: [String: Any],
    ///     mainCategories: [String, Any],
    ///     memo: String,
    ///     version: Int
    /// ]
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
        self.version = dic["version"] as? Int ?? 0
        self.createdAt = dic["cteatedAt"] as? Date ?? Date.current
        
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
    
    func addCashTransaction(_ ct: CashTransaction) {
        self.mainCategories[ct.mainCategoryId]?.subCategories[ct.subCategoryId]?.cashTransactions[ct.id] = ct
        self.myBanks[ct.bankId]?.cashTransactions[ct.id] = ct
    }
    
    /// currentDateの年月のchashTransactionのみを集めたFaminanceを返します。
    /// - Parameter date: currentDate
    /// - Returns: currentDateの年月のchashTransactionのみを集めたFaminance
    func getAtMonth(date: Date) -> Faminance {
        var mcs = [String: MainCategory]()
        for (mcId,mc) in self.mainCategories {
            mcs[mcId] = mc.getAtMonth(date: date)
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
