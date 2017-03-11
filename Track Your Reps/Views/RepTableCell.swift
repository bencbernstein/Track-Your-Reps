///
/// RepsTableCell.swift
///

import UIKit

class RepTableCell: UITableViewCell {
    
    let contactLabel = UILabel()
    let memberImage = UIImageView()
    let nameLabel = UILabel()
    
    var member: CongressMember? {
        didSet {
            guard let member = member else { return }
            memberImage.image = cropCircularImage(for: member)
            nameLabel.text = member.fullName
        }
    }
    
    static let reuseID = "reps"
    
    var marginsGuide: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    var views: [UIView] {
        return [memberImage, nameLabel, contactLabel]
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
extension RepTableCell {
        
    func setupView() {
        views.forEach { contentView.addSubview($0) }
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        setupNameLabel()
        setupImage()
    }
    
    func setupNameLabel() {
        nameLabel.font = UIFont(name: "Avenir-Book", size: 12)
        nameLabel.textColor = .black
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: memberImage.trailingAnchor, constant: 10).isActive = true
    }
    
    func setupImage() {
        memberImage.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
        memberImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        memberImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        memberImage.widthAnchor.constraint(equalTo:  memberImage.heightAnchor).isActive = true
    }
}
