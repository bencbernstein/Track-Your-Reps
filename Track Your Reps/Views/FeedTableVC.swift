///
/// FeedTableVC.swift
///

import UIKit

class FeedTableVC: UITableViewController {
    
    let congressMembers = User.sharedInstance.dataStore.members

   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
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
//        if (congressMembers.isEmpty) {
//            return 0
//        } else {
//            return congressMembers[0].events.count
//        }
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventSummaryVC = EventSummaryVC()
        self.navigationController?.pushViewController(eventSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableCell.reuseID, for: indexPath) as! FeedTableCell
        
//        cell.eventTitleLabel.text = allEvents[indexPath.row].description
//        // cell.repActionLabel.text = allEvents[indexPath.row].repName! + " voted " + allEvents[indexPath.row].position!
        return cell
    }
}
