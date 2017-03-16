///
/// EventsTableVC.swift
///

import UIKit

class EventsTableVC: UITableViewController {
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEvents()
        setupLayout()
    }
    
    func setEvents() {
        let dataStore = User.sharedInstance.dataStore
        let uniqueEvents = Set(dataStore.members.flatMap({ $0.events }))

        let sortedEvents = uniqueEvents.sorted { $0.0.date > $0.1.date }
        events = Array(sortedEvents)
    }
}


// MARK: - Layout

extension EventsTableVC {
    
    func setupLayout() {
        parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Marker"), landscapeImagePhone: #imageLiteral(resourceName: "Marker"), style: .plain, target: self, action: #selector(openOnBoard))
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(EventTableCell.self, forCellReuseIdentifier: EventTableCell.reuseID)
    }
    
    func openOnBoard() {
        let onboardVC = OnBoardViewController()
        present(onboardVC, animated: true, completion: nil)
    }
}


// MARK: - Table View Methods

extension EventsTableVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventSummaryVC = EventSummaryVC()
        eventSummaryVC.event = events[indexPath.row]
        self.navigationController?.pushViewController(eventSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableCell.reuseID, for: indexPath) as! EventTableCell
        cell.event = events[indexPath.row]
        return cell
    }
}
