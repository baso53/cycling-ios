//
//  FBLoginView.swift
//  Landmarks
//
//  Created by Sebastijan Grabar on 03.09.2021..
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI
import UIKit
import FBSDKLoginKit

struct FBLoginView: UIViewRepresentable {
    
    typealias UIViewType = FBLoginButton
    
    func makeUIView(context: UIViewRepresentableContext<FBLoginView>) -> FBLoginButton {
        let loginButton = FBLoginButton()
        loginButton.permissions = ["public_profile", "email"]
        
        return loginButton
    }
            
    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FBLoginView>) {
    }
    
}
