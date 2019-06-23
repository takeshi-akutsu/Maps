//
//  SearchViewController.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/23.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet weak var tableView: UITableView!
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(indexPath.row+1)番目のセル"
        return cell
    }
}
