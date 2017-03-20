///
/// RecentActions.swift
///

import UIKit
import Then

class RecentActions: UIView {
    
    var subheadings = [UILabel]()
    
    var member: CongressMember
    var screenWidth: CGFloat
    
    let RECENT_ACTIONS_COUNT = 2
    
    lazy var recentActions: [(heading: NSMutableAttributedString, subheading: String)] = self.getRecentDecisions()
    
    // TODO: - Figure out a way to get dimensions of superview
    // ideally we wouldn't want to pass width here
    init(member: CongressMember, screenWidth: CGFloat) {
        
        self.member = member
        self.screenWidth = screenWidth
        
        super.init(frame: CGRect.zero)
        
        for i in 0..<RECENT_ACTIONS_COUNT {
            layoutRecentAction(index: i)
        }
    }
    
    func layoutRecentAction(index: Int) {
        
        let heading = UILabel().then {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.attributedText = recentActions[index].heading
            $0.font = UIFont(name: "Montserrat-Regular", size: 14)
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        }
    
        let subheading = UILabel().then {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = recentActions[index].subheading
            $0.font = UIFont(name: "Garamond", size: 16)
            $0.numberOfLines = 0
            $0.setLineHeight(lineHeight: 6)
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: screenWidth * 0.9).isActive = true
            subheadings.append($0)
        }
        
        if index == 0 {
            heading.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        } else {
            heading.topAnchor.constraint(equalTo: subheadings[index-1].bottomAnchor, constant: 20).isActive = true
        }
        
        subheading.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 10).isActive = true
    }
    
    func getRecentDecisions() -> [(NSMutableAttributedString, String)] {
        return member.events.flatMap { event in
            let heading = multiColorText(
                textToColor: [
                    ("Voted", Palette.grey.color, UIFont(name: "Montserrat-Regular", size: 16)!),
                    (event.question.lowercased(), Palette.grey.color, UIFont(name: "Montserrat-Regular", size: 16)!)
                ],
                withImage: positionImage(event),
                at: 6
            )
            let subheading = event.eventDescription.trunc(length: 80)
            return (heading, subheading)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
