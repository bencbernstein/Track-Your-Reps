///
/// FeedTableVC.swift
///

import UIKit

class FeedTableVC: UITableViewController {
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEvents()
        setupLayout()
    }
    
    func setEvents() {
        let dataStore = User.sharedInstance.dataStore
        let uniqueEvents = Set(dataStore.members.flatMap({ $0.events }))
        events = Array(uniqueEvents)
    }
}


// MARK: - Layout

extension FeedTableVC {
    
    func setupLayout() {
        parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Marker"), landscapeImagePhone: #imageLiteral(resourceName: "Marker"), style: .plain, target: self, action: #selector(openOnBoard))
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(FeedTableCell.self, forCellReuseIdentifier: FeedTableCell.reuseID)
    }
    
    func openOnBoard() {
        let onboardVC = OnBoardViewController()
        present(onboardVC, animated: true, completion: nil)
    }
}


// MARK: - Table View Methods

extension FeedTableVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventSummaryVC = EventSummaryVC()
        eventSummaryVC.event = events[indexPath.row]
        self.navigationController?.pushViewController(eventSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableCell.reuseID, for: indexPath) as! FeedTableCell
        cell.event = events[indexPath.row]
        return cell
    }
}
