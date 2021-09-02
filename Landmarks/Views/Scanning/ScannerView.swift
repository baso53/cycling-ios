//
//  ScannerView.swift
//  Landmarks
//
//  Created by Sebastijan Grabar on 02.09.2021..
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct ScannerView: View {
    @State var torchIsOn: Bool = false
    @State var lastQrCode: String = "Qr-code goes here"
    @State var isShown: Bool = false
    
    var body: some View {
        ZStack {
            QrCodeScannerView()
                .found(r: { qrCode in
                    self.lastQrCode = qrCode
                    self.isShown = true
                })
            .torchLight(isOn: torchIsOn)
            .interval(delay: 1.0)
            
            VStack {
                VStack {
                    Text("Keep scanning for QR-codes")
                        .font(.subheadline)
                    Text(self.lastQrCode)
                        .bold()
                        .lineLimit(5)
                        .padding()
                }
                .padding(.vertical, 20)
                
                Spacer()
                HStack {
                    Button(action: {
                        self.torchIsOn.toggle()
                    }, label: {
                        Image(systemName: self.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.torchIsOn ? Color.yellow : Color.blue)
                            .padding()
                    })
                }
                .background(Color.white)
                .cornerRadius(10)
                
            }.padding()
        }
        .sheet(isPresented: $isShown) {
            ScannedCodeSheet(qrCode: lastQrCode)
        }
        
        
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
