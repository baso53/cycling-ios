//
//  Api.swift
//  Landmarks
//
//  Created by Sebastijan Grabar on 01.09.2021..
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation

class Api : ObservableObject{
    @Published var destinations = [Destination]()
    
    func loadData(completion:@escaping ([Destination]) -> ()) {
        guard let url = URL(string: "http://localhost:8080/destinations") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let destinations = try! JSONDecoder().decode([Destination].self, from: data!)
            print(destinations)
            DispatchQueue.main.async {
                completion(destinations)
            }
        }.resume()
        
    }
}
