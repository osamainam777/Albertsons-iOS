//
//  CatViewModel.swift
//  AlbertsonsCode
//
//  Created by Usama Inaam Rasheed on 1/26/23.
//

import Foundation
import UIKit


class CatViewModel: ObservableObject {
    
    @Published var catImage: UIImage = UIImage()
    @Published var factsDataSource: String = ""
    @Published var isLoad = false
    let dispatchGroup = DispatchGroup()
    
    /// Initing & loading facts/Images on API Call Back
    func loadDatasource() {
        self.isLoad = false
        dispatchGroup.enter()
        
        //API Call
        loadCatFacts { fact, statusCode  in
            if fact != nil{
                if let data = fact?.data.first {
                    self.factsDataSource = data
                    self.dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.enter()
        downloadImage()
        dispatchGroup.notify(queue: .main) {
            self.isLoad = true
        }
    }
    
    ///  Random fuction to switch between Cat Images
    func getRandom() -> Int {
        return Int.random(in: 300..<400)
    }
    
    /// API Call for downloading Cat Image Wrapper
    func downloadImage() {
        NetworkManager.sharedService.getDataFrom(url: Common.imageUrl.rawValue + "\(getRandom())") { [weak self] imageData in
            if let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.catImage = image
                }
                self?.dispatchGroup.leave()
            }
        }
    }
    
    /// API Call for the Cat Facts
    func loadCatFacts(url: String? = nil, completion:@escaping (FactModel?, Int) -> ()) {
        let factsUrl = Common.factsUrl.rawValue + UUID().uuidString
        let urlString: String? = url ?? factsUrl
        
        /// Invalid URL Handling
        guard let urlString = urlString else {
            print("Invalid")
            completion(nil, 400)
            return
        }
        NetworkManager.sharedService.getDataFrom(url: urlString) { data in
            DispatchQueue.main.async {
                /// Succes Response & Statuse Code completion
                do {
                    let jsonModel = try JSONDecoder().decode(FactModel.self, from: data)
                    completion(jsonModel, 200)
                    
                } catch _ {
                    completion(nil, 400)
                    print("Error decoding: ", APIHandlerError.decodeError)
                }
            }
        }
    }
}

///Error Handling enums for the HTTP
enum APIHandlerError: Error {
    case fetchError, decodeError, httpError
}
