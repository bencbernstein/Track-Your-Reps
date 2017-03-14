///
/// MemberSummaryVC.swift
///

import Social
import UIKit

class MemberSummaryVC: UIViewController {
    
    let collapsableBar = UIImageView()
    let hideSummaryView = UIView()
    var SUMMARY_LABEL_LINE_HEIGHT: CGFloat = 4
    var nameLabel = UILabel()
    var member: CongressMember?
    let memberImage = UIImageView()
    let phoneImage = UIImageView()
    var shortDescriptionLabel = UILabel()
    var summaryHidden = true
    var summaryLabel = UILabel()
    var topConstraint: NSLayoutConstraint!
    let twitterImage = UIImageView()
    var WIKI_BIO_CHAR_LENGTH = 700
    let wikipediaLink = UILabel()
    
    var views: [UIView] {
        return [nameLabel, memberImage, shortDescriptionLabel, summaryLabel, wikipediaLink, hideSummaryView, collapsableBar, phoneImage, twitterImage]
    }
    
    var marginsGuide: UILayoutGuide {
        return view.layoutMarginsGuide
    }
    
    var viewDimensions: (h: CGFloat, w: CGFloat) {
        return (view.frame.size.height, view.frame.size.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Layout
extension MemberSummaryVC {
    
    func setupView() {
        self.view.backgroundColor = .white
        views.forEach { view.addSubview($0) }
        setupHideSummaryView()
        setupImage()
        setupNameLabel()
        setupPhoneImage()
        setupShortDescriptionLabel()
        setupSummaryLabel()
        setupTwitterImage()
        setupWikipediaLink()
        setupConstraints()
    }
    
    func setupHideSummaryView() {
        hideSummaryView.backgroundColor = .white
        
        let topBorder = UIView()
        hideSummaryView.addSubview(topBorder)
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        topBorder.backgroundColor = Palette.pink.color
        topBorder.widthAnchor.constraint(equalToConstant: viewDimensions.w).isActive = true
        topBorder.heightAnchor.constraint(equalToConstant: 2).isActive = true
        topBorder.topAnchor.constraint(equalTo: hideSummaryView.topAnchor).isActive = true
        
        setArrowImage(direction: "down")
        setupCollapsableBar()
        
        let recentEventsTitle = UILabel()
        let recentDecision1 = UILabel()
        let recentDecisionSubtext1 = UILabel()
        
        for label in [recentEventsTitle, recentDecision1, recentDecisionSubtext1] {
            hideSummaryView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leadingAnchor.constraint(equalTo: summaryLabel.leadingAnchor).isActive = true
        }
        
        recentEventsTitle.text = "RECENT DECISIONS"
        recentEventsTitle.font = UIFont(name: "Montserrat-Regular", size: 16)
        
        recentEventsTitle.topAnchor.constraint(equalTo: hideSummaryView.topAnchor, constant: 20).isActive = true
    
        let recentDecisions = member?.recentDecisions
        guard let decision1 = recentDecisions?[0] else { return }
        recentDecision1.text = decision1.0
        recentDecisionSubtext1.text = decision1.1
        
        recentDecision1.font = UIFont(name: "Montserrat-Regular", size: 12)
        recentDecisionSubtext1.font = UIFont(name: "Montserrat-Regular", size: 12)
        
        recentDecisionSubtext1.numberOfLines = 0
        recentDecisionSubtext1.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor).isActive = true
        
        recentDecision1.topAnchor.constraint(equalTo: recentEventsTitle.bottomAnchor, constant: 20).isActive = true

        recentDecisionSubtext1.topAnchor.constraint(equalTo: recentDecision1.bottomAnchor, constant: 5).isActive = true
    }
    
    func setupImage() {
        guard let member = member else { print("MemberSummaryVC -> No member"); return }
        memberImage.image = cropCircularImage(for: member)
    }
    
    func setupNameLabel() {
        nameLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
        nameLabel.text = member?.fullName.uppercased()
    }
    
    func setupPhoneImage() {
        phoneImage.image = #imageLiteral(resourceName: "Phone")
    }
    
    func setupShortDescriptionLabel() {
        shortDescriptionLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        shortDescriptionLabel.textColor = Palette.grey.color
        shortDescriptionLabel.text = member?.shortDescription
        shortDescriptionLabel.numberOfLines = 0
    }
    
    func setupSummaryLabel() {
        summaryLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        summaryLabel.numberOfLines = 0
        summaryLabel.text = member?.wikipediaBio.trunc(length: WIKI_BIO_CHAR_LENGTH, trailing: " . . .")
        summaryLabel.setLineHeight(lineHeight: SUMMARY_LABEL_LINE_HEIGHT)
        
        let border = UIView()
        summaryLabel.addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = Palette.pink.color
        border.widthAnchor.constraint(equalToConstant: viewDimensions.w).isActive = true
        border.heightAnchor.constraint(equalToConstant: 2).isActive = true
        border.topAnchor.constraint(equalTo: summaryLabel.topAnchor, constant: -viewDimensions.w * 0.05).isActive = true
    }
    
    func setupTwitterImage() {
        twitterImage.image = #imageLiteral(resourceName: "Twitter")
        setupTwitterLink()
    }
    
    func setArrowImage(direction: String) {
        guard let arrow = UIImage(named: "arrow_\(direction)") else { return }
        collapsableBar.image = resizeImage(image: arrow, newWidth: 40)
    }

    // MARK: - Constraints
    
    func setupConstraints() {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        setupCollapsableBarConstraints()
        setupHideSummaryViewConstraints()
        setupMemberImageConstraints()
        setupNameLabelConstraints()
        setupPhoneImageConstraints()
        setupShortDescriptionLabelConstraints()
        setupSummaryLabelConstraints()
        setupTwitterImageConstraints()
        setupWikipediaLinkConstraints()
    }
    
    func setupCollapsableBarConstraints() {
        collapsableBar.topAnchor.constraint(equalTo: hideSummaryView.topAnchor, constant: -20).isActive = true
        collapsableBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupHideSummaryViewConstraints() {
        topConstraint = hideSummaryView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height * -0.40)
        topConstraint.isActive = true
        hideSummaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hideSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hideSummaryView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupMemberImageConstraints() {
        memberImage.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: viewDimensions.w * 0.05).isActive = true
        memberImage.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor).isActive = true
        memberImage.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.33).isActive = true
        memberImage.heightAnchor.constraint(equalTo: memberImage.widthAnchor).isActive = true
    }
    
