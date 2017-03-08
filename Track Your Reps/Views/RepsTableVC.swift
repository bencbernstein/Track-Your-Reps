import UIKit
import Moya
import SwiftyJSON

class RepsTableVC: UITableViewController {
    
    var congressMembers = [CongressMember]()
    
    var userState: String {
        return UserDefaults.standard.string(forKey: "state")!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congressMembers = CongressMember.all(for: "NY")
        print(congressMembers)
        setupLayout()
    }
}


// MARK: - Layout
    
extension RepsTableVC {
    
    func setupLayout() {
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(RepTableCell.self, forCellReuseIdentifier: RepTableCell.reuseID)
    }
}


// MARK: - Table View Methods

extension RepsTableVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return congressMembers.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repSummaryVC = RepSummaryVC()
        self.navigationController?.pushViewController(repSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepTableCell.reuseID, for: indexPath) as! RepTableCell
        // cell.repImage.image = #imageLiteral(resourceName: "kirsten_gillibrand")
        let member = congressMembers[indexPath.row]
        cell.repNameLabel.text = member.fullName
        cell.repContactLabel.text = "Twitter: \(member.twitter_account)"
        return cell
    }
}
