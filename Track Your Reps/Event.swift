///
/// Event.swift
///

import Foundation
import SwiftyJSON

struct Event {
    
    var bill: String?
    var rawDate: String
    var description: String
    var position: String
    var question: String
    var repId: String
    var repName: String
    var time: String?
    
    init(from json: JSON, for member: CongressMember) {
        self.bill = json["bill"].stringValue
        self.rawDate = json["date"].stringValue
        self.description = json["description"].stringValue
        self.position = json["position"].stringValue
        self.question  = json["question"].stringValue
        self.time = json["time"].stringValue
        
        self.repName = member.fullName
        self.repId = member.id
      }
}

extension Event: Hashable {
    
    var hashValue: Int {
        return description.hashValue
    }
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.description == rhs.description
    }
    
}
