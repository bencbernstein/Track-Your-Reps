///
/// RecentEventsVC.swift
///

import UIKit

class RecentEventsVC: UIViewController {
    
    var member: CongressMember?
    var viewTitle = UILabel()
    var recentDecision1 = UILabel()
    var recentDecisionSubtext1 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        setupViewTitle()
        setupRecentDecision1()
        setupConstraints()
    }
    
    func setupViewTitle() {
        viewTitle.text = "RECENT DECISIONS"
        viewTitle.font = UIFont(name: "Montserrat-Bold", size: 14)
    }
    
    func setupRecentDecision1() {
        
    }
}

// MARK: - Constraints
extension RecentEventsVC {
    
    func setupConstraints() {
        viewTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        viewTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
    }
}
