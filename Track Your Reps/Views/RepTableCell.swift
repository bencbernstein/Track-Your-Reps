///
/// RepsTableCell.swift
///

import UIKit

class RepTableCell: UITableViewCell {
    
    let contactLabel = UILabel()
    let memberImage = UIImageView()
    let nameLabel = UILabel()
    let phoneImage = UIImageView()
    let twitterImage = UIImageView()
    
    var member: CongressMember? {
        didSet {
            guard let member = member else { return }
            memberImage.image = cropCircularImage(for: member)
            nameLabel.text = member.fullName.uppercased()
            nameLabel.textColor = member.partyColor()
        }
    }
    
    static let reuseID = "reps"
    
    var marginsGuide: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    var views: [UIView] {
        return [memberImage, nameLabel, contactLabel, twitterImage, phoneImage]
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
        setupTwitter()
        setupPhone()
        setupImage()
    }
    
    func setupNameLabel() {
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: memberImage.trailingAnchor, constant: 20).isActive = true
        nameLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
    }
    
    func setupPhone() {
        phoneImage.image = #imageLiteral(resourceName: "Phone")
        phoneImage.trailingAnchor.constraint(equalTo: twitterImage.leadingAnchor, constant: -20).isActive = true
        phoneImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        phoneImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.30).isActive = true
        phoneImage.heightAnchor.constraint(equalTo: phoneImage.widthAnchor).isActive = true
        
    }
    
    func setupTwitter() {
        twitterImage.image = #imageLiteral(resourceName: "Twitter")
        twitterImage.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        twitterImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        twitterImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        twitterImage.heightAnchor.constraint(equalTo: twitterImage.widthAnchor).isActive = true
    }
    
    func setupImage() {
        memberImage.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
        memberImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        memberImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        memberImage.widthAnchor.constraint(equalTo:  memberImage.heightAnchor).isActive = true
    }
}
