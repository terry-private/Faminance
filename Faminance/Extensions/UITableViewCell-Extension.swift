//
//  UITableViewCell-Extension.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/18.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit

extension UITableViewCell {

    @IBInspectable
    var selectedBackgroundColor: UIColor? {
        get {
            return selectedBackgroundView?.backgroundColor
        }
        set(color) {
            let background = UIView()
            background.backgroundColor = color
            selectedBackgroundView = background
        }
    }

}
