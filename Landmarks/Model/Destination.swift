//
//  Destination.swift
//  Landmarks
//
//  Created by Sebastijan Grabar on 01.09.2021..
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation
import CoreLocation

struct Destination: Codable, Identifiable {
    var id: String { name }

    var name: String
    var latitude: Double
    var longitude: Double
    
    var isFavorite: Bool
    var isConfirmed: Bool
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: self.latitude,
            longitude: self.longitude
        )
    }
}
