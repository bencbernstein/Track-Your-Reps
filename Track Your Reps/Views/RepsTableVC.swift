import UIKit

class RepsTableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repSummaryVC = RepSummaryVC()
        self.navigationController?.pushViewController(repSummaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepTableCell.reuseID, for: indexPath) as! RepTableCell
        cell.repImage.image = #imageLiteral(resourceName: "kirsten_gillibrand")
        cell.repNameLabel.text = "Rep Name"
        cell.repContactLabel.text = "Phone // Twitter "
        return cell
    }
}
