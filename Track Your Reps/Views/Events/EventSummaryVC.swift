///
/// EventSummary.swift
///

import UIKit
import Then

class EventSummaryVC: UIViewController, UIScrollViewDelegate {
    
    let titleLabel = UILabel()
    let summaryLabel = UILabel()
    var latestActionHeader = UILabel()
    var latestAction = UILabel()
    
    var memberActionLabel = UILabel()
    
    let actionsScrollView = UIScrollView()
    let actionsStackView = UIStackView()
    
    var actionsCount: Int? = nil
    var titleText = NSMutableAttributedString()
    var summaryText = ""
    
    let SCROLL_VIEW_HEIGHT: CGFloat = 115
    var ACTION_LABEL_WIDTH: CGFloat = 350
    
    var event: Event? {
        didSet {
            guard let event = event else { return }
            setupTexts(for: event)
            memberActionLabel.attributedText = event.memberPositions
        }
    }
    
    var views: [UIView] {
        return [titleLabel, summaryLabel, actionsScrollView, latestActionHeader, latestAction, memberActionLabel]
    }
    
    var viewDimensions: (h: CGFloat, w: CGFloat) {
        return (view.frame.size.height, view.frame.size.width)
    }
    
    var margins: UILayoutGuide {
        return view.layoutMarginsGuide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        actionsScrollView.delegate = self
        
        views.forEach { view.addSubview($0) }
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        _ = titleLabel.then {
            $0.attributedText = titleText
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.topAnchor.constraint(equalTo: margins.topAnchor, constant: viewDimensions.w * 0.05).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
        }
        
        _ = summaryLabel.then {
            $0.text = summaryText
            $0.font = UIFont(name: "Garamond", size: 18)
            $0.setLineHeight(lineHeight: 6)
            $0.numberOfLines = 8
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9).isActive = true
        }
        
        if let actionsCount = actionsCount {
            
            ACTION_LABEL_WIDTH = view.frame.width
            let stackViewSpacing: CGFloat = 25
            let stackViewWidth = CGFloat(actionsCount) * ACTION_LABEL_WIDTH + CGFloat(actionsCount - 1) * stackViewSpacing
            
            _ = actionsScrollView.then {
                $0.addSubview(actionsStackView)
                $0.backgroundColor = Palette.pink.color
                $0.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: viewDimensions.w * 0.05 ).isActive = true
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                $0.heightAnchor.constraint(equalToConstant: SCROLL_VIEW_HEIGHT).isActive = true
            }
            
            _ = actionsStackView.then {
                $0.axis = .horizontal
                $0.distribution = .equalSpacing
                $0.alignment = .center
                $0.spacing = stackViewSpacing
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.topAnchor.constraint(equalTo: actionsScrollView.topAnchor, constant: 10).isActive = true
                $0.leadingAnchor.constraint(equalTo: actionsScrollView.leadingAnchor, constant: 10).isActive = true
                $0.trailingAnchor.constraint(equalTo: actionsScrollView.trailingAnchor, constant: -10).isActive = true
                $0.bottomAnchor.constraint(equalTo: actionsScrollView.bottomAnchor).isActive = true
                $0.widthAnchor.constraint(equalToConstant: stackViewWidth).isActive = true
            }
            
            _ = memberActionLabel.then {
                $0.topAnchor.constraint(equalTo: actionsScrollView.bottomAnchor, constant: 20).isActive = true
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            }
        } else {
            
            _ = latestActionHeader.then {
                guard let event = event else { return }
                $0.text = event.eventDescription
                $0.font = UIFont(name: "Garamond", size: 18)
                $0.numberOfLines = 0
                $0.setLineHeight(lineHeight: 6)
                $0.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9).isActive = true
                $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            }
            
            _ = latestAction.then {
                
                $0.text = event?.question.uppercased()
                $0.font = UIFont(name: "Montserrat-Light", size: 16)
                $0.topAnchor.constraint(equalTo: latestActionHeader.bottomAnchor, constant: 30).isActive = true
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            }
            
            _ = memberActionLabel.then {
                $0.topAnchor.constraint(equalTo: latestAction.bottomAnchor, constant: 15).isActive = true
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            }
        }
    }
    
    func setupTexts(for event: Event) {
        
        if let bill = event.bill {
            
            titleText = multiColorText(
                textToColor: [
                    ("\(bill.subject.uppercased()) BILL\n", .black, UIFont(name: "Montserrat-Light", size: 18)!),
                    (bill.number, Palette.darkgrey.color, UIFont(name: "Montserrat-Regular", size: 14)!)
                ],
                withImage: nil, at: 0
            )
            
            summaryText = bill.summary.cleanSummary
            setupStackView(with: bill.actions)
        } else {
            
            titleText = multiColorText(
                textToColor: [("LATEST ACTION" + ": " + event.date.kindDate().uppercased(), .black, UIFont(name: "Montserrat-Light", size: 18)!)],
                withImage: nil, at: 0
            )
        }
    }
    
    func setupStackView(with actions: [[String : String]]) {
        
        actions.forEach { action in
            
            let attributedText = multiColorText(
                textToColor: [
                    ("\(action["date"]?.kindDate().uppercased() ?? "")\n", Palette.darkgrey.color, UIFont(name: "Montserrat-Regular", size: 16)!),
                    (action["description"]?.cleanAction ?? "", Palette.darkgrey.color, UIFont(name: "Garamond", size: 18)!)
                ],
                withImage: nil,
                at: 0
            )
            
            _ = UILabel().then {
                actionsStackView.addArrangedSubview($0)
                $0.attributedText = attributedText
                $0.textAlignment = .center
                $0.numberOfLines = 4
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.widthAnchor.constraint(equalToConstant: ACTION_LABEL_WIDTH).isActive = true
            }
            
        }
        
        if actions.count > 0 { actionsCount = actions.count }
    }
}
