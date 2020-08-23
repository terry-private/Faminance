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

class RecordViewController : UIViewController {
    
    
    @IBOutlet weak var inOutSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var bankButton: UIButton!
    
    var mainCategoryId: String = ""
    var subCategoryId: String = ""
    
    @IBAction func amountButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "InputCalculatorView", bundle: nil)
        let inputCalculaorViewController = storyboard.instantiateViewController(withIdentifier: "InputCalculatorViewController") as! InputCalculatorViewController
        let fN = amountButton.titleLabel?.text?.replace("¥", "").replace(",", "") ?? ""
        inputCalculaorViewController.firstNumber = fN
        inputCalculaorViewController.setAmount(fN)
        inputCalculaorViewController.inputCalculatorViewControllerDelegate = self
        let nav = BottomHalfModalNavigationController(rootViewController: inputCalculaorViewController)
        nav.navigationBar.barTintColor = .rgba(red:26,green:188, blue:156 ,alpha:1)
        
        self.present(nav, animated: true, completion: nil)
    }
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        let dateFormatter = DateFormatter.current("yyyy'年'M'月'd'日'")
        let date = dateFormatter.date(from: self.dateButton.titleLabel?.text ?? "")
        
        
        let storyboard = UIStoryboard.init(name: "InputCalendarView", bundle: nil)

        let inputCalendarViewController = storyboard.instantiateViewController(withIdentifier: "InputCalendarViewController") as! InputCalendarViewController
        inputCalendarViewController.inputCalendarViewControllerDelegate = self

        inputCalendarViewController.currentDate = date ?? Date.current
        
        let nav = BottomHalfModalNavigationController(rootViewController: inputCalendarViewController)
        nav.navigationBar.barTintColor = .rgba(red:26,green:188, blue:156 ,alpha:1)
        self.present(nav, animated: true, completion: nil)
    }
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "InputMainCategory", bundle: nil)

        let inputMainCategoryViewController = storyboard.instantiateViewController(withIdentifier: "InputMainCategoryViewController") as! InputMainCategoryViewController
        inputMainCategoryViewController.inputMainCategoryViewControllerDelegate = self

        let nav = inputMainCategoryViewController.navigationController ?? BottomHalfModalNavigationController(rootViewController: inputMainCategoryViewController)
        nav.navigationBar.barTintColor = .rgba(red:26,green:188, blue:156 ,alpha:1)
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func bankButtonTapped(_ sender: Any) {
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func setUp(){
        dateButton.setTitle(Date.current.longDate(),for: .normal)
        amountButton.setTitle("¥0",for: .normal)
    }
    
    
    
}


extension RecordViewController: InputCalendarViewControllerDelegate, InputCalculatorViewControllerDelegate, InputMainCategoryViewControllerDelegate{
    func fixAmount(_ amount: String) {
        amountButton.setTitle(amount, for: .normal)
    }
    
    func setDate(_ date: Date) {
        dateButton.setTitle(date.longDate(), for: .normal)
    }
    
    func fixCategory(_ dic: [String : String]) {
        categoryButton.setTitle((dic["mainCategoryName"] ?? "") + " > " + (dic["subCategoryName"] ?? ""), for: .normal)
        mainCategoryId = dic["mainCategoryId"] ?? ""
        subCategoryId = dic["subCategoryId"] ?? ""
    }
    
}
