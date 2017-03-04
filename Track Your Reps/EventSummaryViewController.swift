//
//  EventSummaryViewController.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/4/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import UIKit

class EventSummaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        
        self.view.backgroundColor = UIColor.white
        
        let eventTitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Avenir-DemiBold", size: 16)
            label.text = "Event Title"
            return label
        }()
        
        let eventSummaryLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Avenir-Book", size: 12)
            label.text = "Event Summary. Nulla accumsan, lectus ac eleifend convallis, lectus mauris tristique enim, ut ultricies felis nibh a nisi. Fusce efficitur lectus eu ultrices condimentum. Pellentesque in elementum velit. Sed fermentum, dolor vel dapibus pretium, lacus."
            label.numberOfLines = 0
            return label
        }()
        
        let marginsGuide = view.layoutMarginsGuide
        
        view.addSubview(eventTitleLabel)
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventSummaryLabel)
        
        eventTitleLabel.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 80).isActive = true
        eventTitleLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 20).isActive = true
        eventTitleLabel.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.8).isActive = true
        
        eventSummaryLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 20).isActive = true
        eventSummaryLabel.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 20).isActive = true
        eventSummaryLabel.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.8).isActive = true
        
        
    }

}
