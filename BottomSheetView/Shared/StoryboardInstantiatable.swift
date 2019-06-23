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
