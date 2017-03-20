///
///  TextSimplification.swift
///

import Foundation
import UIKit

typealias EventTitleSimplifier = Event
extension EventTitleSimplifier {
    
    var cleanTitle: String {
        if let bill = self.bill { return sanitizeTitle(for: bill) }
        return self.eventDescription
    }
    
    private func sanitizeTitle(for bill: Bill) -> String {
        let title = bill.title
        
        if isOverturning(title) && longerThan140Chars(title) {
            return "\(bill.sponsorPartyLong) sponsored resolution to overturn a previous rule."
        }
        return title
    }
    
    private func isOverturning(_ title: String) -> Bool {
        return title.lowercased().contains("disapprov")
    }
    
    private func longerThan140Chars(_ title: String) -> Bool {
        return title.characters.count >= 140
    }
    
}

extension String {
    
    var cleanAction: String {
        return self.removeParentheses()
                   .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var cleanSummary: String {
        return self.removeParentheses()
                   .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func removeParentheses() -> String {
        var result: [Character] = []
        var moveOn = false
        for character in self.characters {
            
            if character == "(" {
                moveOn = true
            }
            
            if !moveOn {
                result.append(character)
            }
            
            if character == ")" {
                moveOn = false
            }
        }
        
        return String(result)
    }
}



typealias EventCategorySimplifier = Event
extension EventCategorySimplifier {
    
    var categoryStringReplacements: [String : String] {
        return [
            "On the ": "",
            "Cloture Motion": "End the Debate On"
        ]
    }
    
    var cleanQuestion: String {
        var questionCopy = self.question
        categoryStringReplacements.forEach { str in
            questionCopy = questionCopy.replacingOccurrences(of: str.key, with: str.value)
        }
        return questionCopy
    }
}

typealias EventMemberPositions = Event
// TODO: - Refactor to either String or [Member] and create attributed elements in the Views
extension EventMemberPositions {
    
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


