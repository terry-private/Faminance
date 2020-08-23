//
//  Dictionary-Extension.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation

extension Dictionary {
    func union(_ other: Dictionary) -> Dictionary {
        var tmp = self
        other.forEach { tmp[$0.0] = $0.1 }
        return tmp
    }
    mutating func united(_ other: Dictionary) {
        other.forEach { self[$0.0] = $0.1 }
    }
}
