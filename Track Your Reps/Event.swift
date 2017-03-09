///
/// Event.swift
///

import Foundation
import SwiftyJSON

struct Event {
    
    var bill: String?
    var date: String?
    var description: String?
    var position: String?
    var question: String?
    var repId: String?
    var time: String?
    
    init(from json: JSON, for member: CongressMember) {
        self.bill = json["bill"].stringValue
        self.date = json["date"].stringValue
        self.description = json["description"].stringValue
        self.position = json["position"].stringValue
        self.question  = json["question"].stringValue
        self.repId = member.id
        self.time = json["time"].stringValue
    }
}
