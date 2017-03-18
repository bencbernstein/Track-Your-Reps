//
//  TextSimplification.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/17/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import UIKit

typealias EventTitleSimplifier = Event

extension EventTitleSimplifier {
    
    var cleanTitle: String {
        if self.isBill {
            guard let safeBill = self.bill else { return  "No Title" }
            if safeBill.title.contains("disapproval") || safeBill.title.contains("Disapproving") && safeBill.title.characters.count >= 140 {
                return "\(safeBill.fullParty) sponsored resolution to overturn a previous rule."
            }
            else {
                return safeBill.title
            }
        } else {
            return self.eventDescription
        }
    }
    
}

typealias EventCategorySimplifier = Event

extension EventCategorySimplifier {
    
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
