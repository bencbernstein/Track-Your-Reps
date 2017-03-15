///
/// RecentActions.swift
///

import UIKit
import Then

class RecentActions: UIView {
    
    var member: CongressMember
    var viewTitle: UILabel
    var subheadings = [UILabel]()
    
    let RECENT_ACTIONS_COUNT = 3
    
    lazy var recentActions: [(heading: NSMutableAttributedString, subheading: String)] = self.getRecentDecisions()
    
    init(member: CongressMember) {
        
        self.member = member
        
        viewTitle = UILabel()
        
        super.init(frame: CGRect.zero)
        
        _ = viewTitle.then {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = "RECENT DECISIONS"
            $0.font = UIFont(name: "Montserrat-Bold", size: 18)
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        }
    
        for i in 0..<RECENT_ACTIONS_COUNT {
            layoutRecentAction(index: i)
        }
    }
    
    func layoutRecentAction(index: Int) {
        
        let heading = UILabel().then {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.attributedText = recentActions[index].heading
            $0.font = UIFont(name: "Montserrat-Regular", size: 12)
        }
        
        let subheading = UILabel().then {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = recentActions[index].subheading
            $0.font = UIFont(name: "Montserrat-Regular", size: 12)
            subheadings.append($0)
        }
        
        if index == 0 {
            heading.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 20).isActive = true
        } else {
            heading.topAnchor.constraint(equalTo: subheadings[index-1].bottomAnchor, constant: 20).isActive = true
        }
        
        subheading.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 10).isActive = true
    }
    
    func getRecentDecisions() -> [(NSMutableAttributedString, String)] {
        return member.events.flatMap { event in
            guard let position = event.positionImage else { return nil }
            let heading = multiColorText(
                textToColor: [("Voted", Palette.grey.color), (event.question.lowercased(), Palette.grey.color)],
                withImage: position,
                at: 6
            )
            let subheading = event.eventDescription.trunc(length: 50)
            return (heading, subheading)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}