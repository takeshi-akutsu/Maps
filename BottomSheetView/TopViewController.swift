//
//  TopViewController.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/23.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

import UIKit
import MapKit

final class TopViewController: UIViewController, LocationInfoRequestable {
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var bottomSheetView: BottomSheetView!
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            mapView.mapType = .mutedStandard
        }
    }
    
    var vc: SearchViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        vc = SearchViewController.instantiate()
        addChild(viewController: vc!, to: bottomSheetView)
        bottomSheetView.inject(tableView: vc!.tableView)
        bottomSheetView.customDelegate = self
        let offerings = TopViewModel.init().offerings
        mapView.addAnnotations(MapData.init(offerings: offerings).annotations)
        
        registerAnnotationViewClasses()
        
        locationManager = .init()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestAllowLocationInfo()
    }
    
    private func registerAnnotationViewClasses() {
        mapView.register(OfferingAnnotationView.self, forAnnotationViewWithReuseIdentifier: OfferingAnnotationView.reuseIdentifier)
    }
}

extension TopViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? OfferingAnnotation {
            return OfferingAnnotationView.init(offeringAnnotation: annotation, reuseIdentifier: OfferingAnnotationView.reuseIdentifier)
        } else if let cluster = annotation as? MKClusterAnnotation, let member = cluster.memberAnnotations.first as? OfferingAnnotation {
            let markerAnnotationView = MKMarkerAnnotationView()
            markerAnnotationView.glyphText = String(cluster.memberAnnotations.count)
            markerAnnotationView.markerTintColor = member.type.color
            markerAnnotationView.canShowCallout = false
            return markerAnnotationView
        } else {
            return nil // default orange marker
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? OfferingAnnotation {
            bottomSheetView.offerings = [annotation.offering]
        } else if let cluster = view.annotation as? MKClusterAnnotation {
            var offerings: [Offering] = []
            cluster.memberAnnotations.forEach { annotation in
                if let annotation = annotation as? OfferingAnnotation {
                    offerings.append(annotation.offering)
                }
            }
            bottomSheetView.offerings = offerings
        }
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        bottomSheetView.sheetLevel = .bottom
    }
}

extension TopViewController: BottomSheetViewDelegate {
    func updateDataSource(offerings: [Offering]) {
        vc?.dataSrouce = offerings
    }
}
