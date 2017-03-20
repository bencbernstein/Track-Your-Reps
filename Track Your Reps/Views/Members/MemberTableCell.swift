///
/// MembersTableCell.swift
///

import Then
import UIKit

class MemberTableCell: UITableViewCell {
    
    let memberImage: UIImageView
    let nameLabel: UILabel
    let phoneContainer: UIView
    let twitterContainer: UIView
    
    var views: [UIView] {
        return [memberImage, nameLabel, twitterContainer, phoneContainer]
    }
    
    var member: CongressMember? {
        didSet {
            guard let member = member else { return }
            memberImage.image = cropCircularImage(for: member)
            nameLabel.text = member.fullName.uppercased()

            setupLinks(for: member)
        }
    }
    
    static let reuseID = "members"
    
    var margins: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    var viewDimensions: (h: CGFloat, w: CGFloat) {
        return (contentView.frame.size.height, contentView.frame.size.width)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        memberImage = UIImageView()
        nameLabel = UILabel()
        phoneContainer = UIView()
        twitterContainer = UIView()
        
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
            $0.font = UIFont(name: "Montserrat-Regular", size: 14)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Contact

extension MemberTableCell {
    
    func setupLinks(for member: CongressMember) {
        
        let imageSize = CGSize(width: viewDimensions.w * 0.075, height: viewDimensions.w * 0.075)
        let imageOrigin = CGPoint(x: 0, y: 0)
        let imageFrame = CGRect(origin: imageOrigin, size: imageSize)
        
        if let phoneImageView = Phone(number: member.phone.numbersOnly, frame: imageFrame) {
            
            _ = phoneContainer.then {
                $0.addSubview(phoneImageView)
                $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
                $0.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10).isActive = true
                $0.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                $0.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
            }
            
        }
        
        if let twitterImageView = Twitter(account: member.twitterAccount, frame: imageFrame) {
            
            _ = twitterContainer.then {
                $0.addSubview(twitterImageView)
                $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
                $0.trailingAnchor.constraint(equalTo: phoneContainer.leadingAnchor, constant: -25).isActive = true
                $0.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                $0.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
            }
            
        }
    }
}
