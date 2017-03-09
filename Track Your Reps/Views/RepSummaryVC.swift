///
/// RepSummaryVC.swift
///

import UIKit

class RepSummaryVC: UIViewController {
    
    var nameLabel = UILabel()
    let collapsableBar = UIImageView()
    let memberImage = UIImageView()
    var summaryLabel = UILabel()
    let hideSummaryView = UIView()
    var summaryHidden = true
    
    var topConstraint: NSLayoutConstraint!
    
    var views: [UIView] {
        return [nameLabel, memberImage, summaryLabel, hideSummaryView, collapsableBar]
    }
    
    var member: CongressMember?
    
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

extension RepSummaryVC {
    
    func setupView() {
        self.view.backgroundColor = .white
        views.forEach { view.addSubview($0) }
        setupImage()
        setupNameLabel()
        setupSummaryLabel()
        setupHideSummaryView()
        setupConstraints()
    }
    
    func setupImage() {
        guard let member = member else { print("RepSummaryVC -> No member"); return }
        memberImage.image = cropCircularImage(for: member)
    }
    
    func setupNameLabel() {
        nameLabel.font = UIFont(name: "Avenir-DemiBold", size: 16)
        nameLabel.text = member?.fullName
        nameLabel.textAlignment = .center
    }
    
    func setupSummaryLabel() {
        summaryLabel.font = UIFont(name: "Avenir-Book", size: 12)
        summaryLabel.text = member?.wikipediaBio
        summaryLabel.numberOfLines = 0
    }
    
    func setupHideSummaryView() {
        hideSummaryView.backgroundColor = .gray
        setArrowImage(direction: "down")
        setupCollapsableBar()
    }
    
    func setArrowImage(direction: String) {
        guard let arrow = UIImage(named: "arrow_\(direction)") else { return }
        collapsableBar.image = resizeImage(image: arrow, newWidth: 50)
    }
    
    func setupCollapsableBar() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.collapsableBarTapped(_:)))
        singleTap.numberOfTapsRequired = 1
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
    
    // MARK: - Constraints
    
    func setupConstraints() {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        views.forEach { $0.centerXAnchor.constraint(equalTo: marginsGuide.centerXAnchor).isActive = true }
        setupMemberImageConstraints()
        setupNameLabelConstraints()
        setupSummaryLabelConstraints()
        setupHideSummaryVieweConstraints()
        setupCollapsableBarConstraints()
    }
    
    func setupMemberImageConstraints() {
        memberImage.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: viewDimensions.h * 0.1).isActive = true
        memberImage.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.33).isActive = true
        memberImage.heightAnchor.constraint(equalTo: memberImage.widthAnchor).isActive = true
    }
    
    func setupNameLabelConstraints() {
        nameLabel.topAnchor.constraint(equalTo: memberImage.bottomAnchor, constant: viewDimensions.w * 0.025).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor).isActive = true
    }
    
    func setupSummaryLabelConstraints() {
        summaryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: viewDimensions.w * 0.05).isActive = true
        summaryLabel.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor).isActive = true
    }
    
    func setupHideSummaryVieweConstraints() {
        topConstraint = hideSummaryView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height * -0.33)
        topConstraint.isActive = true
        hideSummaryView.leadingAnchor.constraint( equalTo: view.leadingAnchor).isActive = true
        hideSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hideSummaryView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupCollapsableBarConstraints() {
        collapsableBar.topAnchor.constraint(equalTo: hideSummaryView.topAnchor, constant: -25).isActive = true
    }
}
