/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct DestinationList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false

    var filteredDestinations: [Destination] {
        modelData.destinations.filter { destination in
            (!showFavoritesOnly || destination.isFavorite)
        }
    }

    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }

                ForEach(filteredDestinations) { destination in
                    NavigationLink(destination: DestinationDetail(destination: destination)) {
                        DestinationRow(destination: destination)
                    }
                }
            }
            .navigationTitle("Destinations")
        }
    }
}

struct DestinationList_Previews: PreviewProvider {
    static var previews: some View {
        DestinationList()
            .environmentObject(ModelData())
    }
}
