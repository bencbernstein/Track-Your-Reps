//
//  Event.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/8/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Event {
    
    var bill: String?
    var repName: String?
    var description: String?
    var question: String?
    var date: String?
    var time: String?
    var position: String?
    
    init?(from json: JSON, name: String) {
        self.bill = json["bill"].stringValue
        self.description = json["description"].stringValue
        self.question  = json["question"].stringValue
        self.date = json["date"].stringValue
        self.time = json["time"].stringValue
        self.position = json["position"].stringValue
        self.repName = name
        
        
    }
    
}
