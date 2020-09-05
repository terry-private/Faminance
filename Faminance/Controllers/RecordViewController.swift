//
//  RecordViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/16.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import FSCalendar
import BottomHalfModal

protocol RecordViewControllerDelegate {
    func addedCashTransaction()
}

class RecordViewController : UIViewController {
    
    @IBOutlet weak var inOutSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var bankButton: UIButton!
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var fixButton: UIButton!
    @IBAction func changedInOutSegment(_ sender: Any) {
        categoryButton.setTitle(" カテゴリー", for: .normal)
        categoryButton.setTitleColor(.lightGray, for: .normal)
        mainCategoryId = ""
        subCategoryId = ""
    }
    
    
    var mainCategoryId: String = ""
    var subCategoryId: String = ""
    var bankId: String = ""
    var alertController: UIAlertController! // error massage dialog
    var recordViewControllerDelegate: RecordViewControllerDelegate?
    
    
    @IBAction func amountButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "InputCalculatorView", bundle: nil)
        let inputCalculaorViewController = storyboard.instantiateViewController(withIdentifier: "InputCalculatorViewController") as! InputCalculatorViewController
        let fN = amountButton.titleLabel?.text?.replace("¥", "").replace(",", "") ?? ""
        inputCalculaorViewController.firstNumber = fN
        inputCalculaorViewController.setAmount(fN)
        inputCalculaorViewController.inputCalculatorViewControllerDelegate = self
        let nav = BottomHalfModalNavigationController(rootViewController: inputCalculaorViewController)
        nav.navigationBar.barTintColor = .rgb(red:26,green:188, blue:156 ,alpha:1)
        
        self.presentBottomHalfModal(nav, animated: true, completion: nil)
    }
    
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        let dateFormatter = DateFormatter.current("yyyy'年'M'月'd'日'")
        let date = dateFormatter.date(from: self.dateButton.titleLabel?.text ?? "")
        
        
        let storyboard = UIStoryboard.init(name: "InputCalendarView", bundle: nil)

        let inputCalendarViewController = storyboard.instantiateViewController(withIdentifier: "InputCalendarViewController") as! InputCalendarViewController
        inputCalendarViewController.inputCalendarViewControllerDelegate = self

        inputCalendarViewController.currentDate = date ?? Date.current
        
        let nav = BottomHalfModalNavigationController(rootViewController: inputCalendarViewController)
        nav.navigationBar.barTintColor = .rgb(red:26,green:188, blue:156 ,alpha:1)
        self.presentBottomHalfModal(nav, animated: true, completion: nil)
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "InputMainCategory", bundle: nil)

        let inputMainCategoryViewController = storyboard.instantiateViewController(withIdentifier: "InputMainCategoryViewController") as! InputMainCategoryViewController
        inputMainCategoryViewController.inputMainCategoryViewControllerDelegate = self
        inputMainCategoryViewController.inOut = inOutSegmentedControl.titleForSegment(at: inOutSegmentedControl.selectedSegmentIndex) ?? ""

        let nav = inputMainCategoryViewController.navigationController ?? BottomHalfModalNavigationController(rootViewController: inputMainCategoryViewController)
        nav.navigationBar.barTintColor = .rgb(red:26,green:188, blue:156 ,alpha:1)
        self.presentBottomHalfModal(nav, animated: true, completion: nil)
    }
    
    @IBAction func bankButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "InputBank", bundle: nil)

        let inputBankViewController = storyboard.instantiateViewController(withIdentifier: "InputBankViewController") as! InputBankViewController
        inputBankViewController.inputBankViewControllerDelegate = self

        let nav = inputBankViewController.navigationController ?? BottomHalfModalNavigationController(rootViewController: inputBankViewController)
        nav.navigationBar.barTintColor = .rgb(red:26,green:188, blue:156 ,alpha:1)
        self.presentBottomHalfModal(nav, animated: true, completion: nil)
        
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp(){
        memoTextField.layer.cornerRadius = 8
        memoTextField.layer.borderWidth = 1
        memoTextField.layer.borderColor = UIColor.lightGray.cgColor
        fixButton.layer.cornerRadius = 8
        fixButton.layer.borderWidth = 2
        fixButton.layer.borderColor = UIColor.lightGray.cgColor
        memoTextField.attributedPlaceholder = NSAttributedString(string: "メモ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        let clearButton = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(tappedClearButton))
        clearButton.tintColor = .white
        
        navigationItem.leftBarButtonItem = clearButton
        
        
        clear()
    }
    
    
    /// clearButtonタップ時のアクション
    @objc private func tappedClearButton() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 入力内容を初期状態に戻します。
    func clear(){
        dateButton.setTitle(Date.current.longDate(),for: .normal)
        amountButton.setTitle("¥0",for: .normal)
        categoryButton.setTitle(" カテゴリー", for: .normal)
        categoryButton.setTitleColor(.lightGray, for: .normal)
        mainCategoryId = ""
        subCategoryId = ""
        bankButton.setTitle(" 口座、財布", for: .normal)
        bankButton.setTitleColor(.lightGray, for: .normal)
        bankId = ""
        memoTextField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func memoTextFieldTappedDone(_ sender: Any) {
        self.view.endEditing(true)
    }

    
// ---------------------------------------
// 確定ボタン
// ---------------------------------------
    @IBAction func fixButtonTapped(_ sender: Any) {
        let newCtId = "ct\(CurrentData.faminance.getAllCashTransactions()?.count ?? 0)"
        let dateFormatter = DateFormatter.current("yyyy'年'M'月'd'日'")
        let date = dateFormatter.date(from: self.dateButton.titleLabel?.text ?? Date.current.longDate())
        var errorMessage: [String] = [String]()
        let amount = Int(amountButton.titleLabel?.text?.replace("¥", "").replace(",", "") ?? "0") ?? 0
        
        // バリデーション
        if amount < 0 { errorMessage.append("金額は￥0以上にしてください。")}
        if mainCategoryId == "" || subCategoryId == "" { errorMessage.append("カテゴリーを選択してください。") }
        if bankId == "" { errorMessage.append("口座、財布を選択してください。") }
        if errorMessage.count > 0 {alert(message: errorMessage.joined(separator: "\n")); return}
        
        
        CurrentData.faminance.addCashTransaction(CashTransaction(dic:[
            "id": newCtId,
            "inOut": inOutSegmentedControl.titleForSegment(at: inOutSegmentedControl.selectedSegmentIndex) ?? "",
            "amount": amount,
            "mainCategoryId": mainCategoryId,
            "subCategoryId": subCategoryId,
            "bankId": bankId,
            "date": date ?? Date.current,
            "memo": memoTextField.text ?? ""
        ]))
        CurrentData.faminance.version += 1
        recordViewControllerDelegate?.addedCashTransaction()
        dismiss(animated: true, completion: nil)
    }
    
    /// 確定ボタンを押した時に足りない情報がある場合のエラ〜メッセージダイアログを表示
    /// - Parameters:
    ///   - message: エラーメッセージ
    func alert(message:String) {
        alertController = UIAlertController(title: "入力エラー",
                                   message: message,
                                   preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil))
        present(alertController, animated: true)
    }
    
}


extension RecordViewController: InputCalendarViewControllerDelegate, InputCalculatorViewControllerDelegate, InputMainCategoryViewControllerDelegate, InputBankViewControllerDelegate{
    func fixAmount(_ amount: String) {
        amountButton.setTitle(amount, for: .normal)
    }
    
    func setDate(_ date: Date) {
        dateButton.setTitle(date.longDate(), for: .normal)
    }
    
    func fixCategory(_ dic: [String : String]) {
        categoryButton.setTitle(" \(dic["mainCategoryName"] ?? "") > \(dic["subCategoryName"] ?? "")", for: .normal)
        mainCategoryId = dic["mainCategoryId"] ?? ""
        subCategoryId = dic["subCategoryId"] ?? ""
        categoryButton.setTitleColor(.darkGray, for: .normal)
    }
    
    func fixBank(_ dic: [String : String]) {
        bankButton.setTitle(" " + (dic["bankName"] ?? ""), for: .normal)
        bankId = dic["bankId"] ?? ""
        bankButton.setTitleColor(.darkGray, for: .normal)
    }
    
    
}
