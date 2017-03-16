///
/// EventTableCell.swift
///

import UIKit

class EventTableCell: UITableViewCell {
    
    let eventCategoryLabel = UITextView()
    let eventTimeLabel = UILabel()
    let eventTitleLabel = UILabel()
    let memberActionLabel = UILabel()
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            memberActionLabel.attributedText = event.memberPositions
            eventTimeLabel.text = formatDate(event.date)
            switch event.isBill {
            case true:
                setUpBill(event)
            case false:
                setUpNonBill(event)
            }
            
        }
    }
    
    var labels: [UILabel] {
        return [eventTitleLabel, memberActionLabel, eventTimeLabel]
    }
    
    static let reuseID = "events"
    
    var margins: UILayoutGuide {
        return contentView.layoutMarginsGuide
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func reset() {
         eventCategoryLabel.backgroundColor = Palette.darkgrey.color

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

extension EventTableCell {
    
    func setupView() {
        labels.forEach { contentView.addSubview($0) }
        contentView.addSubview(eventCategoryLabel)
        contentView.addSubview(eventTimeLabel)
        setupLabels()
    }
    
    func setupLabels() {
        eventCategoryLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        eventCategoryLabel.textColor =  Palette.white.color
        eventCategoryLabel.backgroundColor = Palette.darkgrey.color
        
        // TODO: calculate this more effectively without breaking constraints
        eventCategoryLabel.textContainerInset = UIEdgeInsetsMake(8, 30, 8, 15)
        eventCategoryLabel.textAlignment = .left
        
        eventTimeLabel.font = UIFont(name: "Montserrat-Light", size: 16)
        eventTimeLabel.textColor = Palette.grey.color
        
        eventTitleLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
        eventTitleLabel.setLineHeight(lineHeight: 12)
        
        memberActionLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        memberActionLabel.attributedText = event?.memberPositions
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        labels.forEach { setupCommonConstraints($0) }
        eventTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTimeLabel.numberOfLines = 0
        eventCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setupUniqueConstraints()
    }
    
    func setupCommonConstraints(_ label: UILabel) {
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupUniqueConstraints() {
        
        eventCategoryLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: contentView.frame.height * 0.4).isActive = true
        eventCategoryLabel.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor, multiplier: 0.8).isActive = true
        eventCategoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        eventCategoryLabel.isScrollEnabled = false
        eventCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        eventTimeLabel.topAnchor.constraint(equalTo: eventCategoryLabel.topAnchor).isActive = true
        eventTimeLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        eventTitleLabel.topAnchor.constraint(equalTo: eventCategoryLabel.bottomAnchor, constant: contentView.frame.height * 0.4).isActive = true
        eventTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -contentView.frame.width * 0.05).isActive = true
        eventTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: contentView.frame.width * 0.05).isActive = true        
        
        memberActionLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: contentView.frame.height * 0.4).isActive = true
        memberActionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        memberActionLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
    
    func formatDate(_ date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        
        let date: Date? = dateFormatterGet.date(from: date)
        
        return dateFormatter.timeSince(from: date!)
    }
}

// MARK: - Bill or NonBill Specific Layout

extension EventTableCell {
    
    func setUpBill(_ event: Event) {
        guard let safeBill = event.bill else { return }
        eventCategoryLabel.text = safeBill.subject.uppercased()
        eventCategoryLabel.backgroundColor = determineBackgroundColor(safeBill.subject)
        eventTitleLabel.attributedText = event.cleanTitle
        
    }
    
    func setUpNonBill(_ event: Event) {
        eventCategoryLabel.text = event.cleanCategory.uppercased()
        eventTitleLabel.attributedText = event.cleanTitle
    }
}
