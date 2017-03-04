//
//  BookTableViewCell.swift
//  DynamicCellHeightProgrammatic
//
//  Created by Satinder Singh on 7/3/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    let eventTitleLabel = UILabel()
    let eventActionLabel = UILabel()
    let repActionLabel = UILabel()
    
    static let reuseID = "feedcell"
    var hasAddedConstraints = false
    
    // MARK: Initalizers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if !hasAddedConstraints {
            let marginGuide = contentView.layoutMarginsGuide
            
            // configure titleLabel
            contentView.addSubview(eventTitleLabel)
            
            
            // configure authorLabel
            contentView.addSubview(eventActionLabel)
            
            eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            eventTitleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
            eventTitleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
            eventTitleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            
            eventTitleLabel.numberOfLines = 0
            eventTitleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)

            eventActionLabel.translatesAutoresizingMaskIntoConstraints = false
            eventActionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
            eventActionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            eventActionLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor).isActive = true
            eventActionLabel.numberOfLines = 0
            
            eventActionLabel.font = UIFont(name: "Avenir-Book", size: 12)
            eventActionLabel.textColor = UIColor.lightGray
            
            contentView.addSubview(repActionLabel)
            repActionLabel.translatesAutoresizingMaskIntoConstraints = false
            repActionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
            repActionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            repActionLabel.topAnchor.constraint(equalTo: eventActionLabel.bottomAnchor).isActive = true
            repActionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
            repActionLabel.numberOfLines = 0
            
            repActionLabel.font = UIFont(name: "Avenir-Book", size: 12)
            repActionLabel.textColor = UIColor.black
            repActionLabel.textAlignment = .right
            
            
           
          
            
        }
        hasAddedConstraints = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        eventTitleLabel.text = ""
        eventActionLabel.text = ""
    }
    
}
