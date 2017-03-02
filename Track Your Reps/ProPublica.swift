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
    

    func fetchData(callType: callType, currentstate: String, completion: @escaping ([Member]) -> Void) {
        let url = callType.rawValue + "\(currentstate)/current.json"
        Alamofire.request(url, headers: headers).responseJSON { (response) in
            debugPrint(response)
            if let safeResponse = response.value as? [String: Any] {
                completion(self.parseDistrict(response: safeResponse)!)
            }
            
        }
    }
    
    
    
    // parse distict
    func parseDistrict(response: [String: Any]) -> [Member]? {
        guard let members = response["results"] as? [[String: Any]] else { print("couldn't get members"); return nil}
        var returnMembers = [Member]()
        for each in members {
            if let name = each["name"] as? String, let party = Party(rawValue: each["party"] as! String), let twitterID = each["twitter_id"] as? String {
                let newMember = Member(name: name, party: party, twitterID: twitterID, phone: 555555555)
                returnMembers.append(newMember)
            }
        }

        return returnMembers
        
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
    
    enum callType: String {
        case recentBill = "https://api.propublica.org/congress/v1/115/House/bills/introduced.json"
        case house = "https://api.propublica.org/congress/v1/members/new.json"
        case byDistrict = "https://api.propublica.org/congress/v1/members/house/"
        
    }
    
}
