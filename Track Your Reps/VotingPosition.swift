//
//  Members.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/1/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation

class VotingPosition {
    var description: String?
    var question: String?
    var date: String?
    var time: String?
    var position: String?
    
    init(description: String, question: String?, date: String, time: String?, position: Position?) {
        self.description = description
        self.question = question
        self.date = date
        self.time = time
        self.position = position?.rawValue
        
    }
    
}

enum Position: String
{
    case Yes = "Yes"
    case No = "No"
}
