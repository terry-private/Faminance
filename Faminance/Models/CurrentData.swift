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

    static var chartColorList:[UIColor] = [
        UIColor.hex("0d8ed9"),
        UIColor.hex("a27ccd"),
        UIColor.hex("dd6d9b"),
        UIColor.hex("e27a60"),
        UIColor.hex("bd973e")
    ]

}

