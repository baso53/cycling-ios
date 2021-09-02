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
            Text(destination.name.prefix(1))
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 35, height: 35, alignment: .center)
                .overlay(Circle().stroke(Color.gray, lineWidth: 3).padding(1))
                .foregroundColor(.green)
            
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
        DestinationRow(destination: Destination(name: "Sebo", latitude: 42.123123, longitude: 16.123123, isFavorite: true, isConfirmed: false))
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
