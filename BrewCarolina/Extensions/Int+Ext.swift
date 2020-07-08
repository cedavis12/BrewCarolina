//
//  Int+Ext.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/5/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import Foundation

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
