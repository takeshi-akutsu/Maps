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
            mapView.mapType = .mutedStandard
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = SearchViewController.instantiate()
        addChild(viewController: vc, to: bottomSheetView)
        bottomSheetView.inject(tableView: vc.tableView)
        let offerings = TopViewModel.init().offerings
        offerings.forEach { [weak self] in
            let annotation = OfferingAnnotation.init(offering: $0)
            self?.mapView.addAnnotation(annotation)
        }
    }
}

extension TopViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        bottomSheetView.sheetLevel = .bottom
    }
}
