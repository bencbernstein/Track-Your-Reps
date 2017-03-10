///
/// CongressMember.swift
///

import Foundation
import SwiftyJSON
import Moya


class CongressMember {
    
    // Data from ProPublica
    var apiUri: String
    var domain: String
    var dwNominate: String
    var id: String
    var idealPoint: String
    var events = [Event]()
    var facebookAccount: String
    var facebookId: String
    var firstName: String
    var googleEntityId: String
    var lastName: String
    var middleName: String
    var missedVotes: String
    var missedVotesPct: String
    var nextElection: String
    var party: String
    var rssUrl: String
    var seniority: String
    var state: String
    var totalPresent: String
    var totalVotes: String
    var twitterAccount: String
    var url: String
    var votesWithPartyPct: String
    
    var wikipediaBio: String = ""
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    init?(from json: JSON) {
        self.apiUri = json["api_uri"].stringValue
        self.domain = json["domain"].stringValue
        self.dwNominate = json["dw_nominate"].stringValue
        self.id = json["id"].stringValue
        self.idealPoint = json["ideal_point"].stringValue
        self.facebookAccount = json["facebook_account"].stringValue
        self.facebookId = json["facebook_id"].stringValue
        self.googleEntityId = json["google_entity_id"].stringValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.middleName = json["middle_name"].stringValue
        self.missedVotes = json["missed_votes"].stringValue
        self.missedVotesPct = json["missed_votes_pct"].stringValue
        self.nextElection = json["next_election"].stringValue
        self.party = json["party"].stringValue
        self.rssUrl = json["rss_url"].stringValue
        self.seniority = json["seniority"].stringValue
        self.state = json["state"].stringValue
        self.twitterAccount = json["twitter_account"].stringValue
        self.totalPresent = json["total_present"].stringValue
        self.totalVotes = json["total_votes"].stringValue
        self.url = json["url"].stringValue
        self.votesWithPartyPct = json["votes_with_party_pct"].stringValue
    }
    
    
    func fetchEvents(completion: @escaping ([Event]) -> Void) {
        
        let endpoint: ProPublicaAPI = .votesForMember(id: self.id)
        
        ProPublicaProvider.sharedProvider.request(endpoint) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = JSON(data: data)
                guard let votes = json["results"][0]["votes"].array else { return }
                let events = votes.map { Event(from: $0, for: self) }
                completion(events)
            default:
                print("Events call for member \(self.fullName) err'd.")
            }
        }
    }
}


typealias CongressMemberJsonParser = CongressMember
extension CongressMemberJsonParser {
    
    static func all(for state: String) -> [CongressMember] {
        let members = proPublicaJson()["results"][0]["members"].arrayValue
        var membersForState = members.flatMap { (member: JSON) -> CongressMember? in
            return member["state"].stringValue == state ? CongressMember(from: member) : nil
        }
        addBio(for: &membersForState)
        return membersForState
    }
    
    fileprivate static func addBio(for members: inout [CongressMember]) {
        biosJson().arrayValue.forEach { bioJson in
            guard let i = members.map({ $0.id }).index(of:  bioJson["id"].stringValue) else { return }
            members[i].wikipediaBio = bioJson["biography"].stringValue
        }
    }
    
    fileprivate static func proPublicaJson() -> JSON {
        return jsonFromPath("SenateJSON")
    }
    
    fileprivate static func biosJson() -> JSON {
        return jsonFromPath("SenateBiosJSON")
    }
    
    fileprivate static func jsonFromPath(_ path: String) -> JSON {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        return JSON(data: jsonData! as Data)
    }
}
