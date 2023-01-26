//
//  NetworkManagerAPIClient.swift
//  AlbertsonsCode
//
//  Created by Usama Inaam Rasheed on 1/26/23.
//

import Foundation
import UIKit

class NetworkManager {
    
    /// Singleton Network class to manage API Calls
    static let sharedService = NetworkManager()
    private init() {}
    
    func getDataFrom(url: String, completion:@escaping (Data) -> ()) {
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            completion(data)
        }.resume()
    }
    
}
