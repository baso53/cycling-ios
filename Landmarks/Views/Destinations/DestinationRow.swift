/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A single row to be displayed in a list of landmarks.
 */

import SwiftUI
import CoreLocation


struct DestinationRow: View {
    @EnvironmentObject private var modelData: ModelData
    
    var destination: Destination
    
    var body: some View {
        HStack {
            Text(destination.name.prefix(1))
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 40, height: 40, alignment: .center)
                .overlay(Circle().stroke(Color.gray, lineWidth: 4).padding(1))
                .foregroundColor(.green)
            
            VStack(alignment: .leading) {
                Text(destination.name)
                
                getLocationText()
            }
            
            Spacer()
            
            if destination.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
    
    private func getLocationText() -> Text {
        let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        let distance = modelData.locationManager.location?.distance(from: destinationLocation)
        
        let returnVal = distance.map { distanceInMeters in
            Text(String(format: "%.1f km", distanceInMeters / 1000))
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        
        return returnVal ?? Text("")
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        DestinationRow(destination: Destination(name: "Sebo", latitude: 42.123123, longitude: 16.123123, isFavorite: true, isConfirmed: false))
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
