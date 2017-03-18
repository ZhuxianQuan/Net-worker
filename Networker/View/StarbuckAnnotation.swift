//
//  StarbuckAnnotation.swift
//  OUT
//
//  Created by Huijing on 06/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit
import MapKit

class StarbuckAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var user = UserModel()
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
