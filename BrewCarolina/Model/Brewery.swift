//
//  Brewery.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/22/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//
import Foundation

struct Brewery {
    var venueId: String
    var name: String
    var address: String
    var postalCode: String
    var city: String
    var state: String
    var icon: String
    var contact: Contact
    var topBeers: [Beer]
}

struct Contact {
    var twitter: String
    var faceBook: String
    var website: String
}


