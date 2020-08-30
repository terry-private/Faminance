//
//  BankViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit

class BankViewController: UIViewController {
    private let cellId = "cellId"
    
    var currentVersion = CurrentData.faminance.version
    var myBankKeys: [String] = [String](CurrentData.faminance.myBanks.keys).sorted{ $0 < $1 }
    var currentDate = Date.current
    
    
    @IBOutlet weak var bankTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 変更がある場合のみテーブルをリロード
        if currentVersion != CurrentData.faminance.version{
            myBankKeys.removeAll()
            bankTableView.reloadData()
            self.myBankKeys = [String](CurrentData.faminance.myBanks.keys).sorted{ $0 < $1 }
            bankTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setUpTable() {
        bankTableView.delegate = self
        bankTableView.dataSource = self
        bankTableView.register(UINib(nibName: "BankTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
}

extension BankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBankKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bankTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BankTableViewCell
        let bk = CurrentData.faminance.myBanks[myBankKeys[indexPath.row]]
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        cell.bankNameLabel.text = bk?.name
        cell.latestBalanceLabel.text = formatter.string(from: NSNumber(value: bk?.latestBalance() ?? 0))
        
        cell.selectedBackgroundView?.backgroundColor = UIColor.rgb(red:0, green: 0, blue: 0, alpha: 0.1)
        cell.bankColorView.backgroundColor = CurrentData.chartColorList[indexPath.row % CurrentData.chartColorList.count]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
}
