///
/// MemberSummaryVC.swift
///

import Social
import UIKit

class MemberSummaryVC: UIViewController {
    
    let recentActionsTitle = UILabel()
    let recentActionsView = UIView()
    let recentActionsViewBorder = UIView()
    let memberImage = UIImageView()
    let nameLabel = UILabel()
    let phoneImage = UIImageView()
    let shortDescriptionLabel = UILabel()
    let summaryLabel = UILabel()
    let summaryLabelBorder = UIView()
    let twitterImage = UIImageView()
    let wikipediaLink = UILabel()
    
    var member: CongressMember!
    var summaryHidden = true
    let SUMMARY_LABEL_LINE_HEIGHT: CGFloat = 4
    var recentActionsViewTopConstraint: NSLayoutConstraint!
    let WIKI_BIO_CHAR_LENGTH = 500
    
    var views: [UIView] {
        return [nameLabel, memberImage, shortDescriptionLabel, phoneImage, twitterImage, summaryLabel, summaryLabelBorder, wikipediaLink, recentActionsView, recentActionsViewBorder, recentActionsTitle]
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
        }
        
        _ = shortDescriptionLabel.then {
            $0.font = UIFont(name: "Montserrat-Regular", size: 16)
            $0.textColor = Palette.grey.color
            $0.text = member.shortDescription
            $0.numberOfLines = 0
            $0.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: memberImage.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.5).isActive = true
        }
        
        _ = summaryLabel.then {
            $0.font = UIFont(name: "Montserrat-Regular", size: 16)
            $0.numberOfLines = 0
            $0.text = member.wikipediaBio.trunc(length: WIKI_BIO_CHAR_LENGTH, trailing: " . . .")
            $0.setLineHeight(lineHeight: SUMMARY_LABEL_LINE_HEIGHT)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: memberImage.bottomAnchor, constant: viewDimensions.w * 0.1).isActive = true
            $0.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
            $0.addSubview(summaryLabelBorder)
        }

        _ = summaryLabelBorder.then {
            $0.backgroundColor = Palette.pink.color
            $0.widthAnchor.constraint(equalToConstant: viewDimensions.w).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
            $0.topAnchor.constraint(equalTo: summaryLabel.topAnchor, constant: -viewDimensions.w * 0.05).isActive = true
        }
        
        // MARK: - Links
        
        let phoneTapped = UITapGestureRecognizer(target: self, action: #selector(self.phoneTapped(_:)))
        
        _ = phoneImage.then {
            $0.image = #imageLiteral(resourceName: "Phone")
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(phoneTapped)
            $0.bottomAnchor.constraint(equalTo: memberImage.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: memberImage.heightAnchor, multiplier: 0.2).isActive = true
            $0.heightAnchor.constraint(equalTo: twitterImage.widthAnchor).isActive = true
        }
        
        let twitterTapped = UITapGestureRecognizer(target: self, action: #selector(self.twitterTapped(_:)))
        
        _ = twitterImage.then {
            $0.image = #imageLiteral(resourceName: "Twitter")
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(twitterTapped)
            $0.bottomAnchor.constraint(equalTo: memberImage.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: viewDimensions.w * 0.03).isActive = true
            $0.widthAnchor.constraint(equalTo: memberImage.heightAnchor, multiplier: 0.2).isActive = true
            $0.heightAnchor.constraint(equalTo: twitterImage.widthAnchor).isActive = true
        }
        
        let wikipediaTapped = UITapGestureRecognizer(target: self, action: #selector(self.wikipediaTapped(_:)))
        
        _ = wikipediaLink.then {
            $0.font = UIFont(name: "Montserrat-Regular", size: 14)
            $0.text = "Read full bio on Wikipedia"
            $0.textColor = Palette.grey.color
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(wikipediaTapped)
            $0.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        
        setupRecentActions()
    }
    
    func phoneTapped(_ sender: UITapGestureRecognizer) {
        let phoneNumber = member.phone.numbersOnly
        if phoneNumber.noContent {
            print("MemberSummaryVC -> No phone number: \(member.fullName)")
            return
        }
        let number = "telprompt://\(phoneNumber)"
        open(scheme: number)
    }
    
    func twitterTapped(_ sender: UITapGestureRecognizer) {
        guard let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) else { return }
        vc.setInitialText("@\(member.twitterAccount)")
        present(vc, animated: true)
    }
    
    func wikipediaTapped(_ sender: UITapGestureRecognizer) {
        let url = member.wikipediaUrl
        if url.noContent {
            print("MemberSummaryVC -> No wikipedia link: \(member.fullName)")
            return
        }
        open(scheme: url)
    }
    
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            print("MemberSummaryVC -> Invalid URL: \(scheme)")
        }
    }
}


// MARK: - Recent Actions
extension MemberSummaryVC {
    
    func setupRecentActions() {
        
        let recentActions = RecentActions(member: member, screenWidth: viewDimensions.w)
        
        _ = recentActionsView.then {
            $0.backgroundColor = .white
            $0.addSubview(recentActions)
            $0.addSubview(recentActionsViewBorder)
            $0.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        recentActionsViewTopConstraint = recentActionsView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height * -0.075)
        recentActionsViewTopConstraint.isActive = true
        
        let recentActionsTapped = UITapGestureRecognizer(target: self, action: #selector(self.recentActionsTapped(_:)))
        
        _ = recentActionsTitle.then {
            $0.text = "RECENT DECISIONS"
            $0.font = UIFont(name: "Montserrat-Bold", size: 18)
            $0.topAnchor.constraint(equalTo: recentActionsView.topAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(recentActionsTapped)
        }
        
        _ = recentActionsViewBorder.then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = Palette.pink.color
            $0.widthAnchor.constraint(equalToConstant: viewDimensions.w).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 2).isActive = true
            $0.topAnchor.constraint(equalTo: recentActionsView.topAnchor).isActive = true
        }
    }
    
    func recentActionsTapped(_ sender: UITapGestureRecognizer) {
        if summaryHidden {
            self.recentActionsViewTopConstraint.constant -= viewDimensions.h * 0.33
        } else {
            self.recentActionsViewTopConstraint.constant += viewDimensions.h * 0.33
        }
        UIView.animate(withDuration: 0.5, animations: { self.view.layoutIfNeeded() })
        summaryHidden = !summaryHidden
    }
}

