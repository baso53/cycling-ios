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
    var coordinate: CLLocationCoordinate2D
    var annotations: [CLLocationCoordinate2D]
    
    init(coordinate: CLLocationCoordinate2D, annotations: [CLLocationCoordinate2D]? = nil) {
        self.coordinate = coordinate
        self.annotations = annotations ?? [coordinate]
    }
    
    @State private var region = MKCoordinateRegion()
    
    @State private var active = ""
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: annotations
        ) { item in
            MapAnnotation(
                coordinate: item,
                anchorPoint: CGPoint(x: 0.5, y: 0.7)
            ) {
                Image(systemName: "mappin")
                    .font(.title)
                    .foregroundColor(active == item.id ? .red : .black)
                    .onTapGesture {
                        active = active == item.id ? "" : item.id
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

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(
            coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)
        )
    }
}
