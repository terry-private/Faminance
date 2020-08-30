//
//  HomeViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {
    
    private let cellId = "cellId"
    var version = CurrentData.faminance.version
    var mainCategoryKeys = [String](CurrentData.faminance.mainCategories.keys).sorted{$0 < $1}
    var currentFaminance = CurrentData.faminance.getAtMonth(date: Date.current)
    var currentDate = Date.current {
        didSet{
            print("currentDate>didSet")
            currentMonthLabel.text = " \(currentDate.year)年 \(currentDate.month)月の収支"
            tableReload()
        }
    }

    @IBOutlet weak var previousMonthButton: UIButton!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var mainCategoryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 変更がある場合のみテーブルをリロード
        if version != CurrentData.faminance.version {
            tableReload()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        runAllBarAnimation()
    }
    
    
    /// viewDidLoad時のテーブル初期設定
    private func setUpTable(){
        mainCategoryTableView.delegate = self
        mainCategoryTableView.dataSource = self
        mainCategoryTableView.register(UINib(nibName: "MainCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    /// tableCellをリロード
    func tableReload(){
        mainCategoryKeys.removeAll()
        mainCategoryTableView.reloadData()
        self.currentFaminance = CurrentData.faminance.getAtMonth(date:self.currentDate)
        self.mainCategoryKeys = [String](self.currentFaminance.mainCategories.keys).sorted{$0 < $1}
        self.mainCategoryTableView.reloadData()
        runAllBarAnimation()
    }
    
    /// 全てのバーアニメーションを開始します。
    func runAllBarAnimation(){
        for i in (0 ..< self.mainCategoryTableView.numberOfRows(inSection: 0)){
            let cell = self.mainCategoryTableView.cellForRow(at:IndexPath(row:i,section: 0)) as! MainCategoryTableViewCell
            cell.barAnimation()
        }
    }
    
    @IBAction func previousMonthButtonTapped(_ sender: Any) {
        currentDate = currentDate.added(month: -1)
    }
    
    /// 今月より先は選べないようにします。
    @IBAction func nextMonthButtonTapped(_ sender: Any) {
        if currentDate.month < Date.current.month {
            currentDate = currentDate.added(month:1)
        }
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainCategoryKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainCategoryTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainCategoryTableViewCell
        let mc = currentFaminance.mainCategories[mainCategoryKeys[indexPath.row]]
        cell.statusNameLabel.text = mc?.name
        cell.targetAmount = Float(mc?.targetAmount ?? 0)
        cell.realAmount = Float(mc?.getSum() ?? 0)
        
        // chartColorListのリストをループで使い回します。
        cell.statusFrontBarView.layer.backgroundColor = CurrentData.chartColorList[indexPath.row % CurrentData.chartColorList.count].cgColor
        
        return cell
    }
    
    /// テーブル選択時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "MainCategoryDetails", bundle: nil)
        
        let mainCategoryPieChartViewController = storyboard.instantiateViewController(withIdentifier: "MainCategoryDetailsController") as! MainCategoryDetailsController
        mainCategoryPieChartViewController.currentDate = self.currentDate
        mainCategoryPieChartViewController.mainCategory = currentFaminance.mainCategories[mainCategoryKeys[indexPath.row]]?.getAtMonth(date: currentDate)
        mainCategoryPieChartViewController.myBanks = CurrentData.faminance.myBanks
        
        var pieChartColorList = [UIColor]()
        for i in (0 ..< CurrentData.chartColorList.count) {
            pieChartColorList.append(CurrentData.chartColorList[(i + indexPath.row) % CurrentData.chartColorList.count])
        }
        mainCategoryPieChartViewController.chartUiColorPallete = pieChartColorList
        
        // メインカテゴリーチャートと同じ色のナビゲーションバーを作ります。
        let nav = UINavigationController(rootViewController: mainCategoryPieChartViewController)
        nav.title = mainCategoryPieChartViewController.mainCategory?.name
        nav.navigationBar.barTintColor = CurrentData.chartColorList[indexPath.row]
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        mainCategoryPieChartViewController.navigationItem.title = mainCategoryPieChartViewController.mainCategory?.name
        
        self.present(nav, animated: true, completion: nil)
    }
}
