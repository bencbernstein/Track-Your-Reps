import Foundation
import SwiftyJSON
import Moya

class CongressMember {
    
    var api_uri: String
    var domain: String
    var dw_nominate: String
    var id: String
    var ideal_point: String
    var facebook_account: String
    var facebook_id: String
    var first_name: String
    var google_entity_id: String
    var last_name: String
    var middle_name: String
    var missed_votes: String
    var missed_votes_pct: String
    var next_election: String
    var party: String
    var rss_url: String
    var seniority: String
    var state: String
    var total_present: String
    var total_votes: String
    var twitter_account: String
    var url: String
    var votes_with_party_pct: String
    
    var events = [Event]()
    var wikipediaBio: String = ""
    
    
    var fullName: String {
        return "\(first_name) \(last_name)"
    }
    
    init?(from json: JSON) {
        self.id = json["id"].stringValue
        self.api_uri = json["api_uri"].stringValue
        self.first_name = json["first_name"].stringValue
        self.middle_name = json["middle_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.party = json["party"].stringValue
        self.twitter_account = json["twitter_account"].stringValue
        self.facebook_account = json["facebook_account"].stringValue
        self.facebook_id = json["facebook_id"].stringValue
        self.google_entity_id = json["google_entity_id"].stringValue
        self.url = json["url"].stringValue
        self.rss_url = json["rss_url"].stringValue
        self.domain = json["domain"].stringValue
        self.dw_nominate = json["dw_nominate"].stringValue
        self.ideal_point = json["ideal_point"].stringValue
        self.seniority = json["seniority"].stringValue
        self.next_election = json["next_election"].stringValue
        self.total_votes = json["total_votes"].stringValue
        self.missed_votes = json["missed_votes"].stringValue
        self.total_present = json["total_present"].stringValue
        self.state = json["state"].stringValue
        self.missed_votes_pct = json["missed_votes_pct"].stringValue
        self.votes_with_party_pct = json["votes_with_party_pct"].stringValue
        eventCall(for: id)
    }
}

typealias Events = CongressMember
extension Events {
    
    func eventCall(for id: String)  {
        
        let endpoint: ProPublicaAPI = .votesForMember(id: id)
        ProPublicaProvider.sharedProvider.request(endpoint) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = JSON(data: data)
                if let votes = json["results"][0]["votes"].array {
                    votes.forEach({ (vote) in
                        self.events.append(Event(from: vote, name: self.fullName)!)
                    })
                }
            default:
                print("awful")
            }
        }
    }
    
}


extension CongressMember {
    
    static func all(for state: String) -> [CongressMember] {
        let members = proPublicaJson()["results"][0]["members"].arrayValue
        var membersForState = members.flatMap { (member: JSON) -> CongressMember? in
            return member["state"].stringValue == state ? CongressMember(from: member) : nil
        }
        addBio(membersForState)
        return membersForState
    }
    
    private func addBio(for members: inout [CongressMember]) {
        biosJson().arrayValue.forEach { bioJson in
            guard let i = members.map({ $0.id }).index(of:  bioJson["id"].stringValue) else { return }
            members[i].wikipediaBio = bioJson["biography"].stringValue
       
        }
    }
    
    static func proPublicaJson() -> JSON {
        return jsonFromPath("SenateJSON")
    }
    
    private func biosJson() -> JSON {
        return jsonFromPath("SenateBiosJSON")
    }
    
    private func jsonFromPath(_ path: String) -> JSON {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        return JSON(data: jsonData! as Data)
    }
}

