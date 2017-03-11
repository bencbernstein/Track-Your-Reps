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
            contactLabel.text = "Twitter: \(member.twitterAccount)"
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
        setupContactLabel()
        setupImage()
    }
    
    func setupNameLabel() {
        nameLabel.leadingAnchor.constraint(equalTo: memberImage.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        nameLabel.textColor = .black
    }
    
    func setupContactLabel() {
        contactLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        contactLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        contactLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        contactLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor).isActive = true
        contactLabel.numberOfLines = 0
        contactLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        contactLabel.textColor = .lightGray
    }
    
    func setupImage() {
        memberImage.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
        memberImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        memberImage.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.15).isActive = true
        memberImage.heightAnchor.constraint(equalTo: memberImage.widthAnchor).isActive = true
    }
}
