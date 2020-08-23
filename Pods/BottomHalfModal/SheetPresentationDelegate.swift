//
//  SheetPresentationDelegate.swift
//  BottomHalfModal
//
//  Created by 若江照仁 on 2020/08/20.
//

import UIKit

public class SheetPresentationDelegate: NSObject {

    public static var `default`: SheetPresentationDelegate = {
        return SheetPresentationDelegate()
    }()

}

extension SheetPresentationDelegate: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
        ) -> UIPresentationController? {
        return SheetPresentationController(presentedViewController: presented, presenting: presenting)
    }

    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
        ) -> UIViewControllerAnimatedTransitioning? {
        return SheetAnimationController(forPresenting: true)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SheetAnimationController(forPresenting: false)
    }
}
