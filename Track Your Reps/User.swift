///
/// User.swift
///

import Foundation

final class User {
    
    static let sharedInstance = User()
    
    var dataStore = DataStore()
    let defaults = UserDefaults.standard
    var state = ""
    
    private init() {}
}
