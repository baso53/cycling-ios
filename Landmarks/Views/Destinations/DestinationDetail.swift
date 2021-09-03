/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view showing the details for a landmark.
 */

import SwiftUI

struct DestinationDetail: View {
    @EnvironmentObject var modelData: ModelData
    var destination: Destination
    
    @State private var isSelected = false
    
    private var selectedId: Binding<String> { Binding (
        get: { idFromCoordinates(destination.latitude, destination.longitude) },
        set: { _ in }
    )}
    
    var destinationIndex: Int {
        modelData.destinations.firstIndex(where: { $0.id == destination.id })!
    }
    
    var body: some View {
        ScrollView {
            Text(destination.name.prefix(1))
                .font(Font.custom("sebo", size: 150.0))
                .frame(width: 150, height: 150, alignment: .center)
                .overlay(Circle().stroke(Color.gray, lineWidth: 20).padding(1))
                .foregroundColor(.green)
                .offset(y: -30)
                .padding(.bottom, -80)
            
            MapView(selected: selectedId,
                    coordinate: destination.locationCoordinate, annotations: [destination.locationCoordinate])
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            VStack(alignment: .center) {
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
                
                FBLoginView()
                    .fixedSize()
                    .padding()
            }
            .padding()
        }
        .navigationTitle(destination.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DestinationDetail_Previews: PreviewProvider {
    static var previews: some View {
        DestinationDetail(destination: Destination(name: "sebo", latitude: 3.0, longitude: 20.0, isFavorite: true, isConfirmed: true))
            .environmentObject(ModelData())
    }
}
