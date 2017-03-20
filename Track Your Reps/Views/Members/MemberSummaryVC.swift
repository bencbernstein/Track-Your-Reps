///
/// MemberSummaryVC.swift
///

import Social
import UIKit

class MemberSummaryVC: UIViewController, UIScrollViewDelegate {
    
    let recentActionsTitle = UILabel()
    let recentActionsView = UIView()
    let recentActionsViewBorder = UIView()
    let memberImage = UIImageView()
    let nameLabel = UILabel()
    let phoneContainer = UIView()
    let shortDescriptionLabel = UILabel()
    let twitterContainer = UIView()
    let biographyBorder = UIView()
    let biographyScrollView = UIScrollView()
    let biographyLabel = UILabel()
    
    var member: CongressMember!
    var summaryHidden = true
    var recentActionsViewTopConstraint: NSLayoutConstraint!
    
    var views: [UIView] {
        return [nameLabel, memberImage, shortDescriptionLabel, phoneContainer, twitterContainer, biographyScrollView, biographyBorder, recentActionsView, recentActionsViewBorder, recentActionsTitle]
    }
    
    var margins: UILayoutGuide {
        return view.layoutMarginsGuide
    }
    
    var viewDimensions: (h: CGFloat, w: CGFloat) {
        return (view.frame.size.height, view.frame.size.width)
    }
    
    override func viewDidLoad() {
        
        views.forEach { view.addSubview($0) }
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        self.view.backgroundColor = .white
        
        _ = memberImage.then {
            $0.image = cropCircularImage(for: member)
            $0.topAnchor.constraint(equalTo: margins.topAnchor, constant: viewDimensions.w * 0.05).isActive = true
            $0.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.33).isActive = true
            $0.heightAnchor.constraint(equalTo: memberImage.widthAnchor).isActive = true
        }
        
        _ = nameLabel.then {
            $0.font = UIFont(name: "Montserrat-Light", size: 18)
            $0.text = member.fullName.uppercased()
            $0.topAnchor.constraint(equalTo: margins.topAnchor, constant: viewDimensions.w * 0.05).isActive = true
            $0.leadingAnchor.constraint(equalTo: memberImage.trailingAnchor, constant: viewDimensions.w * 0.05).isActive = true
            $0.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        }
        
        _ = shortDescriptionLabel.then {
            $0.font = UIFont(name: "Montserrat-Regular", size: 14)
            $0.textColor = Palette.grey.color
            $0.text = member.shortDescription
            $0.numberOfLines = 0
            $0.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        }
        
        setupContactButtons()
        setupBiographyScrollView()
        setupRecentActions()
    }
}


// MARK: - Contact Buttons
extension MemberSummaryVC {
    
    func setupContactButtons() {
        
        let imageSize = CGSize(width: viewDimensions.w * 0.1, height: viewDimensions.w * 0.1)
        let imageOrigin = CGPoint(x: 0, y: 0)
        let imageFrame = CGRect(origin: imageOrigin, size: imageSize)
        var hasTwitter = false
        
        if let twitterImageView = Twitter(account: member.twitterAccount, frame: imageFrame) {
            
            _ = twitterContainer.then {
                $0.addSubview(twitterImageView)
                $0.topAnchor.constraint(equalTo: shortDescriptionLabel.bottomAnchor, constant: 15).isActive = true
                $0.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
                $0.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                $0.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
            }
            hasTwitter = true
        }
        
        if let phoneImageView = Phone(number: member.phone.numbersOnly, frame: imageFrame) {
            
            let leadingAnchor = hasTwitter ?
                phoneImageView.leadingAnchor.constraint(equalTo: twitterContainer.leadingAnchor, constant: 60) :
                phoneImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
            
            _ = phoneContainer.then {
                $0.addSubview(phoneImageView)
                $0.topAnchor.constraint(equalTo: shortDescriptionLabel.bottomAnchor, constant: 15).isActive = true
                leadingAnchor.isActive = true
                $0.widthAnchor.constraint(equalToConstant: imageSize.width).isActive = true
                $0.heightAnchor.constraint(equalToConstant: imageSize.height).isActive = true
            }
        }
    }
}


// MARK: - Scrollview
extension MemberSummaryVC {
    
    func setupBiographyScrollView() {
        
        _ = biographyScrollView.then {
            $0.addSubview(biographyLabel)
            $0.topAnchor.constraint(equalTo: memberImage.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: recentActionsViewBorder.topAnchor).isActive = true
        }
        
        _ = biographyLabel.then {
            $0.font = UIFont(name: "Garamond", size: 18)
            $0.numberOfLines = 0
            $0.text = "\n\(member.wikipediaBio)\n"
            $0.setLineHeight(lineHeight: 6)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: biographyScrollView.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: biographyScrollView.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: biographyScrollView.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: biographyScrollView.trailingAnchor, constant: -20).isActive = true
            $0.widthAnchor.constraint(equalTo: biographyScrollView.widthAnchor, constant: -40).isActive = true
        }
        
        _ = biographyBorder.then {
            $0.backgroundColor = Palette.pink.color
            $0.widthAnchor.constraint(equalToConstant: viewDimensions.w).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
            $0.topAnchor.constraint(equalTo: biographyScrollView.topAnchor).isActive = true
        }
    }
}


// MARK: - Recent Actions
extension MemberSummaryVC {
    
    func setupRecentActions() {
        
        let recentActions = RecentActions(member: member, screenWidth: viewDimensions.w)
        
        let recentActionsHeaderTap = UITapGestureRecognizer(target: self, action: #selector(self.tappedRecentActionsHeader(_:)))

        _ = recentActionsView.then {
            $0.backgroundColor = .white
            $0.addSubview(recentActions)
            $0.addSubview(recentActionsTitle)
            $0.addGestureRecognizer(recentActionsHeaderTap)
            $0.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        let constraintConstant = tabBarController?.tabBar.frame.height ?? 50
        recentActionsViewTopConstraint = recentActionsView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -constraintConstant - 50)
        recentActionsViewTopConstraint.isActive = true
        
        _ = recentActionsTitle.then {
            $0.text = "RECENT DECISIONS"
            $0.font = UIFont(name: "Montserrat-Light", size: 18)
            $0.addSubview(recentActionsViewBorder)
            $0.isUserInteractionEnabled = true
     
            $0.topAnchor.constraint(equalTo: recentActionsView.topAnchor, constant: 15).isActive = true
            $0.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        }
        
        _ = recentActionsViewBorder.then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = Palette.pink.color
            $0.widthAnchor.constraint(equalToConstant: viewDimensions.w).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
            $0.topAnchor.constraint(equalTo: recentActionsView.topAnchor).isActive = true
        }
    }
    
    func tappedRecentActionsHeader(_ sender: UITapGestureRecognizer) {
        animateRecentActions()
        summaryHidden = !summaryHidden
    }
    
    func animateRecentActions() {
        self.recentActionsViewTopConstraint.constant += (summaryHidden ? viewDimensions.h * -0.33 : viewDimensions.h * 0.33)
        UIView.animate(withDuration: 0.5, animations: { self.view.layoutIfNeeded() })
    }
}
