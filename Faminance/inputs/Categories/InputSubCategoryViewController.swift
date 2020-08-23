//
//  InputSubCategoryViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/23.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import BottomHalfModal
protocol InputSubCategoryViewControllerDelegate {
    func fixSubCategory(_ dic: [String: String])
}

class InputSubCategoryViewController: UIViewController, SheetContentHeightModifiable {
    var mainCategory: MainCategory?
    var inputSubCategoryViewControllerDelegate: InputSubCategoryViewControllerDelegate?
    @IBOutlet weak var subCategoryTableView: UITableView!
    let sheetContentHeightToModify: CGFloat = 420
    let cellId = "cellId"
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        subCategoryTableView.delegate = self
        subCategoryTableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adjustFrameToSheetContentHeightIfNeeded()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        adjustFrameToSheetContentHeightIfNeeded(with: coordinator)
    }
    
    func fixSubCategory(_ dic: [String: String]) {
        self.inputSubCategoryViewControllerDelegate?.fixSubCategory(dic)
    }

}
extension InputSubCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainCategory?.subCategories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subCategoryTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InputSubCategoryTableViewCell
        cell.subCategoryNameLabel.text = mainCategory?.subCategoryAtIndex(indexPath.row)?.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = [
            "mainCategoryId": mainCategory?.id ?? "",
            "mainCategoryName": mainCategory?.name ?? "",
            "subCategoryId": mainCategory?.subCategoryAtIndex(indexPath.row)?.id ?? "",
            "subCategoryName": mainCategory?.subCategoryAtIndex(indexPath.row)?.name ?? ""
        ]
        self.fixSubCategory(dic)
    }
    
}

class InputSubCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subCategoryNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
