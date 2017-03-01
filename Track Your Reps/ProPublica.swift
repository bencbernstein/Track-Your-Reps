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
    
    let testURL = "https://api.propublica.org/congress/v1/members/new.json"
    let houseURL = "https://api.propublica.org/congress/v1/members/house/NY/12/current.json"
    
        // completion: @escaping ([Any]) -> Void, progressCompletion: @escaping (Double) -> ())
    func houseCall(completion: @escaping ([Member]) -> Void) {
        Alamofire.request(houseURL, headers: headers).responseJSON { (response) in
            debugPrint(response)
            if let safeResponse = response.value as? [String: Any] {
                completion(self.parseDistrict(response: safeResponse)!)
            }
            
        }
    }
    
    func parseDistrict(response: [String: Any]) -> [Member]? {
       // var memberArray = [String]()
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
    
}
