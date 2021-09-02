/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation
import Combine
import CoreLocation


class ModelData: NSObject, ObservableObject {
    @Published var landmarks: [Landmark] = []
    var hikes: [Hike] = []
    @Published var profile = Profile.default
    
    private let locationManager = CLLocationManager()
    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    public func requestAuthorisation(always: Bool = false) {
        if always {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
    
    @Published var destinations = [Destination]()
    
    func loadData() {
        guard let url = URL(string: "http://localhost:8080/destinations") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let destinations = try! JSONDecoder().decode([Destination].self, from: data!)
            print(destinations)
            DispatchQueue.main.async {
                self.destinations = destinations
            }
        }.resume()
        
    }
}

extension ModelData: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status
    }
}
