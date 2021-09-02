/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view showing featured landmarks above a list of landmarks grouped by category.
 */

import SwiftUI
import CoreLocation

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    
    var body: some View {
        ScrollView {
            VStack {
                MapView(coordinate: CLLocationCoordinate2D(
                    latitude: 46,
                    longitude: 16
                ), annotations: modelData.destinations.map({ destination in
                    destination.locationCoordinate
                }))
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
                
                Button(action: { modelData.requestAuthorisation() }, label: {
                    Text("Button")
                })
            }
        }
        .navigationTitle("Featured")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: { showingProfile.toggle() }) {
                Image(systemName: "person.crop.circle")
                    .accessibilityLabel("User Profile")
            }
        }
        .sheet(isPresented: $showingProfile) {
            ProfileHost()
                .environmentObject(modelData)
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
