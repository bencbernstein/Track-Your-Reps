//
//  User.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/8/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation

final class User {
    let defaults = UserDefaults.standard
    static let sharedInstance = User()
    var state = ""
    var dataStore = DataStore()
    private init () {
      
    }
    
  
}
