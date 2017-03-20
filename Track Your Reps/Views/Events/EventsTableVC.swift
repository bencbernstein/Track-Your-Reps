///
/// EventsTableVC.swift
///

import UIKit

class EventsTableVC: UITableViewController {
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navComponents(title: "Home")
        
        setEvents()
        
        _ = tableView.then {
            $0.backgroundColor = Palette.pink.color
            $0.separatorColor = Palette.pink.color
            $0.estimatedRowHeight = 300
            $0.rowHeight = UITableViewAutomaticDimension
            $0.register(EventTableCell.self, forCellReuseIdentifier: EventTableCell.reuseID)
        }
    }
    
    func setEvents() {
        let dataStore = User.sharedInstance.dataStore
        let uniqueEvents = Set(dataStore.members.flatMap({ $0.events }))
        let sortedEvents = uniqueEvents.sorted { $0.0.date > $0.1.date }
        events = Array(sortedEvents)
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
        cell.layoutIfNeeded()
        return cell
    }
}
