//
//  Extensions.swift
//  TAIMEE_MAP_SAMPLE
//
//  Created by Takeshi Akutsu on 2019/06/21.
//  Copyright © 2019 otw. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChild(viewController: UIViewController, to container: UIView) {
        addChild(viewController)
        viewController.view.frame = container.bounds
        container.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func insertChild(viewController: UIViewController, to container: UIView) {
        addChild(viewController)
        viewController.view.frame = container.bounds
        container.insertSubview(viewController.view, at: 0)
        viewController.didMove(toParent: self)
    }
    
    func removeChild(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}


public extension UIView {
    /// ある特定クラスのsuperViewを探す
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.flatMap { $0.superview(of: type) }
    }
    
    /// ある特定クラスのsubViewを探す
    func subview<T>(of type: T.Type) -> T? {
        return subviews.compactMap { $0 as? T ?? $0.subview(of: type) }.first
    }
}
