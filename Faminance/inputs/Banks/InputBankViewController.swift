//
//  InputBankViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/25.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import BottomHalfModal

protocol InputBankViewControllerDelegate {
    func fixBank(_ dic: [String: String])
}

class InputBankViewController: UIViewController, SheetContentHeightModifiable {
    var sheetContentHeightToModify: CGFloat = 420
    let cellId = "cellId"
    var inputBankViewControllerDelegate : InputBankViewControllerDelegate?
    
    @IBOutlet weak var inputBankTableView: UITableView!
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let closeButton = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(close))
        closeButton.tintColor = .white
        navigationItem.leftBarButtonItem = closeButton
        
        inputBankTableView.delegate = self
        inputBankTableView.dataSource = self
        
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
    
    func fixBank(_ dic: [String: String]) {
        inputBankViewControllerDelegate?.fixBank(dic)
        dismiss(animated: true, completion: nil)
    }
}

extension InputBankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CurrentData.faminance.myBanks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = inputBankTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InputBankTableViewCell
        cell.bankNameLabel.text = CurrentData.faminance.myBankAtIndex(indexPath.row)?.name
        cell.id = CurrentData.faminance.myBankAtIndex(indexPath.row)?.id ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = inputBankTableView.cellForRow(at: indexPath) as! InputBankTableViewCell
        fixBank(["bankId": cell.id,"bankName": cell.bankNameLabel.text ?? ""])
        dismiss(animated: true, completion: nil)
    }
    
    
}


class InputBankTableViewCell: UITableViewCell {
    var id: String = ""
    
    @IBOutlet weak var bankNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
