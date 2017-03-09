///
/// FeedTableVC.swift
///

import UIKit

class FeedTableVC: UITableViewController {

    let reps = User.sharedInstance.dataStore.members
    var selectedEvents = [Event]()
    var eventDictionary: [Event : String] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard reps[0].events.count != 0 else { return }
        selectEventsForDisplay()
        tableView.reloadData()
    }
}


// MARK: - Select Events to Show

extension FeedTableVC {
    func selectEventsForDisplay() {
        reps.forEach { (rep) in
            for i in 0...4 {
                selectedEvents.append(rep.events[i])
            }
        }
        
        // sort by date
        selectedEvents.sort { $0.0.rawDate > $0.1.rawDate }
    
        // TODO: Sort here or add this logic to data store...
//        var alreadyExists: Set<Event> = []
//        
//        for event in selectedEvents {
//            
//            if alreadyExists.contains(event) {
//                
//                var repString = eventDictionary[event]!
//                repString += "\n" + event.repName! + " voted " + event.position!
//                eventDictionary[event] = repString
//
//            } else {
//                
//                alreadyExists.insert(event)
//                eventDictionary[event] = event.repName! + " voted " + event.position!
//                
//            }
//
//        }
   
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
    
    func addNotification() {
        let doneFetchingEvents = Notification.Name("doneFetchingEvents")
        NotificationCenter.default.addObserver(self, selector: #selector(self.viewWillAppear(_:)), name: doneFetchingEvents, object: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //print("number of rows are \(congressMembers[0].events.count)")
            return selectedEvents.count

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventSummaryVC = EventSummaryVC()
        self.navigationController?.pushViewController(eventSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableCell.reuseID, for: indexPath) as! FeedTableCell
        cell.eventTitleLabel.text = selectedEvents[indexPath.row].description
        cell.eventActionLabel.text = selectedEvents[indexPath.row].rawDate
        cell.repActionLabel.text = selectedEvents[indexPath.row].repName + " voted " + selectedEvents[indexPath.row].position
        return cell
    }
}
