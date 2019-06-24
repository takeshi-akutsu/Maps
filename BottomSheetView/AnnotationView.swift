//
//  AnnotationView.swift
//  BottomSheetView
//
//  Created by Takeshi Akutsu on 2019/06/25.
//  Copyright © 2019 Takeshi Akutsu. All rights reserved.
//

import MapKit

final class OfferingAnnotationView: MKMarkerAnnotationView {
    static var reuseIdentifier = "OfferingAnnotation"
    
    private let offeringAnnotation: OfferingAnnotation?
    
    init(offeringAnnotation: OfferingAnnotation, reuseIdentifier: String?) {
        self.offeringAnnotation = offeringAnnotation
        super.init(annotation: offeringAnnotation, reuseIdentifier: reuseIdentifier)
//         displayPriority = .required
        clusteringIdentifier = "\(offeringAnnotation.type)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        if let offering = offeringAnnotation {
            glyphText = offering.type.name
            markerTintColor = offering.type.color
        }
    }
}
