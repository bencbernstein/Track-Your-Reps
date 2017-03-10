///
/// Event.swift
///

import Foundation
import SwiftyJSON

struct Event: CustomStringConvertible, Hashable {
    
    // TODO: Parse and store bill dictionary
    // var bill: String?
    var chamber: String
    var congress: String
    var congressMembers: [CongressMember]
    var date: String
    var eventDescription: String
    var position: String
    var question: String
    var rollCall: String
    var session: String
    var time: String
    
    var shortDescription: String {
        return "\(eventDescription) - \(time)"
    }

    init(from json: JSON, for member: CongressMember) {
        self.chamber = json["chamber"].stringValue
        self.congress = json["congress"].stringValue
        self.congressMembers = [member]
        self.date = json["date"].stringValue
        self.eventDescription = json["description"].stringValue
        self.position = json["position"].stringValue
        self.question  = json["question"].stringValue
        self.rollCall  = json["roll_call"].stringValue
        self.session  = json["session"].stringValue
        self.time = json["time"].stringValue
    }
}


// MARK - Protocols

extension Event {
    
    var description: String {
        return "Congress Members:\(congressMembers.map({ $0.fullName }).joined(separator: ", "))\nQuestion: \(question)\nEvent Description: \(eventDescription)\nRaw date: \(date)"
    }
    
    var hashValue: Int {
        return shortDescription.hashValue
    }
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.shortDescription == rhs.shortDescription
    }
}
