/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation
import Combine
import CoreLocation


class ModelData: NSObject, ObservableObject {
    let locationManager = CLLocationManager()
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
    
    @Published var destinations = [Destination]()
    
    func loadData() {
        guard let url = URL(string: "http://cycling-app.eu-central-1.elasticbeanstalk.com/destinations") else {
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
    
    func verifyQRCode(qrCode: String, onFinish: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        guard let url = URL(string: "http://cycling-app.eu-central-1.elasticbeanstalk.com/confirmation") else {
            print("Invalid url...")
            return
        }
        
        guard let encoded = try? JSONEncoder().encode(ConfirmationOutbound(hash: qrCode)) else {
            print("Failed to encode order")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = encoded
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                onFinish(data, response, error)
            }
        }.resume()
        
        

    }
}

extension ModelData: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorisationStatus = status
    }
}
