//
//  NetworkManager.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/22/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    //    func getVenues(completion: @escaping ([Venue]?) -> Void){
    //        let url = "https://api.foursquare.com/v2/venues/search?client_id=PUJYEAXQRVUNZ1210S15NHQPWTMMFMJ2QNX2ZB3YNPDN3QJY&client_secret=5PUJ5TKNLTHULNUX1NVKUIITVSKXMFLFQFW3DN3AKIHMSMJO&categoryId=50327c8591d4c4b30a586d5d&near=Greenville,SC&radius=56400&limit=50&v=20180323"
    //        var venues: [Venue] = []
    //
    //        AF.request(url, method: .get).validate().responseJSON { response in
    //            switch response.result {
    //            case .success(let data):
    //                let json = JSON(data)
    //                let venueNum = json["response"]["venues"].count
    //
    //                for i in 0..<venueNum {
    //                    let venue = Venue(id: json["response", "venues", i, "id"].stringValue,
    //                                      name: json["response", "venues", i, "name"].stringValue,
    //                                      latitude: json["response", "venues", i, "location", "lat"].doubleValue,
    //                                      longitude: json["response","venues", i, "location", "lng"].doubleValue,
    //                                      city: json["response", "venues", i, "location", "city"].stringValue,
    //                                      state: json["response", "venues", i, "location", "state"].stringValue)
    //
    //                    venues.append(venue)
    //                }
    //
    //                venues = venues.filter {$0.state == "SC"}
    //                completion(venues)
    //
    //            case .failure(let error):
    //                print(error)
    //                completion(nil)
    //            }
    //        }
    //    }
    
    func getFSVenues (completed: @escaping ([Venue]?, String?) -> Void) {
        let urlString = "https://api.foursquare.com/v2/venues/search?client_id=PUJYEAXQRVUNZ1210S15NHQPWTMMFMJ2QNX2ZB3YNPDN3QJY&client_secret=5PUJ5TKNLTHULNUX1NVKUIITVSKXMFLFQFW3DN3AKIHMSMJO&categoryId=50327c8591d4c4b30a586d5d&near=Greenville,SC&radius=56400&limit=50&v=20180323"
        
        guard let url = URL(string: urlString) else {
            completed(nil, "Invalid request to the server.\n Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(nil, "Unable to complete request.\n Please try again.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from server.\n Please try again.")
                return
            }
            
            guard let data = data else {
                completed(nil, "Invalid response from server.\n Please try again.")
                return
            }
            
            let json = JSON(data)
            
            var venues = json["response"]["venues"].arrayValue.map { Venue(id: $0["id"].stringValue,
                                                                           name: $0["name"].stringValue,
                                                                           latitude: $0["location"]["lat"].doubleValue,
                                                                           longitude: $0["location"]["lng"].doubleValue,
                                                                           city: $0["location"]["city"].stringValue,
                                                                           state: $0["location"]["state"].stringValue)}
                        
            venues = venues.filter {$0.state == "SC"}
            
            completed(venues, nil)
        }
        
        task.resume()
    }
}


