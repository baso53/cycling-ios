/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The top-level definition of the Landmarks app.
 */

import SwiftUI
import FBSDKCoreKit

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .onOpenURL { url in
                    ApplicationDelegate.shared.application(
                        UIApplication.shared,
                        open: url,
                        sourceApplication: nil,
                        annotation: [UIApplication.OpenURLOptionsKey.annotation]
                    )
                }.onAppear {
                    ApplicationDelegate.shared.initializeSDK()
                    
                    if let token = AccessToken.current,
                        !token.isExpired {
                        // User is logged in, do work such as go to next view controller.
                    }
                }
        }
    }
    
}
