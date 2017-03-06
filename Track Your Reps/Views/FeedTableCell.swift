import UIKit

class FeedTableCell: UITableViewCell {
    
    let eventActionLabel = UILabel()
    let eventTitleLabel = UILabel()
    let repActionLabel = UILabel()

    var labels: [UILabel] {
        return [eventTitleLabel, eventActionLabel, repActionLabel]
    }
    
    static let reuseID = "events"
    
    var marginsGuide: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Layout

extension FeedTableCell {
    
    func setupView() {
        labels.forEach { contentView.addSubview($0) }
        setupLabels()
    }
    
    func setupLabels() {
        eventActionLabel.font = UIFont(name: "Avenir-Book", size: 12)
        eventActionLabel.textColor = .lightGray
        eventTitleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        repActionLabel.font = UIFont(name: "Avenir-Book", size: 12)
        repActionLabel.textAlignment = .right
        setupConstraints()
    }
    
    func setupConstraints() {
        labels.forEach { setupCommonConstraints($0) }
        setupUniqueConstraints()
    }
    
    func setupCommonConstraints(_ label: UILabel) {
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
    }
    
    func setupUniqueConstraints() {
        eventActionLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor).isActive = true
        eventTitleLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor).isActive = true
        eventTitleLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        repActionLabel.topAnchor.constraint(equalTo: eventActionLabel.bottomAnchor).isActive = true
        repActionLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor).isActive = true
    }
}
