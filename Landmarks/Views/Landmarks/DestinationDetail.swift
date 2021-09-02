/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view showing the details for a landmark.
 */

import SwiftUI

struct DestinationDetail: View {
    @EnvironmentObject var modelData: ModelData
    var destination: Destination
    
    @State private var selectedId = ""
    @State private var isSelected = false

    
    var destinationIndex: Int {
        modelData.destinations.firstIndex(where: { $0.id == destination.id })!
    }
    
    var body: some View {
        ScrollView {
            Text(destination.name.prefix(1))
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 35, height: 35, alignment: .center)
                .overlay(Circle().stroke(Color.gray, lineWidth: 3).padding(1))
                .foregroundColor(.green)
                .offset(y: -5)
            
            MapView(selected: $selectedId,
                    coordinate: destination.locationCoordinate, annotations: [])
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(destination.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.destinations[destinationIndex].isFavorite)
                }
                
                HStack {
                    Text(String(format: "%f", destination.latitude))
                    Divider()
                    Text(String(format: "%f", destination.longitude))
                    
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
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
