//
//  ViewController.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/1/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //@IBOutlet var tableView: UITableView!
    var members = [Member]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.rowHeight = 125
        
        let proPublicaAPI = ProPublica()
        proPublicaAPI.apiCall(callType: .test) { (returnMembers) in
            for member in returnMembers {
                self.members.append(member)
            }
            print("results are \(self.members)")
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! MainCell
        cell.nameLabel.text = members[indexPath.row].name
        cell.partyLabel.text = String(describing: members[indexPath.row].party)
        cell.twitterLabel.text = "@" + "\(members[indexPath.row].twitterID)"
        cell.recentLabel.text = "Voting on Intelligence Bill in 30 minutes"
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    


}

