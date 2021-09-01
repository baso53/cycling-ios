/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A single row to be displayed in a list of landmarks.
*/

import SwiftUI

struct DestinationRow: View {
    var destination: Destination

    var body: some View {
        HStack {
//            landmark.image
//                .resizable()
//                .frame(width: 50, height: 50)
            Text(destination.name)

            Spacer()

            if destination.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        Group {
            DestinationRow(destination: modelData.destinations[0])
            DestinationRow(destination: modelData.destinations[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
