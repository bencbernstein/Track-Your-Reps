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
    //var dataStore = DataStore()
    
    var state: String = ""

    init () {}
    
  
}

//
//final class DataStore {
//    let provider = ProPublicaProvider.sharedProvider
//    var members : [CongressMember] = []
//    
//    static let sharedInstance = DataStore()
//    private init () {
//        print("members are \(members)")
//        
//        members = CongressMember.all(for: user.state)
//        print("members are \(members)")
//        
//    }
//}
