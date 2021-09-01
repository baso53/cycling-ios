//
//  Destination.swift
//  Landmarks
//
//  Created by Sebastijan Grabar on 01.09.2021..
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation

struct Destination: Codable, Identifiable {
    var id: String { name }

    var name: String
    var latitude: Double
    var longitude: Double
    
    var isFavorite: Bool
    var isConfirmed: Bool
}
