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
    
    
    //    rgba(26,188,156 ,1) ターコイズ
    //    rgba(46,204,113 ,1) 緑
    //    rgba(52,152,219 ,1) 青
    //    rgba(155,89,182 ,1) 紫
    //    rgba(52,73,94 ,1)   黒
    //    rgba(241,196,15 ,1) 黄色
    //    rgba(243,156,18 ,1) オレンジ
    //    rgba(231,76,60 ,1)  赤
    //    rgba(236,240,241 ,1)白
    //    rgba(149,165,166 ,1)グレー
    static var chartColorList1:[UIColor] = [
        UIColor.rgb(red: 13, green: 105, blue: 166),
        UIColor.rgb(red: 141, green: 104, blue: 188),
        UIColor.rgb(red: 230, green: 92, blue: 161),
        UIColor.rgb(red: 255, green: 109, blue: 98),
        UIColor.rgb(red: 255, green: 166, blue: 0),
    ]
    
    static var chartColorList:[UIColor] = [
        UIColor.hex("0d8ed9"),
        UIColor.hex("a27ccd"),
        UIColor.hex("dd6d9b"),
        UIColor.hex("e27a60"),
        UIColor.hex("bd973e")
    ]
    
    static var chartColorList2:[UIColor] = [
        UIColor.rgb(red: 46, green: 204, blue: 113),//緑
        UIColor.rgb(red: 243, green: 156, blue: 18),//オレンジ
        UIColor.rgb(red: 52, green: 152, blue: 219),//青
        UIColor.rgb(red: 241, green: 196, blue: 15),//黄
        UIColor.rgb(red: 155, green: 89, blue: 182)//紫
    ]
    
    static var pieChartColorList:[[UIColor]] = [
        [
            UIColor.rgb(red: 13, green: 105, blue: 166),
            UIColor.rgb(red: 67, green: 107, blue: 178),
            UIColor.rgb(red: 105, green: 106, blue: 186),
            UIColor.rgb(red: 141, green: 104, blue: 188),
            UIColor.darkGray
        ], [
            UIColor.rgb(red: 141, green: 104, blue: 188),
            UIColor.rgb(red: 174, green: 100, blue: 184),
            UIColor.rgb(red: 204, green: 95, blue: 175),
            UIColor.rgb(red: 230, green: 92, blue: 161),
            UIColor.darkGray
        ], [
            UIColor.rgb(red: 230, green: 92, blue: 161),
            UIColor.rgb(red: 244, green: 93, blue: 141),
            UIColor.rgb(red: 253, green: 98, blue: 119),
            UIColor.rgb(red: 255, green: 109, blue: 98),
            UIColor.darkGray
        ], [
            UIColor.rgb(red: 255, green: 109, blue: 98),
            UIColor.rgb(red: 255, green: 124, blue: 76),
            UIColor.rgb(red: 255, green: 144, blue: 49),
            UIColor.rgb(red: 255, green: 166, blue: 0),
            UIColor.darkGray
        ], [
            UIColor.rgb(red: 255, green: 166, blue: 0),
            UIColor.rgb(red: 216, green: 169, blue: 0),
            UIColor.rgb(red: 177, green: 169, blue: 0),
            UIColor.rgb(red: 139, green: 166, blue: 5),
            UIColor.darkGray
        ]
    ]
}

