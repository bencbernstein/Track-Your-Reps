import UIKit

class FeedTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
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
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventSummaryVC = EventSummaryVC()
        self.navigationController?.pushViewController(eventSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableCell.reuseID, for: indexPath) as! FeedTableCell
        cell.eventTitleLabel.text = "Event Title Text."
        cell.eventActionLabel.text = "Event Action Text. This is a description of the event that has happened."
        cell.repActionLabel.text = "Rep voted [X]"
        return cell
    }
}
