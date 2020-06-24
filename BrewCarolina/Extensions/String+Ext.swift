//
//  String+Ext.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/23/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizingFirstLetter() -> String {
          return prefix(1).capitalized + dropFirst()
      }

      mutating func capitalizeFirstLetter() {
          self = self.capitalizingFirstLetter()
      }
}
