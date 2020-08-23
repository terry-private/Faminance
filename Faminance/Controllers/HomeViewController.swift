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
    private let chartUiColorPallete: [UIColor] = [
        UIColor.rgb(red: 46, green: 204, blue: 113),//緑
        UIColor.rgb(red: 243, green: 156, blue: 18),//オレンジ
        UIColor.rgb(red: 52, green: 152, blue: 219),//青
        UIColor.rgb(red: 241, green: 196, blue: 15),//黄
        UIColor.rgb(red: 155, green: 89, blue: 182)//紫
    ]
    
    private let cellId = "cellId"
    let faminance = Faminance(dic: SampleData().dic).getAtMonth(date: Date())
    var currentDate = Date()

    @IBOutlet weak var previousMonthButton: UIButton!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var mainCategoryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        
    }
    func setUpTable(){
        mainCategoryTableView.delegate = self
        mainCategoryTableView.dataSource = self
        mainCategoryTableView.register(UINib(nibName: "MainCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for i in (0 ..< self.mainCategoryTableView.numberOfRows(inSection: 0)){
            let cell = self.mainCategoryTableView.cellForRow(at:IndexPath(row:i,section: 0)) as! MainCategoryTableViewCell
            cell.barAnimation()
        }
        
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faminance.mainCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainCategoryTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainCategoryTableViewCell
        let mc = faminance.mainCategoryAtIndex(indexPath.row)
        cell.statusNameLabel.text = mc?.name
        cell.targetAmount = Float(mc?.targetAmount ?? 0)
        cell.realAmount = Float(mc?.getSum() ?? 0)
        
        cell.statusFrontBarView.layer.backgroundColor = chartUiColorPallete[indexPath.row % 5].cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "MainCategoryDetails", bundle: nil)
        
        let mainCategoryPieChartViewController = storyboard.instantiateViewController(withIdentifier: "MainCategoryDetailsController") as! MainCategoryDetailsController
        mainCategoryPieChartViewController.currentDate = self.currentDate
        mainCategoryPieChartViewController.mainCategory = self.faminance.getAtMonth(date: currentDate).mainCategoryAtIndex(indexPath.row)
        mainCategoryPieChartViewController.myBanks = self.faminance.myBanks
        
        
        let nav = UINavigationController(rootViewController: mainCategoryPieChartViewController)
        nav.title = mainCategoryPieChartViewController.mainCategory?.name
        nav.navigationBar.barTintColor = chartUiColorPallete[indexPath.row]
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        mainCategoryPieChartViewController.navigationItem.title = mainCategoryPieChartViewController.mainCategory?.name
        
        
        
        self.present(nav, animated: true, completion: nil)
        
        
    }
}
