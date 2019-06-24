//
//  OfferingMarker.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/24.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

import MapKit

final class OfferingAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var type: Offering.Category = .unknown
    
    var title: String?
    let offering: Offering
    
    init(offering: Offering) {
        self.offering = offering
        coordinate = .init(latitude: offering.location.latitude, longitude: offering.location.longitude)
        self.title = "\(offering.salary)\n\(offering.workHour)"
        self.type = offering.category
        
    }
}
