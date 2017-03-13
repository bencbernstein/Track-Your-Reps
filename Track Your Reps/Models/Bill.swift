///
/// Bill.swift
///

import Foundation
import SwiftyJSON

struct Bill {
    
    var committees: String
    var congressDotGovUrl: String
    var cosponsers: Int
    var latestMajorAction: String
    var sponsor: String
    var sponsorParty: String
    var sponsorState: String
    var subject: String
    var summary: String
    var title: String
    var type: String
    
    init(from json: JSON) {
        let results = json["results"][0]
        self.committees = results["committees"].stringValue
        self.congressDotGovUrl = results["congressdotgov_url"].stringValue
        self.cosponsers = results["cosponsers"].intValue 
        self.latestMajorAction = results["latest_major_action"].stringValue
        self.sponsor = results["sponsor"].stringValue
        self.sponsorParty = results["sponsor_party"].stringValue
        self.sponsorState = results["sponsor_state"].stringValue
        self.subject = results["primary_subject"].stringValue
        self.summary = results["summary_short"].stringValue
        self.title = results["title"].stringValue
        self.type = results["bill_type"].stringValue
    }
}
