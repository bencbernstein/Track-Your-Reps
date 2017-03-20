///
/// EventSummary.swift
///

import UIKit
import Then

class EventSummaryVC: UIViewController, UIScrollViewDelegate {
    
    let titleLabel = UILabel()
    let summaryLabel = UILabel()
    var latestQuestionLabel = UILabel()
    var memberActionLabel = UILabel()
    
    let actionsScrollView = UIScrollView()
    let actionsStackView = UIStackView()
    
    var actionsCount: Int? = nil
    var titleText = NSMutableAttributedString()
    var summaryText = ""
    var latestQuestionText = NSMutableAttributedString()
    
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
        return [titleLabel, summaryLabel, actionsScrollView, latestQuestionLabel, memberActionLabel]
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
            $0.font = UIFont(name: "Garamond", size: 16)
            $0.setLineHeight(lineHeight: 6)
            $0.numberOfLines = 8
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9).isActive = true
        }
        
        var actionHistoryPresent = false
        
        if let actionsCount = actionsCount {
            
            ACTION_LABEL_WIDTH = view.frame.width
            let stackViewSpacing: CGFloat = 25
            let stackViewWidth = CGFloat(actionsCount) * ACTION_LABEL_WIDTH + CGFloat(actionsCount - 1) * stackViewSpacing
            
            _ = actionsScrollView.then {
                $0.addSubview(actionsStackView)
                $0.layer.borderWidth = 2
                $0.layer.borderColor = Palette.pink.color.cgColor
                $0.topAnchor.constraint(equalTo: view.topAnchor, constant: viewDimensions.h * 0.45).isActive = true
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -2).isActive = true
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 2).isActive = true
                $0.heightAnchor.constraint(equalToConstant: SCROLL_VIEW_HEIGHT).isActive = true
            }
            
            _ = actionsStackView.then {
                $0.axis = .horizontal
                $0.distribution = .equalSpacing
                $0.alignment = .leading
                $0.spacing = stackViewSpacing
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.topAnchor.constraint(equalTo: actionsScrollView.topAnchor, constant: 10).isActive = true
                $0.leadingAnchor.constraint(equalTo: actionsScrollView.leadingAnchor, constant: 10).isActive = true
                $0.trailingAnchor.constraint(equalTo: actionsScrollView.trailingAnchor, constant: -10).isActive = true
                $0.bottomAnchor.constraint(equalTo: actionsScrollView.bottomAnchor).isActive = true
                $0.widthAnchor.constraint(equalToConstant: stackViewWidth).isActive = true
            }
            
            actionHistoryPresent = true
            
        }
        
        let latestQuestionLabelTopAnchorConstraint = actionHistoryPresent ?
            latestQuestionLabel.topAnchor.constraint(equalTo: actionsScrollView.bottomAnchor, constant: 10) :
            latestQuestionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50)
        
        _ = latestQuestionLabel.then {
            $0.attributedText = latestQuestionText
            $0.numberOfLines = 4
            latestQuestionLabelTopAnchorConstraint.isActive = true
            $0.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: summaryLabel.trailingAnchor).isActive = true
        }
        
        _ = memberActionLabel.then {
            $0.topAnchor.constraint(equalTo: latestQuestionLabel.bottomAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    func setupTexts(for event: Event) {
        
        if let bill = event.bill {
            titleText = multiColorText(
                textToColor: [
                    ("\(bill.subject.uppercased()) BILL\n", .black, UIFont(name: "Montserrat-Light", size: 18)!),
                    (bill.number, Palette.grey.color, UIFont(name: "Montserrat-Regular", size: 14)!)
                ],
                withImage: nil, at: 0)
            summaryText = bill.summary.cleanSummary
            latestQuestionText = multiColorText(
                textToColor: [
                    ("LATEST ACTION", .black, UIFont(name: "Montserrat-Light", size: 18)!),
                    ("\n\(bill.latestMajorAction)", .black, UIFont(name: "Garamond", size: 16)!)
                ],
                withImage: nil, at: 0)
            setupStackView(with: bill.actions)
        } else {
            titleText = multiColorText(
                textToColor: [(event.eventDescription, .black, UIFont(name: "Montserrat-Light", size: 18)!)],
                withImage: nil, at: 0)
            latestQuestionText = multiColorText(
                textToColor: [
                    ("LATEST ACTION", .black, UIFont(name: "Montserrat-Light", size: 18)!),
                    ("\n\(event.question)", .black, UIFont(name: "Garamond", size: 16)!)
                ],
                withImage: nil, at: 0)
        }
        
    }
    
    func setupStackView(with actions: [[String : String]]) {
        
        actions.forEach { action in
            
            let attributedText = multiColorText(
                textToColor: [
                    ("\(action["date"]?.kindDate().uppercased() ?? "")\n", Palette.darkgrey.color, UIFont(name: "Montserrat-Regular", size: 14)!),
                    (action["description"]?.cleanAction ?? "", .black, UIFont(name: "Montserrat-Regular", size: 14)!)
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
