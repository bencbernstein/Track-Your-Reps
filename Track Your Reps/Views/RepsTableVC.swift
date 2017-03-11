///
/// RepsTableVC.swift
///

import Moya
import SwiftyJSON
import UIKit

class RepsTableVC: UITableViewController {
    
    let congressMembers = User.sharedInstance.dataStore.members
        override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Palette.pink.color
        setupLayout()
    }
    
    func setupLayout() {
        self.tableView.backgroundColor = UIColor.lightGray
        self.tableView.rowHeight = view.frame.size.height / 8
        self.tableView.register(RepTableCell.self, forCellReuseIdentifier: RepTableCell.reuseID)
    }
}

// MARK: - Table View Methods
extension RepsTableVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return congressMembers.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repSummaryVC = RepSummaryVC()
        repSummaryVC.member = congressMembers[indexPath.row]
        self.navigationController?.pushViewController(repSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepTableCell.reuseID, for: indexPath) as! RepTableCell
        cell.member = congressMembers[indexPath.row]
        return cell
    }
}
