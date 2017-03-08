//
//  DataStore.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/8/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

final class DataStore {
    let provider = ProPublicaProvider.sharedProvider
    var members : [CongressMember] = []

    init () {
        print("members are \(members)")
        members = CongressMember.all(for: UserDefaults.standard.string(forKey: "state")!)
        print("members are \(members)")

    }
}

