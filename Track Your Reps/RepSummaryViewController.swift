//
//  EventSummaryViewController.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/4/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import UIKit

class RepSummaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        
        self.view.backgroundColor = UIColor.white
        
        let eventTitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Avenir-DemiBold", size: 16)
            label.text = "Rep Name"
            return label
        }()
        
        let repSummaryLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Avenir-Book", size: 12)
            label.text = "Rep Summary. Kristen Gillibrand is Praesent ut dui at mi tempus aliquet.Donec tincidunt tristique dapibus. Etiam sem justo, consectetur at varius sed, tristique ac dui. Sed mattis mattis gravida. Phasellus molestie, enim sit amet tincidunt cursus,"
            label.numberOfLines = 0
            return label
        }()
        
        let marginsGuide = view.layoutMarginsGuide
        
        view.addSubview(eventTitleLabel)
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        repSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(repSummaryLabel)
        
        eventTitleLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 80).isActive = true
        eventTitleLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 20).isActive = true
        eventTitleLabel.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.8).isActive = true
        
        repSummaryLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 20).isActive = true
        repSummaryLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 20).isActive = true
        repSummaryLabel.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.8).isActive = true
        
        
    }
    
}
