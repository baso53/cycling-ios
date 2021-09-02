/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view that presents a map of a landmark.
 */

import SwiftUI
import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: String { String(format: "%f,%f", latitude, longitude) }
}

struct MapView: View {
    @Binding var selected: String
    
    var coordinate: CLLocationCoordinate2D
    var annotations: [CLLocationCoordinate2D]

    @State private var region = MKCoordinateRegion()
        
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: annotations
        ) { item in
            MapAnnotation(
                coordinate: item,
                anchorPoint: CGPoint(x: 0.5, y: 0)
            ) {
                Image(selected == item.id ? "maps-and-flags-green" : "maps-and-flags-black" )
                    .onTapGesture {
                        self.selected = item.id
                    }
            }
        }
        .onAppear {
            setRegion(coordinate)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(
//            action: {_ in },
//            coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)
//        )
//    }
//}
