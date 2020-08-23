//
//  BasicViewController.swift
//  Faminance
//
//  Created by 若江照仁 on 2020/08/20.
//  Copyright © 2020 若江照仁. All rights reserved.
//

import UIKit
import BottomHalfModal

final class BasicViewController: UIViewController, SheetContentHeightModifiable {

    let sheetContentHeightToModify: CGFloat = 320

    init() {
        super.init(nibName: nil, bundle: Bundle(for: BasicViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        adjustFrameToSheetContentHeightIfNeeded()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        adjustFrameToSheetContentHeightIfNeeded(with: coordinator)
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
}
