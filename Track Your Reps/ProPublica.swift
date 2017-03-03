//
//  ProPublica.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/1/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import Alamofire

class ProPublica {
    
    let headers: HTTPHeaders = [
        "X-API-Key": "04VcutIuRh2JR6XjLRzVg2vwFpKe5vKXp4iuI0Yd",
        "Accept": "application/json"
    ]
    
    
    func fetchAllMembersForState(currentstate: String, completion: @escaping ([Member]) -> Void) {
        let url = "https://api.propublica.org/congress/v1/members/house/\(currentstate)/current.json"
        Alamofire.request(url, headers: headers).responseJSON { (response) in
            debugPrint(response)
            if let safeResponse = response.value as? [String: Any] {
                completion(self.parseAllMembers(response: safeResponse)!)
            }
            
        }
    }
    
    func fetchMember(memberID: String, completion: @escaping ([VotingPosition]) -> Void) {
        let url = "https://api.propublica.org/congress/v1/members/\(memberID)/votes.json"
        Alamofire.request(url, headers: headers).responseJSON { (response) in
            debugPrint(response)
            if let safeResponse = response.value as? [String: Any] {
                completion(self.parseMember(response: safeResponse)!)
            }
            
        }
    }
    
   
    func parseAllMembers(response: [String: Any]) -> [Member]? {
        guard let members = response["results"] as? [[String: Any]] else { print("couldn't get members"); return nil}
        var returnMembers = [Member]()
        for each in members {
            if let name = each["name"] as? String, let party = Party(rawValue: each["party"] as! String), let twitterID = each["twitter_id"] as? String, let id = each["member_id"] as? String {
                let newMember = Member(id: id, name: name, party: party, twitterID: twitterID, phone: 555555555)
                returnMembers.append(newMember)
            }
        }
        
        return returnMembers
        
    }
    
    func parseMember(response: [String: Any]) -> [VotingPosition]? {
        guard let member = response["results"] as? [[String: Any]] else { print("couldn't get members"); return nil}
        print("member is \(member)")
        guard let votes = member[0]["votes"] as? [Any] else { print("couldn't get votes"); return nil}
        print("got back \(votes.count) votes")
        var votingPositions = [VotingPosition]()
        for eachUnCast in votes {
            if let each = eachUnCast as? [String: Any] {
                if let position = each["position"] as? String, let description = each["description"] as? String, let date = each["date"] as? String {
                    let newPosition = VotingPosition(description: description, question: nil, date: date, time: nil, position: Position(rawValue: position)!)
                    votingPositions.append(newPosition)
                    print ("\(position) on \(description) at \(date)")
                }
            }
            
        }
 
        return votingPositions
        
    }
    
    // parse new memebers return dict
    func parseNew(response: [String: Any]) -> [String]? {
        guard let members = response["results"] as? [Any] else { print("couldn't get members"); return nil}
        print ("members are \(members)")
        guard let memberIndex = members[0] as? [String: Any] else { print("couldn't get memberindex"); return nil }
        guard let memberList = memberIndex["members"] as? [Any] else { print("couldn't get memberlist"); return nil}
        var memberArray = [String]()
        for each in memberList {
            let member = each as! [String : Any]
            guard let chamber = member["chamber"] as? String else { print("couldn't get chamber"); return nil }
            memberArray.append(chamber)
            print ("Member: \(member)")
        }
        return memberArray
    }
    
    // not used right now ...
    //    enum callType: String {
    //
    //        //case recentBill = "https://api.propublica.org/congress/v1/115/House/bills/introduced.json"
    //        case byMember = "https://api.propublica.org/congress/v1/members/"
    //        //case house = "https://api.propublica.org/congress/v1/members/new.json"
    //        case byDistrict = "https://api.propublica.org/congress/v1/members/house/"
    
    //    }
    
}
