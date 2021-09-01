/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing the details for a landmark.
*/

import SwiftUI

struct DestinationDetail: View {
    @EnvironmentObject var modelData: ModelData
    var destination: Destination

    var destinationIndex: Int {
        modelData.destinations.firstIndex(where: { $0.id == destination.id })!
    }

    var body: some View {
        ScrollView {
            MapView(coordinate: destination.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)

//            CircleImage(image: destination.image)
//                .offset(y: -130)
//                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(destination.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.destinations[destinationIndex].isFavorite)
                }

//                HStack {
//                    Text(destination.park)
//                    Spacer()
//                    Text(destination.state)
//                }
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//
//                Divider()
//
//                Text("About \(destination.name)")
//                    .font(.title2)
//                Text(destination.description)
            }
            .padding()
        }
        .navigationTitle(destination.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DestinationDetail_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        DestinationDetail(destination: modelData.destinations[0])
            .environmentObject(modelData)
    }
}
