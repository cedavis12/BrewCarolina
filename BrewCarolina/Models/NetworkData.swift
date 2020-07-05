//
//  FourSquareData.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/2/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import Foundation

//FourSquare Data for All Venues
struct FSMain: Decodable {
    let response: FSResponse
}

struct FSResponse: Decodable {
    var venues: [Venues]
}

struct Venues: Decodable, Hashable {
    static func == (lhs: Venues, rhs: Venues) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.name == rhs.name
    }
    
    var id: String
    var name: String
    var location: Location
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(id)
    }
}

struct Location: Decodable {
    var address: String?
    var lat: Double?
    var lng: Double?
    var postalCode: String?
    var city: String?
    var state: String?
}

//FourSquare to Untappd Data
struct FSLookupMain: Decodable {
    let response: FSLookupResponse
}

struct FSLookupResponse: Decodable {
    var venue: Venue
}

struct Venue: Decodable {
    var items: [Items]
}

struct Items: Decodable {
    var venueName: String
    var venueId: Int
}


//Untappd Data for Breweries and Beer
struct FSBreweryMain: Decodable {
    let response: FSBreweryResponse
}

struct FSBreweryResponse: Decodable {
    var venue: Brewery
}

struct Brewery: Decodable {
    var venueId: Int
    var venueName: String
    var venueIcon: BreweryIcon
    var location: BreweryLocation
    var contact: Contact
    var topBeers: TopBeers
}

struct BreweryIcon: Decodable {
    var sm: String
    var md: String
}

struct BreweryLocation: Decodable {
    var venueAddress: String
    var venueCity: String
    var venueState: String
}

struct Contact: Decodable {
    var twitter: String
    var venueUrl: String
    var facebook: String
}

struct TopBeers: Decodable {
    var items: [BeerItems]
}

struct BeerItems: Decodable {
    var beer: Beer
}

struct Beer: Decodable {
    var bid: Int
    var beerName: String
    var beerLabel: String
    var beerAbv: Double
    var beerIbu: Int
    var beerDescription: String
    var beerStyle: String
    var ratingScore: Double
    var ratingCount: Int
}



