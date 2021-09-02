/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view showing featured landmarks above a list of landmarks grouped by category.
 */

import SwiftUI
import CoreLocation

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = ""
    
    private var isShown: Binding<Bool> { Binding (
        get: { !showingProfile.isEmpty },
        set: { _ in self.showingProfile = "" }
    )}
    
    var body: some View {
        NavigationView {
            VStack {
                MapView(
                    selected: $showingProfile,
                    coordinate: CLLocationCoordinate2D(
                        latitude: 46,
                        longitude: 16
                    ),
                    annotations: modelData.destinations.map({ destination in
                        destination.locationCoordinate
                    }))
            }
            .navigationTitle("Featured")
            .toolbar {
                Button(action: { modelData.requestAuthorisation() }) {
                    Image(systemName: "person.crop.circle")
                        .accessibilityLabel("User Profile")
                }
            }
            .sheet(isPresented: isShown) {
                let index = modelData.destinations.firstIndex(where: { destination in
                    idFromCoordinates(destination.latitude, destination.longitude) == showingProfile
                })!
                let destination = modelData.destinations[index]
                
                DestinationDetail(destination: destination)
            }
        }
        
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
