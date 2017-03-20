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
    
    var labels: [UILabel] {
        return [timeLabel, bodyLabel, memberActionLabel]
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
         categoryLabel.backgroundColor = Palette.darkgrey.color
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
        contentView.addSubview(categoryLabel)
        
        setupLabels()
    }
    
    func setupLabels() {
        categoryLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        categoryLabel.textColor =  Palette.white.color
        categoryLabel.backgroundColor = Palette.darkgrey.color
        categoryLabel.textContainerInset = UIEdgeInsetsMake(5, 30, 5, 13)
        categoryLabel.textAlignment = .left
        
        timeLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        timeLabel.textColor = Palette.grey.color
        
        bodyLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        bodyLabel.setLineHeight(lineHeight: 18)
        
        memberActionLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        memberActionLabel.attributedText = event?.memberPositions
        
        setupConstraints()
    }
    
    
    func setupConstraints() {
        labels.forEach { setupCommonConstraints($0) }
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        setupUniqueConstraints()
    }
    
    func setupCommonConstraints(_ label: UILabel) {
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupUniqueConstraints() {
        
        categoryLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: contentView.frame.height * 0.4).isActive = true
        categoryLabel.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor, multiplier: 0.8).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        categoryLabel.isScrollEnabled = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.topAnchor.constraint(equalTo: categoryLabel.topAnchor).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        bodyLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: contentView.frame.height * 0.4).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -contentView.frame.width * 0.05).isActive = true
        bodyLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: contentView.frame.width * 0.05).isActive = true        
        
        memberActionLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: contentView.frame.height * 0.4).isActive = true
        memberActionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        memberActionLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
}

// MARK: - Bill or NonBill Specific Layout

extension EventTableCell {
    
    func setUpBill(_ event: Event) {
        guard let safeBill = event.bill else { return }
        categoryLabel.text = safeBill.subject.uppercased()
        categoryLabel.backgroundColor = determineBackgroundColor(safeBill.subject)
        
        let body = NSMutableAttributedString()
        
        let billNumber = multiColorText(
            textToColor: [
                (safeBill.number, Palette.darkgrey.color, UIFont(name: "Montserrat-Regular", size: 16)!)
            ],
            withImage: nil,
            at: 0
        )
        
        body.append(billNumber)
        body.append(NSAttributedString(string: "\n\n\(event.cleanTitle)"))
            
        bodyLabel.attributedText = body
    }
    
    func setUpNonBill(_ event: Event) {
        categoryLabel.text = event.cleanQuestion.uppercased()
        bodyLabel.text = event.eventDescription
    }
}
