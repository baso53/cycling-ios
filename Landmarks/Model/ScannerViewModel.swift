//
//  ScannerViewModel.swift
//  Landmarks
//
//  Created by Sebastijan Grabar on 02.09.2021..
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation

class ScannerViewModel: ObservableObject {
    let scanInterval: Double = 1.0
    
    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = "Qr-code goes here"
    
    
    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }

}
