///
/// FeedTableCell.swift
///

import UIKit

class FeedTableCell: UITableViewCell {
    
    let eventQuestionLabel = UILabel()
    let eventTimeLabel = UILabel()
    let eventDescriptionLabel = UILabel()
    let repActionLabel = UILabel()
    
    var event: Event? {
        didSet {
            eventQuestionLabel.text = event?.question
            eventDescriptionLabel.text = event?.eventDescription
            repActionLabel.attributedText = event?.memberPositions
            eventTimeLabel.text = event?.date
        }
    }
    
    var leftLabels: [UILabel] {
        return [eventQuestionLabel, eventDescriptionLabel, repActionLabel]
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
        leftLabels.forEach { contentView.addSubview($0) }
        contentView.addSubview(eventTimeLabel)
        setupLabels()
    }
    
    func setupLabels() {
        eventQuestionLabel.font = UIFont(name: "Montserrat-Light", size: 14)
        eventQuestionLabel.textColor = .lightGray
        
        eventTimeLabel.font = UIFont(name: "Montserrat-Light", size: 12)
        eventTimeLabel.textColor = .lightGray
        
        eventDescriptionLabel.font = UIFont(name: "Montserrat-Light", size: 14)
        repActionLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        leftLabels.forEach { setupCommonConstraints($0) }
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTimeLabel.numberOfLines = 0
        setupUniqueConstraints()
    }
    
    func setupCommonConstraints(_ label: UILabel) {
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: contentView.frame.width * 0.05).isActive = true
    }
    
    func setupUniqueConstraints() {
        
        eventQuestionLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: contentView.frame.height * 0.3).isActive = true
        eventQuestionLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        
        eventTimeLabel.topAnchor.constraint(equalTo: eventQuestionLabel.topAnchor).isActive = true
        eventTimeLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        
        eventDescriptionLabel.topAnchor.constraint(equalTo: eventQuestionLabel.bottomAnchor, constant: contentView.frame.height * 0.1).isActive = true
        eventDescriptionLabel.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor, constant: -contentView.frame.width * 0.1).isActive = true
        
        repActionLabel.topAnchor.constraint(equalTo: eventDescriptionLabel.bottomAnchor, constant: contentView.frame.height * 0.3).isActive = true
        repActionLabel.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor).isActive = true
    }
}
