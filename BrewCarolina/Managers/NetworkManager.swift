//
//  NetworkManager.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/22/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL = "https://api.openbrewerydb.org/breweries"
    
    private init(){}
    
    func getBreweries(page: Int, completed: @escaping ([Brewery]?, String?) -> Void){
        let endpoint = baseURL + "?by_state=south_carolina&per_page=50&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "Uh oh something went wrong; bad URL.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completed(nil, "Unable to complete request. \(error.localizedDescription)" )
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server.")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data recieved from the sever was invalid.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let breweries = try decoder.decode([Brewery].self, from: data)
                completed(breweries, nil)
            }
            catch {
                completed(nil, "The data received from the server was invalid.")
            }
        }
        
        task.resume()
    }
}
