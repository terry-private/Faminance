//
//  MainCategoryDetailsController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import Charts

class MainCategoryDetailsController: UIViewController {
    
    var mainCategory: MainCategory? = nil
    var myBanks = [String: MyBank]()
    var subCategories = [String: Int]()
    var subCategoryIds = [String: Int]()
    var currentDate = Date()
    var cashTransactions = [(key: String, value: CashTransaction)]()
    
    private let cellId = "cellId"
    
    
    var chartUiColorPallete: [UIColor] = [
        UIColor.rgb(red: 46, green: 204, blue: 113),//緑
        UIColor.rgb(red: 243, green: 156, blue: 18),//オレンジ
        UIColor.rgb(red: 52, green: 152, blue: 219),//青
        UIColor.rgb(red: 241, green: 196, blue: 15),//黄
        UIColor.rgb(red: 155, green: 89, blue: 182)//紫
    ]
    
    
    @IBOutlet weak var cashTransactionTableView: UITableView!
    
    @IBOutlet weak var mainCategoryPieChartView: PieChartView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPieChartView()
        setUpCashTransactionTableView()
    }
        
    func setUpPieChartView() {
        
        if self.mainCategory == nil { return }
        //mainCategoryNavigationItem.title = mainCategory!.name + "の内訳"
        
        mainCategory?.sortSubCategories()
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency

        self.mainCategoryPieChartView.entryLabelColor = .darkGray
        self.mainCategoryPieChartView.usePercentValuesEnabled = false
        mainCategoryPieChartView.rotationEnabled = false
        // 右下の説明
        self.mainCategoryPieChartView.chartDescription?.text = " \(currentDate.year)年 \(currentDate.month)月の支出"
        self.mainCategoryPieChartView.chartDescription?.textColor = .black
        
        // 真ん中
        self.mainCategoryPieChartView.holeColor = .clear
        
        let txt = "合計: \(numberFormatter.string(from: NSNumber(value: (self.mainCategory?.getSum())!))!)"
        let attribute = NSMutableAttributedString(string: txt)
        attribute.setAttributes([NSAttributedString.Key.foregroundColor:UIColor.darkGray,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], range: NSMakeRange(0, txt.count))
        self.mainCategoryPieChartView.centerAttributedText = attribute
        
        
        // 左下の項目と色について
        self.mainCategoryPieChartView.legend.textColor = .darkGray
        
        
        // 円グラフに表示するデータ
        var dataEntries = [PieChartDataEntry]()
        for index in (0..<(self.mainCategory?.sortedSubCategories.count)!) {
            let sc = self.mainCategory?.sortedSubCategories[index].value
            dataEntries.append(PieChartDataEntry(value:Double((sc!.getSum())), label: sc!.name))
            subCategoryIds[sc!.id] = index
            
        }
        
        let dataSet = PieChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = chartUiColorPallete
        let data = PieChartData(dataSet: dataSet)
        
        data.setValueFormatter(DefaultValueFormatter(formatter: numberFormatter))

        self.mainCategoryPieChartView.data = data
        
    }
    
    func setUpCashTransactionTableView() {
        if self.mainCategory == nil { return }
        self.cashTransactions = self.mainCategory!.getAllCashTransactions()!.sorted() {$0.value.date > $1.value.date}
        
        cashTransactionTableView.delegate = self
        cashTransactionTableView.dataSource = self
        cashTransactionTableView.register(UINib(nibName: "CashTransactionTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        cashTransactionTableView.rowHeight = 100
        
        
        
    }

}

extension MainCategoryDetailsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cashTransactionTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CashTransactionTableViewCell
        let ct = self.cashTransactions[indexPath.row].value
        
        
        cell.subCategoryColorRectView.backgroundColor = chartUiColorPallete[subCategoryIds[ct.subCategoryId]! % 5]
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        cell.subCategoryNameLabel.text = mainCategory?.subCategories[ct.subCategoryId]?.name
        cell.amountLabel.text = formatter.string(from: NSNumber(value: ct.amount))
        cell.dateLabel.text = ct.date.longDate()
        cell.bankLabel.text = myBanks[ct.bankId]?.name
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cashTransactions.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

