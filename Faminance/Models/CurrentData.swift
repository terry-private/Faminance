//
//  CurrentData.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/25.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation
import UIKit

struct CurrentData {
    static var faminance: Faminance = Faminance(dic: SampleData().dic)
    static var myAccount: User = User(dic: [String: Any]())

    static var chartColorList:[UIColor] = [
        UIColor.hex("0d8ed9"),
        UIColor.hex("a27ccd"),
        UIColor.hex("dd6d9b"),
        UIColor.hex("e27a60"),
        UIColor.hex("bd973e")
    ]
    
    static func dateToInt(_ date: Date) -> Int {
        return date.year*10000000000 + date.month*100000000 + date.day*1000000 + date.hour*10000 + date.minute*100 + date.second
    }
    static func newId(_ header: String,_ date: Date) -> String{
        return header + String(dateToInt(date)) + myAccount.id
    }

}

