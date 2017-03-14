///
/// EventSummary.swift
///

import UIKit

class EventSummaryVC: UIViewController {
    
    var event: Event?
    
    var eventTitleLabel = UILabel()
    var eventSummaryLabel = UILabel()
    var eventMemberPositions = UILabel()
    
    var margins: UILayoutGuide {
        return view.layoutMarginsGuide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Layout

extension EventSummaryVC {
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        setupTitleLabel()
        setupSummaryLabel()
        setupMemberPositions()
        [eventTitleLabel, eventSummaryLabel, eventMemberPositions].forEach { view.addSubview($0) }
        setupLabelConstraints()
    }
    
    func setupTitleLabel() {
        eventTitleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        eventTitleLabel.text = event?.question.uppercased()
        eventTitleLabel.textAlignment = .center
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupMemberPositions() {
        eventMemberPositions.font = UIFont(name: "Montserrat-Regular", size: 12)
        eventMemberPositions.attributedText = event?.memberPositions
        eventMemberPositions.textAlignment = .center
        eventMemberPositions.numberOfLines = 0
    }
    
    func setupSummaryLabel() {
        eventSummaryLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        eventSummaryLabel.text = event?.eventDescription
        eventSummaryLabel.textAlignment = .center
        eventSummaryLabel.numberOfLines = 0
    }
    
    
    func setupLabelConstraints() {
        [eventTitleLabel, eventSummaryLabel, eventMemberPositions].forEach { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
            label.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.8).isActive = true
        }
        eventTitleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 80).isActive = true
        eventSummaryLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 20).isActive = true
        eventMemberPositions.topAnchor.constraint(equalTo: eventSummaryLabel.bottomAnchor, constant: 20).isActive = true
    }
}
