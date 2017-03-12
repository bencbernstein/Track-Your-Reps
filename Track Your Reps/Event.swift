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

    var memberPositions: NSMutableAttributedString? {
        let returnString = NSMutableAttributedString(string: "")
        for member in congressMembers {
            guard let event = member.events.filter({ $0 == self }).first else { return nil }
            let memberNameString = NSMutableAttributedString(
                string: (member.fullName + " voted " + event.position + "\n").uppercased(),
                attributes: [NSForegroundColorAttributeName:Palette.grey.color])
            memberNameString.addAttribute(NSForegroundColorAttributeName, value: member.partyColor(), range: NSRange(location:0, length: member.fullName.characters.count))
            memberNameString.addAttribute(NSForegroundColorAttributeName, value: event.positionColor(), range: NSRange(location:memberNameString.string.characters.count - (event.position.characters.count + 1), length: event.position.characters.count))

            returnString.append(memberNameString)
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        returnString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, returnString.length))
        
        return returnString
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
