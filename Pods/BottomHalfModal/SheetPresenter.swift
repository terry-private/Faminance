//
//  SheetPresenter.swift
//  BottomHalfModal
//
//  Created by 若江照仁 on 2020/08/20.
//

import UIKit

public protocol SheetPresenter {
    func presentBottomHalfModal(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
}

extension UIViewController: SheetPresenter {
    public func presentBottomHalfModal(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewControllerToPresent.modalPresentationStyle = .custom
        viewControllerToPresent.transitioningDelegate = SheetPresentationDelegate.default
        present(viewControllerToPresent, animated: animated, completion: completion)
    }
}
