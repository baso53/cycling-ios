//
//  ScannedCodeSheet.swift
//  Landmarks
//
//  Created by Sebastijan Grabar on 02.09.2021..
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct ScannedCodeSheet: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var isProgressVisible = true
    @State private var error = false
    
    var qrCode = ""
    
    var body: some View {
        ScrollView {
            if (isProgressVisible) {
                ProgressView()
            } else if (error){
                Text("Fail")
            } else {
                Text("Success")
            }
        }.onAppear {
            modelData.verifyQRCode(qrCode: qrCode) { data, response, error in
                if (data == nil) {
                    self.error = true
                } else {
                    self.isProgressVisible = false
                }
            }
        }
    }
}

struct ScannedCodeSheet_Previews: PreviewProvider {
    static var previews: some View {
        ScannedCodeSheet()
    }
}
