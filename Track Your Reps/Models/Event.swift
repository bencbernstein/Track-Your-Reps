///
/// Event.swift
///

import Foundation
import SwiftyJSON

struct Event: CustomStringConvertible, Hashable {
    
    var billId: String
    var bill: Bill?
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
    
    var isBill: Bool {
        return billId != ""
    }
    
    var positionImage: UIImage? {
        switch position {
        case "Yes":
            return #imageLiteral(resourceName: "Check")
        case "No":
            return #imageLiteral(resourceName: "X")
        default:
            return nil
        }
    }
    
    var shortDescription: String {
        return "\(eventDescription) - \(time)"
    }
    
    init(from json: JSON, for member: CongressMember) {
        self.billId = json["bill"]["bill_uri"].stringValue.components(separatedBy: "/").last ?? ""
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
    
    func fetchBill(completion: @escaping (Bill)->()) {
        let endpoint: ProPublicaAPI = .bill(id: billId)
        
        ProPublicaProvider.sharedProvider.request(endpoint) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = JSON(data: data)
                let bill = Bill(from: json)
                completion(bill)
            default:
                print("Bill call for event \(self.eventDescription) err'd.")
            }
        }
    }
}


// MARK: - Protocols
extension Event {
    
    var description: String {
        return "Congress Members:\(congressMembers.map({ $0.fullName }).joined(separator: ", "))\nQuestion: \(question)\nEvent Description: \(eventDescription)\nRaw date: \(date)"
    }
    
    var hashValue: Int {
        return eventDescription.hashValue
    }
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

// MARK: - Clean Strings
extension Event {
    
    var cleanTitle: NSAttributedString {
        if self.isBill {
            guard let safeBill = bill else { return NSAttributedString(string: "No Title") }
            let greyBillNumber = NSMutableAttributedString(string: safeBill.number, attributes: [NSForegroundColorAttributeName: Palette.darkgrey.color])
            if safeBill.title.contains("disapproval") || safeBill.title.contains("Disapproving") && safeBill.title.characters.count >= 140 {
                greyBillNumber.append(NSAttributedString(string: "\n\nA \(safeBill.fullParty) sponsored resolution to overturn a previous rule."))
                return greyBillNumber
            } else {
                greyBillNumber.append(NSAttributedString(string: "\n\n\(safeBill.title)"))
                return greyBillNumber
            }
        } else {
            return NSAttributedString(string: self.eventDescription)
            
        }
    }
    
    var cleanCategory: String {
        var returnString = self.question
        if self.question.contains("On the") {
            returnString = returnString.replacingOccurrences(of: "On the ", with: "")
        }
        if returnString.contains("Cloture Motion") {
            returnString = returnString.replacingOccurrences(of: "Cloture Motion", with: "End the Debate On")
        }
        return returnString
        
    }
    
}


// MARK: - UI
extension Event {
    
    var memberPositions: NSMutableAttributedString? {
        let returnString = NSMutableAttributedString(string: "")
        for member in congressMembers {
            guard let event = member.events.filter({ $0 == self }).first else { return nil }
            
            let memberPicture = NSTextAttachment()
            memberPicture.image = cropCircularImage(for: member)
            memberPicture.bounds = CGRect(x: 0, y: -3, width: 35, height: 35)
            let memberPictureString = NSAttributedString(attachment: memberPicture)
            
            let memberNameString = NSMutableAttributedString(
                string: "" ,
                attributes: [:])
            
            let xImage = NSTextAttachment()
            xImage.image = #imageLiteral(resourceName: "X")
            xImage.bounds = CGRect(x: 0, y: -4, width: 28, height: 28)
            let xString = NSAttributedString(attachment: xImage)
            
            let checkImage = NSTextAttachment()
            checkImage.image = #imageLiteral(resourceName: "Check")
            checkImage.bounds = CGRect(x: 0, y: 0, width: 28, height: 28)
            let checkString = NSAttributedString(attachment: checkImage)
            
            switch event.position {
            case "Yes":
                memberNameString.append(memberPictureString)
                memberNameString.append(NSAttributedString(string: " "))
                memberNameString.append(checkString)
                memberNameString.append(NSAttributedString(string: "    "))
            case "No":
                memberNameString.append(memberPictureString)
                memberNameString.append(NSAttributedString(string: " "))
                memberNameString.append(xString)
                memberNameString.append(NSAttributedString(string: "    "))
            default:
                memberNameString.append(NSMutableAttributedString(string: event.position))
            }
            returnString.append(memberNameString)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .right
        returnString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, returnString.length))
        return returnString
    }
}