    func setupNameLabelConstraints() {
        nameLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: viewDimensions.w * 0.05).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: memberImage.trailingAnchor, constant: viewDimensions.w * 0.05).isActive = true
    }
    
    func setupPhoneImageConstraints() {
        phoneImage.bottomAnchor.constraint(equalTo: memberImage.bottomAnchor).isActive = true
        phoneImage.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        phoneImage.widthAnchor.constraint(equalTo: memberImage.heightAnchor, multiplier: 0.2).isActive = true
        phoneImage.heightAnchor.constraint(equalTo: twitterImage.widthAnchor).isActive = true
    }
    
    func setupShortDescriptionLabelConstraints() {
        shortDescriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        shortDescriptionLabel.centerYAnchor.constraint(equalTo: memberImage.centerYAnchor).isActive = true
        shortDescriptionLabel.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupSummaryLabelConstraints() {
        summaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        summaryLabel.topAnchor.constraint(equalTo: memberImage.bottomAnchor, constant: viewDimensions.w * 0.1).isActive = true
        summaryLabel.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    func setupTwitterImageConstraints() {
        twitterImage.bottomAnchor.constraint(equalTo: memberImage.bottomAnchor).isActive = true
        twitterImage.leadingAnchor.constraint(equalTo: phoneImage.trailingAnchor, constant: viewDimensions.w * 0.03).isActive = true
        twitterImage.widthAnchor.constraint(equalTo: memberImage.heightAnchor, multiplier: 0.2).isActive = true
        twitterImage.heightAnchor.constraint(equalTo: twitterImage.widthAnchor).isActive = true
    }
    
    func setupWikipediaLinkConstraints() {
        wikipediaLink.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 10).isActive = true
        wikipediaLink.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

// MARK: - Collapsable Text
extension MemberSummaryVC {
    
    func setupCollapsableBar() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.collapsableBarTapped(_:)))
        collapsableBar.isUserInteractionEnabled = true
        collapsableBar.addGestureRecognizer(singleTap)
    }
    
    func collapsableBarTapped(_ sender: UITapGestureRecognizer) {
        if summaryHidden {
            setArrowImage(direction: "up")
            self.topConstraint.constant += viewDimensions.h * 0.33
        } else {
            setArrowImage(direction: "down")
            self.topConstraint.constant -= viewDimensions.h * 0.33
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
        summaryHidden = !summaryHidden
    }
}

// MARK: - Links
extension MemberSummaryVC {
    
    // Mark: - Wikipedia
    func setupWikipediaLink() {
        wikipediaLink.font = UIFont(name: "Montserrat-Regular", size: 14)
        wikipediaLink.text = "Read full bio on Wikipedia"
        wikipediaLink.textColor = Palette.grey.color
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.wikipediaLinkTapped(_:)))
        wikipediaLink.isUserInteractionEnabled = true
        wikipediaLink.addGestureRecognizer(singleTap)
    }
    
    func wikipediaLinkTapped(_ sender: UITapGestureRecognizer) {
        guard let wikiLink = member?.wikipediaUrl else { return }
        if let url = URL(string: wikiLink) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Twitter
    func setupTwitterLink() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.twitterImageTapped(_:)))
        twitterImage.isUserInteractionEnabled = true
        twitterImage.addGestureRecognizer(singleTap)
    }
    
    func twitterImageTapped(_ sender: UITapGestureRecognizer) {
        guard let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) else { return }
        if let memberTwitter = member?.twitterAccount { vc.setInitialText("@\(memberTwitter)") }
        present(vc, animated: true)
    }
}
