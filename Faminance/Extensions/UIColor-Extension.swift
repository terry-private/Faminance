//
//  UIColor-Extension.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    static func hex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor  {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        return self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}

