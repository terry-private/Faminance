//
//  DateLabel.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/18.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import BottomHalfModal
import FSCalendar


protocol DateLabelDelegate {
    func tapped()
}
class DateLabel: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var delegate: DateLabelDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        
        self.textColor = .red
        self.text = Date().longDate()
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ttt")
        tapped()
    }
    func tapped() {
        delegate?.tapped()
        print("tapped")
    }
}



