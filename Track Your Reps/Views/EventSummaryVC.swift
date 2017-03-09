///
/// EventSummary.swift
///

import UIKit

class EventSummaryVC: UIViewController {
    
    var eventTitleLabel = UILabel()
    var eventSummaryLabel = UILabel()
    
    var marginsGuide: UILayoutGuide {
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
        [eventTitleLabel, eventSummaryLabel].forEach { view.addSubview($0) }
        setupLabelConstraints()
    }
    
    func setupTitleLabel() {
        eventTitleLabel.font = UIFont(name: "Avenir-DemiBold", size: 16)
        eventTitleLabel.text = "Event Title"
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupSummaryLabel() {
        eventSummaryLabel.font = UIFont(name: "Avenir-Book", size: 12)
        eventSummaryLabel.text = "Event Summary. Nulla accumsan, lectus ac eleifend convallis, lectus mauris tristique enim, ut ultricies felis nibh a nisi. Fusce efficitur lectus eu ultrices condimentum. Pellentesque in elementum velit. Sed fermentum, dolor vel dapibus pretium, lacus."
        eventSummaryLabel.numberOfLines = 0
    }
    
    func setupLabelConstraints() {
        [eventTitleLabel, eventSummaryLabel].forEach { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 20).isActive = true
            label.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.8).isActive = true
        }
        eventTitleLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 80).isActive = true
        eventSummaryLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 20).isActive = true
    }
}
