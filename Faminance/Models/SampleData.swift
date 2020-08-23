//
//  SampleData.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import Foundation

struct SampleData{
    var dic: [String: Any]
    init(){
        
        let families: [String : Any] = [
            "uid001": [
                "id": "uid001",
                "name": "照仁",
                "email": "ataeteruhito@gmail.com",
                "createdAt": Date()
            ],
            "uid002": [
                "id": "uid002",
                "name": "知恵",
                "email": "chie@gmail.com",
                "createdAt": Date()
            ]
        ]
        
        let myBanks: [String: Any] = [
            "bid001": [
                "id": "bid01",
                "name": "照仁の三井住友",
                "initialAmount": 1000000,
                "remark": "生活費用の口座"
            
            ],
            "bid002": [
                "id": "bid02",
                "name": "みんなのお財布",
                "initialAmount": 18000,
                "remark": "財布"
            
            ],
            "bid003": [
                "id": "bid03",
                "name": "知恵のゆうちょ",
                "initialAmount": 1000000,
                "remark": "貯金用の口座"
            
            ],
            "bid004": [
                "id": "bid04",
                "name": "タンス預金",
                "initialAmount": 1000000,
                "remark": "お祝いなど"
            
            ]
        ]
        
        let cashTransactions01:[String: Any] = [
            "cid001": [
                "id": "cid001",
                "inOut": "支出",
                "amount": 2869,
                "mainCategoryId": "mid001",
                "subCategoryId": "etc",
                "date": Date(),
                "bankId": "bid002",
                "remark": "惣菜とか"
            ],
            "cid002": [
                "id": "cid002",
                "inOut": "支出",
                "amount": 4289,
                "mainCategoryId": "mid001",
                "subCategoryId": "etc",
                "date": Date(),
                "bankId": "bid002",
                "remark": "食材とか関スーにて"
            ]
        ]
        
        let cashTransactions02:[String: Any] = [
            "cid003": [
                "id": "cid003",
                "inOut": "支出",
                "amount": 8700,
                "mainCategoryId": "mid001",
                "subCategoryId": "sid002",
                "date": Date(),
                "bankId": "bid001",
                "remark": "惣菜とか"
            ],
            "cid004": [
                "id": "cid004",
                "inOut": "支出",
                "amount": 3788,
                "mainCategoryId": "mid001",
                "subCategoryId": "sid002",
                "date": Date(),
                "bankId": "bid002",
                "remark": "食材とか関スーにて"
            ]
        ]
        
        let cashTransactions03:[String: Any] = [
            "cid005": [
                "id": "cid005",
                "inOut": "支出",
                "amount": 3100,
                "mainCategoryId": "mid001",
                "subCategoryId": "sid003",
                "date": Date(),
                "bankId": "bid002",
                "remark": "惣菜とか"
            ],
            "cid006": [
                "id": "cid006",
                "inOut": "支出",
                "amount": 1289,
                "mainCategoryId": "mid001",
                "subCategoryId": "sid003",
                "date": Date(),
                "bankId": "bid001",
                "remark": "食材とか関スーにて"
            ]
        ]
        let cashTransactions04:[String: Any] = [
            "cid007": [
                "id": "cid007",
                "inOut": "支出",
                "amount": 286,
                "mainCategoryId": "mid001",
                "subCategoryId": "sid004",
                "date": Date(),
                "bankId": "bid001",
                "remark": "惣菜とか"
            ],
            "cid008": [
                "id": "cid008",
                "inOut": "支出",
                "amount": 1900,
                "mainCategoryId": "mid001",
                "subCategoryId": "sid004",
                "date": Date(),
                "bankId": "bid001",
                "remark": "食材とか関スーにて"
            ]
        ]
        
        
        let subCategories01:[String: Any] = [
            "etc": [
                "id": "etc",
                "name": "その他",
                "remark": "",
                "cashTransactions":cashTransactions01
            ],
            "sid002": [
                "id": "sid002",
                "name": "スーパー",
                "remark": "",
                "cashTransactions":cashTransactions02
            ],
            "sid003": [
                "id": "sid003",
                "name": "コンビニ",
                "remark": "",
                "cashTransactions":cashTransactions03
            ],
            "sid004": [
                "id": "sid004",
                "name": "ドラッグストア",
                "remark": "",
                "cashTransactions":cashTransactions04
            ]
        ]
        
        let subCategories02:[String: Any] = [
            "etc": [
                "id": "etc",
                "name": "その他",
                "remark": "",
                "cashTransactions":cashTransactions01
            ],
            "sid002": [
                "id": "sid002",
                "name": "保険",
                "remark": "",
                "cashTransactions":cashTransactions02
            ],
            "sid003": [
                "id": "sid003",
                "name": "光熱費",
                "remark": "",
                "cashTransactions":cashTransactions03
            ],
            "sid004": [
                "id": "sid004",
                "name": "通信費",
                "remark": "",
                "cashTransactions":cashTransactions04
            ]
        ]
        
        
        
        let mainCategories: [String: Any] = [
            "mid001": [
                "id": "mid001",
                "name": "生活費",
                "inOut": "支出",
                "targetAmount": 60000,
                "remark": "",
                "subCategories": subCategories01
            ],
            "mid002": [
                "id": "mid002",
                "name": "固定費",
                "inOut": "支出",
                "targetAmount": 85000,
                "remark": "",
                "subCategories": subCategories02
            ]
        ]
        
        dic = [
            "id": "0001",
            "name": "若江家の家計簿",
            "families": families,
            "myBanks": myBanks,
            "mainCategories": mainCategories
        ]
    }
}



struct CurrentData {
    static var faminance: Faminance = Faminance(dic: SampleData().dic)
}
