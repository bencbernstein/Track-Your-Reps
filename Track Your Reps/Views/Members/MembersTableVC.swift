///
/// MembersTableVC.swift
///

import Moya
import SwiftyJSON
import UIKit

class MembersTableVC: UITableViewController {
    
    let congressMembers = User.sharedInstance.dataStore.members
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Palette.pink.color
        setupLayout()
    }
    
    func setupLayout() {
        self.tableView.backgroundColor = UIColor.lightGray
        self.tableView.rowHeight = view.frame.size.height / 8
        self.tableView.register(MemberTableCell.self, forCellReuseIdentifier: MemberTableCell.reuseID)
    }
}

// MARK: - Table View Methods
extension MembersTableVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return congressMembers.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memberSummaryVC = MemberSummaryVC()
        memberSummaryVC.member = congressMembers[indexPath.row]
        self.navigationController?.pushViewController(memberSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableCell.reuseID, for: indexPath) as! MemberTableCell
        cell.member = congressMembers[indexPath.row]
        return cell
    }
}
