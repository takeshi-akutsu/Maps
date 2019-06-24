//
//  StoryboardInstantiatable.swift
//  taimee-ios
//
//  Created by Yuya Hirayama on 2018/07/04.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable where Self: UIViewController {
    static var storyboardName: String { get }
}

extension StoryboardInstantiatable {
    static var storyboardName: String {
        return String.init(describing: Self.self)
    }
    
    static func instantiate() -> Self {
        return UIStoryboard.init(name: storyboardName, bundle: nil).instantiateInitialViewController() as! Self
    }
}

protocol NibInstantiatable where Self: UIView {
    static var nibName: String { get }
    func loadNib()
}

extension NibInstantiatable {
    static var nibName: String {
        return String.init(describing: Self.self)
    }
    
    func loadNib() {
        let view = UINib.init(nibName: Self.nibName, bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(view)
        view.fill(in: view.superview!)
    }
}
