//
//  MapData.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/25.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

import MapKit
import CoreLocation

struct MapData {
    var annotations: [OfferingAnnotation] = []
    
    init(offerings: [Offering]) {
        offerings.forEach { annotations.append(.init(offering: $0)) }
    }
}
