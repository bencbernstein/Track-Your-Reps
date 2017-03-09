///
/// FeedTableVC.swift
///

import UIKit

class FeedTableVC: UITableViewController {
    
    let congressMembers = User.sharedInstance.dataStore.members
    var allEvents = [Event]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        congressMembers.forEach { (member) in
            member.events.forEach({ (event) in
                allEvents.append(event)
            })
        }
        
        tableView.reloadData()
    }
}


// MARK: - Layout

extension FeedTableVC {
    
    func setupLayout() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(FeedTableCell.self, forCellReuseIdentifier: FeedTableCell.reuseID)
    }
}


// MARK: - Table View Methods

extension FeedTableVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (congressMembers.isEmpty) {
            return 0
        } else {
            return congressMembers[0].events.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventSummaryVC = EventSummaryVC()
        self.navigationController?.pushViewController(eventSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableCell.reuseID, for: indexPath) as! FeedTableCell
        
        cell.eventTitleLabel.text = allEvents[indexPath.row].description
        // cell.repActionLabel.text = allEvents[indexPath.row].repName! + " voted " + allEvents[indexPath.row].position!
        return cell
    }
}
