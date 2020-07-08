//
//  Formatter+Ext.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/5/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}
