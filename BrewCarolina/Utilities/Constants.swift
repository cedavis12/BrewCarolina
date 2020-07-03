//
//  Constants.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/1/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

enum ErrorMessage: String, Error {
    case badRequest = "The server was unable to process the request"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case invalidBrewery =  "This brewery created an invalid request. Please try again."
}

enum SFSymbols {
    static let location = UIImage(systemName: "mappin.and.ellipse")
    static let distance = UIImage(systemName: "map.fill")
    static let web = UIImage(systemName: "globe")
}

enum Images {
    static let placeholder = UIImage(named: "bc-logo")
}


