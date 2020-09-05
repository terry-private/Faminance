//
//  InputMainCategoryViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/23.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import BottomHalfModal

protocol InputMainCategoryViewControllerDelegate {
    func fixCategory(_ dic: [String: String])
}

final class InputMainCategoryViewController: UIViewController, SheetContentHeightModifiable {

    let sheetContentHeightToModify: CGFloat = 420
    let cellId = "cellId"
    var inOut = "" {
        didSet{
            categoryList = [String]()
            mainCategoryTableView?.reloadData()
            
            for mc in [String](CurrentData.faminance.mainCategories.keys).sorted(by: {$0 < $1}) {
                if CurrentData.faminance.mainCategories[mc]?.inOut == inOut {
                    categoryList.append(mc)
                }
            }
            mainCategoryTableView?.reloadData()
        }
    }
    
    var categoryList = [String]()
    var inputMainCategoryViewControllerDelegate: InputMainCategoryViewControllerDelegate?
    
    @IBOutlet weak var mainCategoryTableView: UITableView!
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let closeButton = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(close))
        closeButton.tintColor = .white
        navigationItem.leftBarButtonItem = closeButton
        
        let backButton = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: nil)
        backButton.tintColor = .white
        navigationItem.backBarButtonItem = backButton
        
        mainCategoryTableView.delegate = self
        mainCategoryTableView.dataSource = self
        mainCategoryTableView.register(UINib(nibName: "InputMainCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adjustFrameToSheetContentHeightIfNeeded()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        adjustFrameToSheetContentHeightIfNeeded(with: coordinator)
    }

    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    /// カテゴリーの確定
    /// - Parameter dic: メインカテゴリー、サブカテゴリーのkey, nema　を辞書で渡します。
    func fixCategory(_ dic: [String: String]){
        inputMainCategoryViewControllerDelegate?.fixCategory(dic)
        dismiss(animated: true, completion: nil)
    }

}

extension InputMainCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainCategoryTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InputMainCategoryCell
        cell.mainCategoryNameLabel.text = CurrentData.faminance.mainCategories[categoryList[indexPath.row]]?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "InputSubCategory", bundle: nil)
        let inputSubCategoryViewController = storyboard.instantiateViewController(withIdentifier: "InputSubCategoryViewController") as! InputSubCategoryViewController
        inputSubCategoryViewController.mainCategory = CurrentData.faminance.mainCategories[categoryList[indexPath.row]]
        inputSubCategoryViewController.inputSubCategoryViewControllerDelegate = self
        
        navigationController?.navigationBar.barTintColor = .rgb(red:26,green:188, blue:156 ,alpha:1)
        navigationController?.pushViewController(inputSubCategoryViewController, animated: true)
        
    }
    
    
}
extension InputMainCategoryViewController: InputSubCategoryViewControllerDelegate {
    func fixSubCategory(_ dic: [String : String]) {
        fixCategory(dic)
    }
}

class InputMainCategoryCell: UITableViewCell {
    
    @IBOutlet weak var mainCategoryNameLabel: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
