//
//  OfferingMarker.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/24.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

//import Foundation
//MKMarkerAnnotationView
import UIKit
import MapKit

final class OfferingAnnotation: NSObject, MKAnnotation {
    static let clusteringIdentifier = "FenrirOffice"
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(offering: Offering) {
        self.coordinate = .init(latitude: offering.location.latitude, longitude: offering.location.longitude)
//        self.title = offering.salary
//        self.subtitle = offering.workHour
        self.title = "\(offering.salary)\n\(offering.workHour)"
    }
}
