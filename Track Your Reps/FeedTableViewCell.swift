//
//  FeedTableViewCell.swift
//  Track Your Reps
//
//  Created by Benjamin Bernstein on 3/4/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    static let reuseID = "feedcell"
    var hasAddedConstraints = false
    
    let eventTitleLabel: UILabel = {
        let label = UILabel()
        //label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let eventActionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let repActionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    // cell color
    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !hasAddedConstraints {
            let marginsGuide = contentView.layoutMarginsGuide
            contentView.addSubview(eventTitleLabel)
            eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            eventTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
            eventTitleLabel.widthAnchor.constraint(equalTo: marginsGuide.widthAnchor, multiplier: 0.6).isActive = true
            eventTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            // eventTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20).is
            //eventTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20).isActive = true
            
            contentView.addSubview(eventActionLabel)
            eventActionLabel.translatesAutoresizingMaskIntoConstraints = false

            eventActionLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 10).isActive = true
            eventActionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            eventActionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 0.8).isActive = true
            
            contentView.addSubview(repActionLabel)
            repActionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            repActionLabel.topAnchor.constraint(equalTo: eventActionLabel.bottomAnchor, constant: 10).isActive = true
            repActionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            repActionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 0.8).isActive = true
    
            

            
            hasAddedConstraints = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        eventTitleLabel.text = ""
        eventActionLabel.text = ""
    }
    
}
