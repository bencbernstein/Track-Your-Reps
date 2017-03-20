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
    var titleText = ""
    var summaryText = ""
    var latestQuestionText = ""
    
    let STACK_VIEW_HEIGHT: CGFloat = 150
    let ACTION_LABEL_WIDTH: CGFloat = 250
    
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
            $0.text = titleText
            $0.font = UIFont(name: "Montserrat-Regular", size: 18)
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.topAnchor.constraint(equalTo: margins.topAnchor, constant: 30).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9).isActive = true
        }
        
        _ = summaryLabel.then {
            $0.text = summaryText
            $0.font = UIFont(name: "Garamond", size: 18)
            $0.textAlignment = .left
            $0.numberOfLines = 8
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9).isActive = true
        }
        
        var actionHistoryPresent = false
        
        if let actionsCount = actionsCount {
            
            let stackViewSpacing: CGFloat = 40
            let stackViewWidth = CGFloat(actionsCount) * ACTION_LABEL_WIDTH + CGFloat(actionsCount - 1) * stackViewSpacing
            
            _ = actionsScrollView.then {
                $0.addSubview(actionsStackView)
                $0.layer.borderWidth = 2
                $0.layer.borderColor = Palette.pink.color.cgColor
                $0.topAnchor.constraint(equalTo: view.topAnchor, constant: viewDimensions.h * 0.4).isActive = true
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -2).isActive = true
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 2).isActive = true
                $0.heightAnchor.constraint(equalToConstant: STACK_VIEW_HEIGHT).isActive = true
            }
            
            _ = actionsStackView.then {
                $0.axis = .horizontal
                $0.distribution = .equalSpacing
                $0.alignment = .leading
                $0.spacing = stackViewSpacing
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.topAnchor.constraint(equalTo: actionsScrollView.topAnchor).isActive = true
                $0.leadingAnchor.constraint(equalTo: actionsScrollView.leadingAnchor, constant: 10).isActive = true
                $0.trailingAnchor.constraint(equalTo: actionsScrollView.trailingAnchor, constant: -10).isActive = true
                $0.bottomAnchor.constraint(equalTo: actionsScrollView.bottomAnchor).isActive = true
                $0.widthAnchor.constraint(equalToConstant: stackViewWidth).isActive = true
            }
            
            actionHistoryPresent = true
            
        }
        
        let latestQuestionLabelTopAnchor = actionHistoryPresent ? actionsScrollView.bottomAnchor : titleLabel.bottomAnchor
        
        _ = latestQuestionLabel.then {
            $0.text = latestQuestionText
            $0.font = UIFont(name: "Montserrat-Regular", size: 16)
            $0.numberOfLines = 0
            $0.topAnchor.constraint(equalTo: latestQuestionLabelTopAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: summaryLabel.trailingAnchor).isActive = true
        }
        
        _ = memberActionLabel.then {
            $0.topAnchor.constraint(equalTo: latestQuestionLabel.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor).isActive = true
        }
    }
    
    func setupTexts(for event: Event) {
        
        if let bill = event.bill {
            titleText = "\(bill.subject.uppercased()) BILL\n\(bill.number)"
            summaryText = bill.summary.cleanSummary
            latestQuestionText = "LATEST ACTION: \(bill.latestMajorAction.uppercased())"
            setupStackView(with: bill.actions)
        } else {
            titleText = event.eventDescription
            latestQuestionText = "LATEST ACTION: \(event.question.uppercased())"
        }
        
    }
    
    func setupStackView(with actions: [[String : String]]) {
        
        actions.forEach { action in
            
            let attributedText = multiColorText(
                textToColor: [
                    ("\n\(action["date"]?.kindDate() ?? "")\n\n", Palette.darkgrey.color, UIFont(name: "Montserrat-Regular", size: 16)!),
                    (action["description"]?.cleanAction ?? "", .black, UIFont(name: "Garamond", size: 16)!)
                ],
                withImage: nil,
                at: 0
            )
            
            _ = UILabel().then {
                actionsStackView.addArrangedSubview($0)
                $0.attributedText = attributedText
                $0.textAlignment = .center
                $0.numberOfLines = 7
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.widthAnchor.constraint(equalToConstant: ACTION_LABEL_WIDTH).isActive = true
            }
            
        }
        
        if actions.count > 0 { actionsCount = actions.count }
    }
}
