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
    
    var dataSrouce: [Offering] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSrouce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
        let data = dataSrouce[indexPath.row]
        cell.textLabel?.text = "ID: \(data.id)の\(data.category.name)"
        cell.detailTextLabel?.text = "\(data.salary)で\(data.workHour)の業務です。"
        return cell
    }
}
