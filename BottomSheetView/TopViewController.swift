//
//  TopViewController.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/23.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

import UIKit
import MapKit

final class TopViewController: UIViewController {
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = SearchViewController.instantiate()
        addChild(viewController: vc, to: bottomSheetView)
        bottomSheetView.inject(tableView: vc.tableView)
    }
}

extension TopViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        bottomSheetView.sheetLevel = .bottom
    }
}
