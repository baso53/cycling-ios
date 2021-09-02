//
//  HelperFunctions.swift
//  Landmarks
//
//  Created by Sebastijan Grabar on 02.09.2021..
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation

func idFromCoordinates(_ latitude: Double, _ longitude: Double) -> String {
    String(format: "%f,%f", latitude, longitude)
}
