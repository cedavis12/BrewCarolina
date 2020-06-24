//
//  Brewery.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/22/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import Foundation

struct Brewery: Codable {
    var id: Int
    var name: String
    var breweryType: String
    var street: String
    var city: String
    var state: String
    var postalCode: String
    var country: String
    var longitude: String?
    var latitude: String?
    var phone: String
    var websiteUrl: String
}
