///
/// MembersTableCell.swift
///

import Then
import UIKit

class MemberTableCell: UITableViewCell {
    
    let memberImage: UIImageView
    let nameLabel: UILabel
    let phoneImage: UIImageView
    let twitterImage: UIImageView
    
    var views: [UIView] {
        return [memberImage, nameLabel, twitterImage, phoneImage]
    }
    
    var member: CongressMember? {
        didSet {
            guard let member = member else { return }
            memberImage.image = cropCircularImage(for: member)
            nameLabel.text = member.fullName.uppercased()
            nameLabel.textColor = member.partyColor()
        }
    }
    
    static let reuseID = "members"
    
    var margins: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        memberImage = UIImageView()
        nameLabel = UILabel()
        phoneImage = UIImageView()
        twitterImage = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        views.forEach { contentView.addSubview($0) }
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        _ = memberImage.then {
            $0.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
            $0.widthAnchor.constraint(equalTo:  memberImage.heightAnchor).isActive = true
        }
        
        _ = nameLabel.then {
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: memberImage.trailingAnchor, constant: 20).isActive = true
            $0.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            $0.font = UIFont(name: "Montserrat-Regular", size: 12)
        }
        
        _ = phoneImage.then {
            $0.image = #imageLiteral(resourceName: "Phone")
            $0.trailingAnchor.constraint(equalTo: twitterImage.leadingAnchor, constant: -20).isActive = true
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.30).isActive = true
            $0.heightAnchor.constraint(equalTo: phoneImage.widthAnchor).isActive = true
        }
        
        _ = twitterImage.then {
            $0.image = #imageLiteral(resourceName: "Twitter")
            $0.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
            $0.heightAnchor.constraint(equalTo: twitterImage.widthAnchor).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
