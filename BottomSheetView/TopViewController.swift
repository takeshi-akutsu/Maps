//
//  TopViewController.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/23.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

import UIKit

final class TopViewController: UIViewController {
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = SearchViewController.instantiate()
        addChild(viewController: vc, to: bottomSheetView)
        bottomSheetView.inject(tableView: vc.tableView)
    }
}

