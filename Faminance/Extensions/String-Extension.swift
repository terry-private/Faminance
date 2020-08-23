//
//  String-Extension.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/22.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation
extension String {
    func replace(_ OldPattern: String, _ NewPattern:String) -> String {
        var s1 = self
        if let range1 = s1.range(of: OldPattern) {
            s1.replaceSubrange(range1, with: NewPattern)
        }
        if s1 == self {
            return s1
        }
        return s1.replace(OldPattern, NewPattern)
    }
}
