///
/// EventSummary.swift
///

import UIKit

class EventSummaryVC: UIViewController {
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            event.isBill ? setUpBill(event) : setUpNonBill(event)
            memberActionLabel.attributedText = event.memberPositions
        }
    }
    
    var titleLabel = UILabel()
    var summaryLabel = UILabel()
    var actionHistoryLabel = UILabel()
    var latestQuestion = UILabel()
    var memberActionLabel = UILabel()
    
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
        [titleLabel, summaryLabel, actionHistoryLabel, latestQuestion, memberActionLabel].forEach {
            view.addSubview($0) }
        
        setupLabels()
        
    }
    
    func setupLabels() {
        
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        titleLabel.textAlignment = .center
        
        summaryLabel.font = UIFont(name: "Garamond", size: 20)
        summaryLabel.textAlignment = .left
        
        actionHistoryLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        actionHistoryLabel.textAlignment = .center
        actionHistoryLabel.textColor = Palette.grey.color
        
        latestQuestion.font = UIFont(name: "Montserrat-Regular", size: 16)
        latestQuestion.textAlignment = .center
        
        memberActionLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        memberActionLabel.textAlignment = .center
        
        setupLabelConstraints()
    }

    
    func setupLabelConstraints() {
        [titleLabel, summaryLabel, actionHistoryLabel, latestQuestion, memberActionLabel].forEach { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20).isActive = true
            label.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.8).isActive = true
            label.numberOfLines = 0
        }
        titleLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 80).isActive = true
        summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        actionHistoryLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 20).isActive = true
        latestQuestion.topAnchor.constraint(equalTo: actionHistoryLabel.bottomAnchor, constant: 20).isActive = true
        memberActionLabel.topAnchor.constraint(equalTo: latestQuestion.bottomAnchor, constant: 20).isActive = true
    }
}

extension EventSummaryVC {
    
    func setUpBill(_ event: Event) {
        guard let safeBill = event.bill else { return }
        titleLabel.text = safeBill.subject.uppercased() + " BILL: " + safeBill.number
        summaryLabel.text = event.bill!.summary
        actionHistoryLabel.text = "This is where Oliver's sweet scroll component will go.".uppercased()
        latestQuestion.text = "LATEST ACTION: " + safeBill.latestMajorAction.uppercased()
        
    }
    
    func setUpNonBill(_ event: Event) {
   
        titleLabel.text = event.cleanTitle
        if event.eventDescription != String(describing: event.cleanTitle) {
            summaryLabel.text = event.eventDescription
        }
        actionHistoryLabel.text = "To make the nonbill scrollview, you have to look at all the merged events  that share the same description name, I think?".uppercased()
        latestQuestion.text = "LATEST ACTION: " + event.question.uppercased()

    }
}

