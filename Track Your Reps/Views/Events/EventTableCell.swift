///
/// EventTableCell.swift
///

import UIKit

class EventTableCell: UITableViewCell {
    
    let categoryLabel = UITextView()
    let timeLabel = UILabel()
    let bodyLabel = UILabel()
    let memberActionLabel = UILabel()
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            event.isBill ? setUpBill(event) : setUpNonBill(event)
            memberActionLabel.attributedText = event.memberPositions
            timeLabel.text = timeSince(from: event.date)
        }
    }
    
    var views: [UIView] {
        return [categoryLabel, timeLabel, bodyLabel, memberActionLabel]
    }
    
    static let reuseID = "events"
    
    var margins: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        views.forEach { contentView.addSubview($0) }
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        _ = categoryLabel.then {
            $0.font = UIFont(name: "Montserrat-Regular", size: 16)
            $0.textColor =  Palette.white.color
            $0.backgroundColor = Palette.darkgrey.color
            $0.textContainerInset = UIEdgeInsetsMake(5, 30, 5, 13)
            $0.textAlignment = .left
            categoryLabel.isScrollEnabled = false
            categoryLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20).isActive = true
            categoryLabel.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor, multiplier: 0.7).isActive = true
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        }
        
        _ = timeLabel.then {
            $0.font = UIFont(name: "Montserrat-Regular", size: 16)
            $0.textColor = Palette.grey.color
            timeLabel.topAnchor.constraint(equalTo: categoryLabel.topAnchor).isActive = true
            timeLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        }
        
        _ = bodyLabel.then {
            $0.font = UIFont(name: "Montserrat-Regular", size: 16)
            $0.numberOfLines = 0
            $0.setLineHeight(lineHeight: 18)
            bodyLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 30).isActive = true
            bodyLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20).isActive = true
            bodyLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
        }
        
        _ = memberActionLabel.then {
            $0.font = UIFont(name: "Montserrat-Regular", size: 16)
            $0.attributedText = event?.memberPositions
            memberActionLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 30).isActive = true
            memberActionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            memberActionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            memberActionLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        }
    }
    
    func setUpBill(_ event: Event) {
        guard let safeBill = event.bill else { return }
        categoryLabel.text = safeBill.subject.uppercased()
        categoryLabel.backgroundColor = determineBackgroundColor(safeBill.subject)
        bodyLabel.text = event.cleanTitle
    }
    
    func setUpNonBill(_ event: Event) {
        categoryLabel.text = event.cleanQuestion.uppercased()
        bodyLabel.text = event.eventDescription
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.backgroundColor = Palette.darkgrey.color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
