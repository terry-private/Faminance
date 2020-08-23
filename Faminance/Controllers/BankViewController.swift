//
//  BankViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit

class BankViewController: UIViewController {
    private let bankUiColorPallete: [UIColor] = [
        UIColor.rgba(red: 46, green: 204, blue: 113, alpha: 0.8),//緑
        UIColor.rgba(red: 243, green: 156, blue: 18, alpha: 0.8),//オレンジ
        UIColor.rgba(red: 52, green: 152, blue: 219, alpha: 0.8),//青
        UIColor.rgba(red: 241, green: 196, blue: 15, alpha: 0.8),//黄
        UIColor.rgba(red: 155, green: 89, blue: 182, alpha: 0.8)//紫
    ]
    private let selectedUiColorPallete: [UIColor] = [
        UIColor.rgba(red: 46/3*2, green: 204/3*2, blue: 113/3*2, alpha: 1),//緑
        UIColor.rgba(red: 243/3*2, green: 156/3*2, blue: 18/3*2, alpha: 1),//オレンジ
        UIColor.rgba(red: 52/3*2, green: 152/3*2, blue: 219/3*2, alpha: 1),//青
        UIColor.rgba(red: 241/3*2, green: 196/3*2, blue: 15/3*2, alpha: 1),//黄
        UIColor.rgba(red: 155/3*2, green: 89/3*2, blue: 182/3*2, alpha: 1)//紫
    ]
    private let cellId = "cellId"
    let faminance = Faminance(dic: SampleData().dic)
    var currentDate = Date()
    
    
    @IBOutlet weak var bankTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    func setUpTable() {
        bankTableView.delegate = self
        bankTableView.dataSource = self
        bankTableView.register(UINib(nibName: "BankTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
}

extension BankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faminance.myBanks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bankTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BankTableViewCell
        let bk = faminance.myBankAtIndex(indexPath.row)
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        cell.bankNameLabel.text = bk?.name
        cell.latestBalanceLabel.text = formatter.string(from: NSNumber(value: bk?.latestBalance() ?? 0))
        
        cell.selectedBackgroundView?.backgroundColor = selectedUiColorPallete[indexPath.row % 5]
        cell.backgroundColor = bankUiColorPallete[indexPath.row % 5]
        
        
        
        return cell
    }
    
    
}
