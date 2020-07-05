//
//  NetworkManager.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/22/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    //Get all venues from FourSquare that are a 35 mile radius around Greenville
    func getFSVenues (completed: @escaping (Result<[Venues], ErrorMessage>) -> Void) {
        let urlString = "https://api.foursquare.com/v2/venues/search?client_id=PUJYEAXQRVUNZ1210S15NHQPWTMMFMJ2QNX2ZB3YNPDN3QJY&client_secret=5PUJ5TKNLTHULNUX1NVKUIITVSKXMFLFQFW3DN3AKIHMSMJO&categoryId=50327c8591d4c4b30a586d5d&near=Greenville,SC&radius=56400&limit=50&v=20180323"
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.badRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let fsMain = try decoder.decode(FSMain.self, from: data)
                var venues = fsMain.response.venues
                venues = venues.filter {$0.location.state == "SC" && $0.id != "4f50b109e4b0e4085209b8a3" && $0.id != "4efbe97d30f8809e7616231d" && $0.id != "5c5f8960a30619002c33444d"}
                completed(.success(venues))
            }
            catch {
                print(error)
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    //Get the Untappd Id mapped from the FourSquare venue
    func getUTID(for venueID: String, completed: @escaping(Result<Int, ErrorMessage>) -> Void) {
        let urlString = "https://api.untappd.com/v4/venue/foursquare_lookup/\(venueID)?client_id=1A455B54ABF71244759C309CC915D8C34E9695AF&client_secret=3FC6D22517EABB2D18EBF707E4E3E1C8F8CE3EFD"
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.badRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let fsLookupMain = try decoder.decode(FSLookupMain.self, from: data)
                let breweryId = fsLookupMain.response.venue.items[0].venueId
                completed(.success(breweryId))
            }
            catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    //Get all details from a selected Brewery
    func getBreweryData(for breweryId: Int, completed: @escaping(Result<Brewery, ErrorMessage>) -> Void) {
        let urlString = "https://api.untappd.com/v4/venue/info/\(breweryId)?client_id=1A455B54ABF71244759C309CC915D8C34E9695AF&client_secret=3FC6D22517EABB2D18EBF707E4E3E1C8F8CE3EFD"
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.badRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let fsBreweryMain = try decoder.decode(FSBreweryMain.self, from: data)
                let brewery = fsBreweryMain.response.venue
                completed(.success(brewery))
            }
            catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            
            if let _ = error {
                completed(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil)
                return
            }
            
            guard let data = data else {
                completed(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}


